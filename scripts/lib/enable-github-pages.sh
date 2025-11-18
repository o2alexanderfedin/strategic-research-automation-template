#!/usr/bin/env bash
#
# Enable GitHub Pages for a repository
# Single Responsibility: Manage GitHub Pages configuration
#
# Usage: source scripts/lib/enable-github-pages.sh && enable_github_pages "username" "repo" "branch" "/docs"

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

#
# Enable GitHub Pages for a repository
#
# Arguments:
#   $1 - GitHub username/org
#   $2 - Repository name
#   $3 - Branch name (e.g., "main", "develop")
#   $4 - Path (e.g., "/docs", "/")
#
# Returns: 0 if enabled (or already enabled), 1 otherwise
#
enable_github_pages() {
    local github_user="$1"
    local repo_name="$2"
    local branch="${3:-main}"
    local path="${4:-/docs}"

    if [ -z "$github_user" ] || [ -z "$repo_name" ]; then
        echo -e "${RED}⚠ Usage: enable_github_pages <user> <repo> [branch] [path]${NC}"
        return 1
    fi

    if ! command -v gh &> /dev/null; then
        echo -e "${RED}⚠ GitHub CLI (gh) not installed${NC}"
        return 1
    fi

    if ! gh auth status &> /dev/null; then
        echo -e "${RED}⚠ GitHub CLI not authenticated${NC}"
        return 1
    fi

    echo -e "${YELLOW}Checking GitHub Pages status...${NC}"

    # Check if Pages is already enabled
    local pages_status
    pages_status=$(gh api "repos/$github_user/$repo_name/pages" 2>&1 || echo "not_found")

    if [[ "$pages_status" == *"not_found"* ]] || [[ "$pages_status" == *"404"* ]]; then
        echo -e "${YELLOW}Enabling GitHub Pages...${NC}"

        # Enable GitHub Pages using the API
        if gh api -X POST "repos/$github_user/$repo_name/pages" \
            -f "source[branch]=$branch" \
            -f "source[path]=$path" &> /dev/null; then

            echo -e "${GREEN}✓ GitHub Pages enabled successfully!${NC}"
            echo -e "${GREEN}  Branch: $branch${NC}"
            echo -e "${GREEN}  Path: $path${NC}"
            sleep 2  # Give API a moment to process
            return 0
        else
            echo -e "${RED}⚠ Failed to enable GitHub Pages via API${NC}"
            echo -e "${YELLOW}Enable manually: GitHub repo Settings → Pages${NC}"
            echo -e "${YELLOW}  Source: $branch, $path${NC}"
            return 1
        fi
    else
        echo -e "${GREEN}✓ GitHub Pages already enabled${NC}"
        return 0
    fi
}

#
# Get GitHub Pages URL for a repository
#
# Arguments:
#   $1 - GitHub username/org
#   $2 - Repository name
#
# Outputs: The GitHub Pages URL (or empty string if not enabled)
#
get_github_pages_url() {
    local github_user="$1"
    local repo_name="$2"

    if [ -z "$github_user" ] || [ -z "$repo_name" ]; then
        return 1
    fi

    echo "https://${github_user}.github.io/${repo_name}/"
}

#
# Check if GitHub Pages is enabled
#
# Arguments:
#   $1 - GitHub username/org
#   $2 - Repository name
#
# Returns: 0 if enabled, 1 otherwise
#
is_github_pages_enabled() {
    local github_user="$1"
    local repo_name="$2"

    if [ -z "$github_user" ] || [ -z "$repo_name" ]; then
        return 1
    fi

    if ! command -v gh &> /dev/null; then
        return 1
    fi

    if ! gh auth status &> /dev/null; then
        return 1
    fi

    local pages_status
    pages_status=$(gh api "repos/$github_user/$repo_name/pages" 2>&1 || echo "not_found")

    if [[ "$pages_status" == *"not_found"* ]] || [[ "$pages_status" == *"404"* ]]; then
        return 1  # Not enabled
    else
        return 0  # Enabled
    fi
}
