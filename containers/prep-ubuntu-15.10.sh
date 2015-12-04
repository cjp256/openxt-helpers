#!/bin/bash -x

# Ubuntu 15.10 + LXD (LXC) setup
echo "installing lxd"

# install lxd
sudo apt-get install lxd

# switch to newly created group (or just logout)
newgrp lxd
