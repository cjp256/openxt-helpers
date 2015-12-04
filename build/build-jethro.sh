#!/bin/bash -x 

BUILD_NAME=${1-jethro}
BUILDS_DIR="${HOME}/openxt/builds"
BUILD_PATH="${BUILDS_DIR}/${BUILD_NAME}"

# wipe existing build
rm -rf ${BUILD_PATH}

mkdir -p ${BUILDS_DIR}
pushd ${BUILDS_DIR}

git clone git://github.com/aikidokatech/openxt.git ${BUILD_NAME} -b fido

cd ${BUILD_NAME}

cat >.config <<EOF
OE_BRANCH="jethro"
BB_BRANCH="1.28"
OPENXT_GIT_MIRROR="github.com/OpenXT"
OPENXT_GIT_PROTOCOL="git"
BITBAKE_REPO=git://github.com/openembedded/bitbake.git
OE_CORE_REPO=git://github.com/openembedded/openembedded-core
META_OE_REPO=git://github.com/openembedded/meta-openembedded
META_JAVA_REPO=git://git.yoctoproject.org/meta-java
META_SELINUX_REPO=git://git.yoctoproject.org/meta-selinux
META_JAVA_TAG=a73939323984fca1e919d3408d3301ccdbceac9c
OPENXT_MIRROR="http://mirror.openxt.org"
NAME_SITE="openxt"
BUILD_TYPE="dev"
INHIBIT_RMWORK="yes"
REPO_PROD_CACERT="${HOME}/openxt/certs/prod-cacert.pem"
REPO_DEV_CACERT="${HOME}/openxt/certs/dev-cacert.pem"
REPO_DEV_SIGNING_CERT="${HOME}/openxt/certs/dev-cacert.pem"
REPO_DEV_SIGNING_KEY="${HOME}/openxt/certs/dev-cakey.pem"
NEVER_GET_LOG=1
EOF

./do_build.sh -s "setupoe,initramfs,stubinitramfs,dom0,uivm,ndvm,syncvm,installer,installer2,ship"

popd
