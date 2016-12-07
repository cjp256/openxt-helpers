#!/bin/bash -x

BUILD_DIR="${HOME}/openxt/builds/$1"
SOURCES_DIR="${HOME}/openxt/sources/$1"
CERTS_DIR="${HOME}/openxt/certs"
CONFIG_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/config"

if [[ -e ${BUILD_DIR} ]]; then
	echo "build dir exists... aborting."
	exit 1
fi

git clone ${SOURCES_DIR}/openxt.git "${BUILD_DIR}"

cp "${CONFIG_PATH}" "${BUILD_DIR}/.config"

sed -i "s|__GIT_MIRROR__|${SOURCES_DIR}|g" "${BUILD_DIR}/.config"
sed -i "s|__CERTS_DIR__|${CERTS_DIR}|g" "${BUILD_DIR}/.config"

pushd "${BUILD_DIR}"

./do_build.sh -s setupoe

echo 'DL_DIR="${HOME}/oe-downloads"' >> build/conf/local.conf

popd

