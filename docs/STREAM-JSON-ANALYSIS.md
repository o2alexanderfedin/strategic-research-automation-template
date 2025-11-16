# Stream-JSON Output Format Analysis

## Overview

The `--output-format stream-json` flag provides a **structured, real-time event stream** from Claude CLI.

## Event Types

### 1. System Events
```json
{"type":"system","subtype":"init","cwd":"...","session_id":"...","tools":[...],"model":"..."}
```
- Emitted once at start
- Contains session metadata, available tools, model info
- Useful for initialization

### 2. Streaming Events (with `--include-partial-messages`)
```json
{"type":"stream_event","event":{"type":"message_start",...}}
{"type":"stream_event","event":{"type":"content_block_start",...}}
{"type":"stream_event","event":{"type":"content_block_delta","delta":{"text":"Code"}}}
{"type":"stream_event","event":{"type":"content_block_delta","delta":{"text":" flows"}}}
{"type":"stream_event","event":{"type":"content_block_stop",...}}
{"type":"stream_event","event":{"type":"message_stop"}}
```
- Real-time word-by-word streaming
- Each delta is a small text chunk (word or phrase)
- Allows building UI with typewriter effect

### 3. Assistant Messages
```json
{"type":"assistant","message":{"role":"assistant","content":[{"type":"text","text":"..."}]}}
```
- Complete assistant response
- Includes tool uses if any

### 4. User Messages (Tool Results)
```json
{"type":"user","message":{"role":"user","content":[{"type":"tool_result","content":"..."}]}}
```
- Tool execution results
- Includes system reminders

### 5. Result Summary
```json
{"type":"result","subtype":"success","duration_ms":4871,"result":"...","usage":{...},"total_cost_usd":0.02}
```
- Final execution summary
- Includes timing, token usage, costs
- Success/error status

## Streaming Delta Events Structure

When using `--include-partial-messages`:

```
message_start          → Message begins
content_block_start    → Content block begins (text, tool_use, etc.)
content_block_delta    → Incremental text chunks (multiple)
  ├─ delta.text: "Code"
  ├─ delta.text: " flows"
  ├─ delta.text: " like"
  └─ delta.text: " water"
content_block_stop     → Content block complete
message_delta          → Metadata update (stop_reason, usage)
message_stop           → Message complete
```

## Comparison: Default vs Stream-JSON

### Default Output (Human-Readable)
```
I'll read the first 5 lines of the CHANGELOG.md file.

The first 5 lines of CHANGELOG.md are:
...
```

**Pros:**
- ✅ Human-readable
- ✅ Clean, formatted text
- ✅ Easy for rookies to understand
- ✅ Works with existing shell tools (grep, less, etc.)

**Cons:**
- ❌ No structured metadata
- ❌ Hard to parse programmatically
- ❌ Can't distinguish tool use from text
- ❌ No real-time streaming visibility

### Stream-JSON Output
```json
{"type":"assistant","message":{...}}
{"type":"user","message":{...}}
{"type":"result",...}
```

**Pros:**
- ✅ Structured, parseable data
- ✅ Real-time streaming deltas
- ✅ Complete metadata (costs, timing, tokens)
- ✅ Programmatic integration
- ✅ Can extract specific events
- ✅ See tool execution in detail

**Cons:**
- ❌ Not human-readable raw
- ❌ Requires JSON parsing
- ❌ More complex for simple use cases
- ❌ Rookies see JSON blobs, not friendly text

## Use Cases

### When to Use Default Output
- **Human consumption** - reading in terminal
- **Simple scripts** - grep/sed/awk processing
- **Logging** - human-readable logs
- **Rookie experience** - clear, understandable output

### When to Use Stream-JSON
- **UI development** - building GUIs with real-time updates
- **Programmatic parsing** - extracting metadata, costs, timing
- **Event processing** - reacting to specific events
- **Monitoring/metrics** - tracking token usage, costs
- **Testing/CI** - structured output for automated checks

## Recommendation for Automation Scripts

### For `run-full.sh`:

**DO NOT use stream-json** for rookie mode because:

1. **Unreadable for Rookies**
   ```
   {"type":"stream_event","event":{"type":"content_block_delta","index":0,"delta":{"type":"text_delta","text":"Code"}}}
   ```
   vs
   ```
   Code flows like water...
   ```

2. **Requires Parsing**
   - Would need `jq` or custom JSON parser
   - Adds complexity and dependencies
   - Slows down output processing

3. **Existing Verbosity Works**
   - Default output + unbuffered I/O already provides real-time visibility
   - Human-readable progress messages
   - No JSON parsing overhead

### When Stream-JSON WOULD Be Useful:

**Advanced Mode** - Optional flag for power users:
```bash
./scripts/run-full.sh --machine-readable
```

Could output stream-json and pipe through parser to show:
- Progress bar with exact token counts
- Real-time cost tracker
- Structured event logging
- Metrics dashboard

**Example Advanced Usage:**
```bash
# Stream-JSON with real-time parsing
claude --output-format stream-json --include-partial-messages -p "..." \
  | jq -r 'select(.type=="stream_event" and .event.type=="content_block_delta") | .event.delta.text' \
  | tr -d '\n'
```

This extracts just the text deltas, recreating typewriter effect.

## Conclusion

### For Rookie-Friendly Automation
**Recommendation: Keep using default output**

Reasons:
- ✅ Already unbuffered for real-time visibility
- ✅ Human-readable (rookies understand it)
- ✅ Works with standard shell tools
- ✅ No additional dependencies (jq, parsers)
- ✅ Simple and reliable

### For Advanced/Power Users
**Recommendation: Add optional stream-json mode**

Could provide:
- More detailed progress tracking
- Cost/token monitoring
- Structured event logs
- Machine-parseable output

But **NOT as default** for rookies.

## Technical Implementation Notes

If we wanted to support both:

```bash
# claude-eng wrapper
if [ "$MACHINE_READABLE" = true ]; then
    # Stream-JSON mode
    exec "$CLAUDE_EXEC" --output-format stream-json \
        --include-partial-messages ... | process_stream_json.sh
else
    # Human-readable mode (default)
    exec "$CLAUDE_EXEC" ... 2>&1 >&2
fi
```

Where `process_stream_json.sh` would:
1. Parse JSON events with `jq`
2. Extract text deltas
3. Show progress indicators from metadata
4. Display human-friendly output

But this adds significant complexity for minimal benefit given we already have:
- Unbuffered output (instant visibility)
- Verbose progress messages
- Real-time file counts and timing

---

## Final Verdict

**For rookie automation**: Stick with **default output + unbuffering**

**For advanced users**: Could add stream-json as **optional flag** in future enhancement

Current solution is optimal for the target use case (rookies running autonomous research).
