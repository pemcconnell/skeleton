#!/bin/sh

set -e

. includes/consts.sh
. includes/helpers.sh

log "running test suite" "heading"

IN_DOCKER="${IN_DOCKER:-False}" # if True, run this script inside a container
errs=0

if [ "$IN_DOCKER" = "True" ]; then
  depchecker "docker"

  docker run \
    --rm \
    -e "PROJECT=$PROJECT" \
    -e "DOCKER_REGISTRY=$DOCKER_REGISTRY" \
    -e "DOCKER_IMAGE=$DOCKER_IMAGE" \
    -v "$(pwd):/go/" \
    -u "$(id -u)" \
    -w /go \
    -ti "${DOCKER_REGISTRY}${DOCKER_IMAGE}:build" sh -c "./test.sh"
else
  depchecker "shellcheck bats hadolint"

  # tests
  log "dockerfile lint"
  (hadolint Dockerfile && log "hadolint ...ok" "ok") || errs=1
  log "shell linting"
  (shellcheck -x ./*.sh && log "shellcheck ...ok" "ok") || errs=1
  log "shell unittests"
  bats ./unittests/ || errs=1
  log "golang unittests"
  go test -v ./... || errs=1
fi

exit $errs
