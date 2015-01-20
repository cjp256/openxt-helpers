#!/bin/bash -x

BUILD_DIR="${HOME}/openxt/builds/$1"

if [[ -e ${BUILD_DIR} ]]; then
	echo "build dir exists... aborting."
	exit 1
fi

git clone https://github.com/OpenXT/openxt.git "${BUILD_DIR}"

cp config "${BUILD_DIR}/.config"

SOURCES_DIR="${HOME}/openxt/sources/$1"
sed -i "s|__GIT_MIRROR__|${SOURCES_DIR}|g" "${BUILD_DIR}/.config"

CERTS_DIR="${HOME}/openxt/certs"
sed -i "s|__CERTS_DIR__|${CERTS_DIR}|g" "${BUILD_DIR}/.config"

pushd "${BUILD_DIR}"

./do_build.sh -s setupoe

#echo 'BUILD_ARCH="i686"' >> build/conf/local.conf
echo 'DL_DIR="${HOME}/oe-downloads"' >> build/conf/local.conf

popd

