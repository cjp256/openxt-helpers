#!/bin/bash -x

BUILD_DIR="${HOME}/openxt/builds/$1"
SOURCES_DIR="${HOME}/openxt/sources/$1"
CERTS_DIR="${HOME}/openxt/certs"

if [[ ! -d ${BUILD_DIR} ]]; then
	echo "build dir does not exist? did you create-build-tree yet?"
	exit 1
fi

pushd "${BUILD_DIR}"

./do_build.sh -s initramfs,stubinitramfs,dom0,uivm,ndvm,syncvm,installer,installer2,ship

popd

