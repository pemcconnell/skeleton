#!/bin/sh

: "${PROJECT:?You must set the 'PROJECT' environment variable}"
DOCKER_REGISTRY="${DOCKER_REGISTRY:-}"
DOCKER_IMAGE="${DOCKER_IMAGE:-$PROJECT}"
