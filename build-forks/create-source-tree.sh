#!/bin/bash -x

set -e

SOURCES_DIR="${HOME}/openxt/sources/$1"
REPO_LIST_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/repo.list"

mkdir -p "${SOURCES_DIR}"

for x in $(cat "${REPO_LIST_PATH}"); do
  git clone --mirror "git://github.com/openxt/${x}.git" "${SOURCES_DIR}/${x}.git"
  git clone "${SOURCES_DIR}/${x}.git" "${SOURCES_DIR}/${x}"
done
