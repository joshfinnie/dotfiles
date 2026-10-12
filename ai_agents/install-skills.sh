#!/usr/bin/env bash
set -euo pipefail

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

entries() {
    grep -v '^\s*#' "$1" | grep -v '^\s*$' || true
}

claude plugin marketplace update
installed="$(claude plugin list --json)"
for plugin in $(entries "$dir/plugins.txt"); do
    if grep -q "\"id\": \"$plugin\"" <<<"$installed"; then
        echo "already installed: $plugin"
    else
        claude plugin install "$plugin"
    fi
done

# Codex and Antigravity read the same folder through the Makefile symlinks,
# so installing for Claude Code covers all three.
for source in $(entries "$dir/skills.txt" | awk '{print $1}' | sort -u); do
    mapfile -t names < <(entries "$dir/skills.txt" | awk -v s="$source" '$1 == s {print $2}')
    pnpm dlx skills add "$source" --global --agent claude-code --yes --skill "${names[@]}"
done
