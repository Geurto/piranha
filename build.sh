#!/bin/bash
export DOCKER_BUILDKIT=1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

(cd $SCRIPT_DIR/../.. && \
docker build \
--platform linux/amd64 \
-t "microhenk:latest" \
. )