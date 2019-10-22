#!/bin/sh

set -e

. includes/consts.sh
. includes/helpers.sh

log "building '$PROJECT'" "heading"
depchecker "docker"

log "create '$PROJECT' build container image (docker)"
docker build \
  -t="${DOCKER_REGISTRY}${DOCKER_IMAGE}:build" \
  -f Dockerfile \
  .

log "create '$PROJECT' scratch container image (docker)"
docker build \
  --build-arg base="${DOCKER_REGISTRY}${DOCKER_IMAGE}" \
  -t="${DOCKER_REGISTRY}${DOCKER_IMAGE}:scratch" \
  -f Dockerfile.scratch \
  .

log "validate that '$PROJECT' runs via the scratch container"
docker run \
  --rm \
  -ti "${DOCKER_REGISTRY}${DOCKER_IMAGE}:scratch"
