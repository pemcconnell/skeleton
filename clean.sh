#!/bin/sh

set -e

. includes/consts.sh
. includes/helpers.sh

log "cleaning '$PROJECT' artefacts" "heading"
depchecker " docker git"

log "should we remove docker build containers? [y|N]" "confirm" && (
  (docker rmi "${DOCKER_REGISTRY}${DOCKER_IMAGE}:build" || log "no build image to clean up")
  (docker rmi "${DOCKER_REGISTRY}${DOCKER_IMAGE}:scratch" || log "no scratch image to clean up")
)

log "should we perform a git clean? [y|N]" "confirm" && (
  git clean -fd
)
