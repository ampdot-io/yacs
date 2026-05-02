#!/usr/bin/env bash
# Detect OS light/dark theme and update ~/.claude.json to match.
# Works on macOS (AppleInterfaceStyle) and Linux/Budgie (gsettings).
# Requires: jq

set -euo pipefail

detect_theme() {
  case "$(uname -s)" in
    Darwin)
      if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
        echo "dark"
      else
        echo "light"
      fi
      ;;
    Linux)
      local scheme
      scheme="$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null || true)"
      if [[ "$scheme" == *"dark"* ]]; then
        echo "dark"
      else
        echo "light"
      fi
      ;;
    *)
      echo "light"
      ;;
  esac
}

main() {
  [[ -f "$HOME/.claude/no-theme-sync" ]] && return 0
  local config="$HOME/.claude.json"
  [[ -f "$config" ]] || return 0
  command -v jq &>/dev/null || return 0

  local theme
  theme="$(detect_theme)"

  local current
  current="$(jq -r '.theme // "light"' "$config" 2>/dev/null)"

  if [[ "$current" != "$theme" ]]; then
    local tmp
    tmp="$(mktemp)"
    jq --arg t "$theme" '.theme = $t' "$config" > "$tmp" && mv "$tmp" "$config"
  fi
}

main
