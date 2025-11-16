#!/bin/bash
# Stream-JSON Parser for Real-Time Progress Visibility
# Parses Claude CLI stream-json output and displays human-friendly progress

# Colors
# shellcheck disable=SC2034
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Track last activity for heartbeat
LAST_ACTIVITY=$(date +%s)
THINKING_INDICATOR=""
ACTIVITY_INDICATOR="."

# Background heartbeat showing we're alive
show_heartbeat() {
    local count=0
    while true; do
        sleep 2
        if [ -n "$THINKING_INDICATOR" ]; then
            ELAPSED=$(($(date +%s) - LAST_ACTIVITY))
            # Rotate activity indicator
            case $((count % 4)) in
                0) ACTIVITY_INDICATOR="⠋";;
                1) ACTIVITY_INDICATOR="⠙";;
                2) ACTIVITY_INDICATOR="⠹";;
                3) ACTIVITY_INDICATOR="⠸";;
            esac
            echo -ne "\r${CYAN}${ACTIVITY_INDICATOR} Working... ${ELAPSED}s elapsed    ${NC}" >&2
            count=$((count + 1))
        fi
    done
}

# Start heartbeat in background
show_heartbeat &
HEARTBEAT_PID=$!
# shellcheck disable=SC2064
trap "kill $HEARTBEAT_PID 2>/dev/null; echo -ne '\r                                  \r' >&2" EXIT

# Parse stream-json line by line
while IFS= read -r line; do
    LAST_ACTIVITY=$(date +%s)

    # Skip empty lines
    [ -z "$line" ] && continue

    # Extract event type (gracefully handle non-JSON lines)
    EVENT_TYPE=$(echo "$line" | jq -r '.type // empty' 2>/dev/null)

    case "$EVENT_TYPE" in
        "system")
            MODEL=$(echo "$line" | jq -r '.model // "unknown"')
            SESSION=$(echo "$line" | jq -r '.session_id // "unknown"' | cut -c1-8)
            echo -e "${GREEN}🚀 Claude initialized${NC}"
            echo -e "${CYAN}   Model: ${MODEL}${NC}"
            echo -e "${CYAN}   Session: ${SESSION}...${NC}"
            echo ""
            ;;

        "stream_event")
            SUB_TYPE=$(echo "$line" | jq -r '.event.type // empty' 2>/dev/null)
            case "$SUB_TYPE" in
                "message_start")
                    THINKING_INDICATOR="yes"
                    echo -ne "\r${YELLOW}💭 Thinking...${NC}                    \r"
                    ;;

                "content_block_start")
                    THINKING_INDICATOR=""
                    BLOCK_TYPE=$(echo "$line" | jq -r '.content_block.type // empty' 2>/dev/null)
                    if [ "$BLOCK_TYPE" = "text" ]; then
                        echo -ne "\r${CYAN}📝 Response:${NC}                      \r"
                    fi
                    ;;

                "content_block_delta")
                    THINKING_INDICATOR=""
                    # Extract text delta
                    TEXT=$(echo "$line" | jq -r '.event.delta.text // empty' 2>/dev/null)
                    if [ -n "$TEXT" ]; then
                        # Clear heartbeat line and print text
                        echo -ne "\r                                  \r"
                        echo -n "$TEXT"
                    fi
                    ;;

                "content_block_stop")
                    echo ""  # Newline after text stream
                    ;;

                "message_stop")
                    THINKING_INDICATOR=""
                    echo -ne "\r${GREEN}✓ Response complete${NC}              \n"
                    ;;
            esac
            ;;

        "assistant")
            # Check for tool use
            TOOL_NAME=$(echo "$line" | jq -r '.message.content[]? | select(.type=="tool_use") | .name' 2>/dev/null | head -1)
            if [ -n "$TOOL_NAME" ]; then
                TOOL_INPUT=$(echo "$line" | jq -c '.message.content[]? | select(.type=="tool_use") | .input' 2>/dev/null)
                echo -ne "\r                                  \r"
                echo -e "${BLUE}🔧 Tool: ${BOLD}${TOOL_NAME}${NC}"

                # Show truncated input for context
                if [ -n "$TOOL_INPUT" ]; then
                    INPUT_PREVIEW=$(echo "$TOOL_INPUT" | jq -c '.' 2>/dev/null | head -c 60)
                    echo -e "${CYAN}   Input: ${INPUT_PREVIEW}...${NC}"
                fi
            fi
            ;;

        "user")
            # Tool result received
            echo -ne "\r                                  \r"
            echo -e "${GREEN}📥 Tool execution complete${NC}"
            ;;

        "result")
            # Final result summary
            DURATION=$(echo "$line" | jq -r '.duration_ms // 0')
            COST=$(echo "$line" | jq -r '.total_cost_usd // 0')
            INPUT_TOKENS=$(echo "$line" | jq -r '.usage.input_tokens // 0')
            OUTPUT_TOKENS=$(echo "$line" | jq -r '.usage.output_tokens // 0')
            CACHE_READ=$(echo "$line" | jq -r '.usage.cache_read_input_tokens // 0')

            # Convert ms to human-readable
            if [ "$DURATION" -gt 60000 ]; then
                MINS=$((DURATION / 60000))
                SECS=$(((DURATION % 60000) / 1000))
                DURATION_STR="${MINS}m ${SECS}s"
            elif [ "$DURATION" -gt 1000 ]; then
                SECS=$((DURATION / 1000))
                DURATION_STR="${SECS}s"
            else
                DURATION_STR="${DURATION}ms"
            fi

            echo ""
            echo -e "${BOLD}${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            echo -e "${BOLD}${GREEN}✅ Task Complete${NC}"
            echo -e "${BOLD}${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            echo -e "${CYAN}   Duration: ${BOLD}${DURATION_STR}${NC}"
            echo -e "${CYAN}   Tokens: ${BOLD}${INPUT_TOKENS}${NC} in / ${BOLD}${OUTPUT_TOKENS}${NC} out"
            [ "$CACHE_READ" -gt 0 ] && echo -e "${CYAN}   Cached: ${BOLD}${CACHE_READ}${NC} tokens"
            echo -e "${CYAN}   Cost: ${BOLD}\$${COST}${NC}"
            echo ""
            ;;
    esac
done

# Cleanup
kill $HEARTBEAT_PID 2>/dev/null
echo -ne "\r                                  \r" >&2
