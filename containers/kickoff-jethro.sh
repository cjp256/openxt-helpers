#!/bin/bash -x

set -e

CONTAINER_NAME=${1}

if [[ -z ${CONTAINER_NAME} ]]; then
    echo "must specify container name: $0 <container_name>"
    exit 1
fi

# go ahead and build jethro
lxc exec ${CONTAINER_NAME} -- sudo -H -u builder -i -- openxt-helpers/build/build-jethro.sh

