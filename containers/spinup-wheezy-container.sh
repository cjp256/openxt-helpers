#!/bin/bash -x

set -e

CONTAINER_NAME=${1}

if [[ -z ${CONTAINER_NAME} ]]; then
    echo "must specify container name: $0 <container_name>"
    exit 1
fi

echo "creating container=${CONTAINER_NAME}"

# allow grabbing images from linuxcontainers
lxc remote add images images.linuxcontainers.org || true

# download and launch a debian wheezy 32-bit container
lxc launch images:debian/wheezy/i386 ${CONTAINER_NAME}

# add user=builder to do build within container
lxc exec ${CONTAINER_NAME} -- adduser --disabled-password --system --shell /bin/bash --gecos oebuilder --group builder

# give it time for networking to come up
sleep 5

# install sudo so we can execute with non-root
lxc exec ${CONTAINER_NAME} -- apt-get update
lxc exec ${CONTAINER_NAME} -- apt-get -y install sudo

# allow builder to use sudo without password
lxc exec ${CONTAINER_NAME} -- /bin/sh -c "echo \"builder ALL=(ALL) NOPASSWD:ALL\" >> /etc/sudoers"

# install git to pull down openxt helpers
lxc exec ${CONTAINER_NAME} -- apt-get -y install git

# grab openxt-helpers repo
lxc exec ${CONTAINER_NAME} -- sudo -H -u builder -i -- git clone https://github.com/cjp256/openxt-helpers.git

# setup wheezy environment to build openxt
lxc exec ${CONTAINER_NAME} -- sudo -H -u builder -i -- openxt-helpers/prep-system/prep-wheezy.sh

