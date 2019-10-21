#!/usr/bin/env bats

source "${BATS_TEST_DIRNAME}/../includes/helpers.sh"

@test "log: heading" {
  result="$(log "foo bar" "heading" | cat -A)"
  [ "$result" = '^[[1;34;4mfoo bar^[[0m$' ] 
}

@test "log: ok" {
  result="$(log "foo bar" "ok" | cat -A)"
  [ "$result" = '^[[32;3mM-bM-^\M-^T^[[0m ^[[32;3mfoo bar^[[0m$' ] 
}

@test "log: error" {
  result="$(log "foo bar" "error" 2>&1 | cat -A)"
  [ "$result" = '^[[31;3mfoo bar^[[0m$' ] 
}
