#!/bin/sh

set -e

. includes/helpers.sh

log "running test suite" "heading"
depchecker "shellcheck bats hadolint"

# tests
errs=0
log "dockerfile lint"
(hadolint Dockerfile && log "hadolint ...ok" "ok") || errs=1
log "shell linting"
(shellcheck -x ./*.sh && log "shellcheck ...ok" "ok") || errs=1
log "shell unittests"
bats ./unittests/ || errs=1
log "golang unittests"
go test -v ./... || errs=1

exit $errs
