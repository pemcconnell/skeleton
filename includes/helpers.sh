#!/bin/sh

set -e

# log - print messages to stdout / stderr
#   '$1' - message to be printed
#   '$2' - format (e.g. heading, info, error, ok)
# e.g. "log 'foo bar' 'error'"
log(){
  msg="$1"
  format="${2:-info}"
  colour='33'
  error=0
  if [ "$format" = "heading" ]; then
    colour='1;34;4'
  elif [ "$format" = "ok" ]; then
    colour='32;3'
    printf '\e[%sm\342\234\224\e[0m ' "$colour"
  elif [ "$format" = "error" ]; then
    error=1
    colour='31;3'
  fi
  if [ $error -eq 0 ]; then
    printf '\e[%sm%s\e[0m\n' "$colour" "$msg"
    if [ "$format" = "confirm" ]; then
      read -r yn
      if [ "$yn" != "y" ] && [ "$yn" != "Y" ]; then
        error=1
        printf '\e[%sm%s\e[0m\n' "$colour" " ...skipped"
      fi
    fi
  else
    printf '\e[%sm%s\e[0m\n' "$colour" "$msg" >&2
  fi
  return $error
}

# depchecker - checks for the presence of binaries
#  '$1' - space-separated string of binaries
# e.g. "depchecker 'shellcheck go bats'"
depchecker() {
  deps="$1"
  log "checking dependencies"
  for dep in $deps; do
    if ! command -v "$dep" > /dev/null 2>&1; then
      log "$dep not found! please install it" "error"
    else
      log "$dep found ...ok" "ok"
    fi
  done
}
