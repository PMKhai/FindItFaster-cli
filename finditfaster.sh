#!/bin/zsh

# FindItFaster - Advanced search tool for the terminal
# Similar to FindItFaster in VS Code

# Find file by name (ff = find files)
ff() {
  local result=$(fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' --height 80% --layout=reverse)
  if [ -n "$result" ]; then
    # Open file in default editor (code or vim)
    if command -v code >/dev/null 2>&1; then
      code "$result"
    else
      vim "$result"
    fi
  fi
}

# Find content within files (fs = find string)
fs() {
  # Use fzf's dynamic reload feature.
  # Use process substitution for empty initial input and reload using rg when the query changes.
  # Pass any initial arguments ($*) directly to fzf's query.
  local result=$(
    fzf --ansi < <(echo -n) \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter : \
        --preview "bat --color=always {1} --highlight-line {2} --style=numbers" \
        --preview-window "right,60%,border-left,+{2}+3/3,~3" \
        --height 80% --layout=reverse \
        --bind "change:reload(if [ -n '{q}' ]; then rg --color=always --line-number --no-heading --smart-case {q}; else echo -n; fi || true)" \
        --prompt "Search content> " \
        --header "Type to search content within files. Press Enter on a line to open." \
        --query "$*" # Start with arguments as query, or empty if no args
  )

  # Check if fzf returned a valid selection (contains ':')
  if [[ -n "$result" && "$result" == *":"* ]]; then
    local file=$(echo "$result" | cut -d':' -f1)
    local line=$(echo "$result" | cut -d':' -f2)

    # Open file in default editor at the found line
    if command -v code >/dev/null 2>&1; then
      code -g "$file:$line"
    else
      vim "$file" "+$line"
    fi
  fi
  # If result is empty or not in expected format, do nothing.
}

# Find file by name with pattern (fp = find pattern)
fp() {
  if [ $# -eq 0 ]; then
    echo "Usage: fp <pattern>"
    return 1
  fi

  local result=$(find . -type f -name "*$1*" | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}')

  if [ -n "$result" ]; then
    # Open file in default editor
    if command -v code >/dev/null 2>&1; then
      code "$result"
    else
      vim "$result"
    fi
  fi
}

# Find and change to directory (fd = find directory)
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# Display usage instructions
finditfaster_help() {
  echo "FindItFaster - Advanced search tool for the terminal"
  echo "----------------------------------------"
  echo "ff  - Find file by name"
  echo "fs  - Find content within files (Type to search, e.g., fs <initial query>)"
  echo "fp  - Find file by pattern (fp <pattern>)"
  echo "fd  - Find and change to directory"
  echo "finditfaster_help - Display this help message"
}

echo "FindItFaster loaded. Type 'finditfaster_help' to see usage instructions."
