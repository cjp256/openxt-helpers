#!/bin/bash -x

set -e

SOURCES_DIR="${HOME}/openxt/sources/$1"
mkdir -p "${SOURCES_DIR}"

for x in $(cat repo.list); do
  git clone --mirror "git://github.com/openxt/${x}.git" "${SOURCES_DIR}/${x}.git"
  git clone "${SOURCES_DIR}/${x}.git" "${SOURCES_DIR}/${x}"
done
