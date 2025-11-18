#!/usr/bin/env bash
#
# UI Helper Functions
# Single Responsibility: User interface and interaction
#
# Usage: source scripts/lib/ui-helpers.sh

# Colors
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export BLUE='\033[0;34m'
export CYAN='\033[0;36m'
export BOLD='\033[1m'
export NC='\033[0m'

#
# Print a header with border
#
# Arguments:
#   $1 - Header text
#   $2 - Color (optional, default: BLUE)
#
print_header() {
    local text="$1"
    local color="${2:-$BLUE}"

    echo ""
    echo -e "${color}╔════════════════════════════════════════════════════════════╗${NC}"
    printf "${color}║ %-58s ║${NC}\n" "$text"
    echo -e "${color}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

#
# Print a section separator
#
# Arguments:
#   $1 - Section text
#   $2 - Color (optional, default: BLUE)
#
print_section() {
    local text="$1"
    local color="${2:-$BOLD$BLUE}"

    echo ""
    echo -e "${color}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${color}  $text${NC}"
    echo -e "${color}═══════════════════════════════════════════════════════════${NC}"
    echo ""
}

#
# Print a success message
#
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

#
# Print an error message
#
print_error() {
    echo -e "${RED}✗${NC} $1"
}

#
# Print a warning message
#
print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

#
# Print an info message
#
print_info() {
    echo -e "${CYAN}ℹ${NC} $1"
}

#
# Print a progress message
#
print_progress() {
    echo -e "${YELLOW}→${NC} $1"
}

#
# Ask a yes/no question
#
# Arguments:
#   $1 - Question text
#
# Returns: 0 if yes, 1 if no
#
ask_yes_no() {
    local question="$1"
    local answer

    read -r -p "$question (y/n): " answer
    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
        return 0
    else
        return 1
    fi
}

#
# Ask a question with a default value
#
# Arguments:
#   $1 - Question text
#   $2 - Default value
#
# Outputs: The user's answer (or default if empty)
#
ask_with_default() {
    local question="$1"
    local default="$2"
    local answer

    read -r -p "$question [default: $default]: " answer
    echo "${answer:-$default}"
}

#
# Print a table row
#
# Arguments:
#   $1 - Label (left column)
#   $2 - Value (right column)
#
print_table_row() {
    local label="$1"
    local value="$2"

    printf "${BOLD}%-30s${NC} %s\n" "$label:" "$value"
}

#
# Print a bulleted list item
#
print_list_item() {
    echo "  • $1"
}

#
# Print a numbered list item
#
# Arguments:
#   $1 - Number
#   $2 - Text
#
print_numbered_item() {
    echo "  $1. $2"
}
