openxt-helpers
==============

my helper tools used for openxt development

## prep-system - configure a distro to be ready to build openxt

### prep-system/prep-wheezy.sh

used to setup a wheezy image - it is assumed that sudo is configured for the user.

usage:

> prep-system/prep-wheezy.sh

## build forks - full local openxt mirror scripts

### build-forks/create-source-tree.sh

used to clone a full set of git repos locally to ~/openxt/sources/$treename

usage:

> cd build-forks; create-source-tree.sh <tree-name>

### build-forks/create-build-tree.sh

used to stage a fresh build directory at ~/openxt/builds/$treename using the local source tree created above

usage:

> cd build-forks; create-build-tree.sh <tree-name>

## build - scripits to do standalone builds using openxt's github repos

### build/build-jethro.sh

script for creating and building a jethro-based OpenXT using Adam Oliver's (aikidokatech) branch. Note that this does not use a build-fork.  creates build tree in ~/openxt/builds/<build-tree-name>

usage:

> build/build-jethro.sh [optional-build-tree-name-defaults-to-jethro]

## containers - lxc/lxd container scripts

### containers/prep-ubuntu-15.10.sh

installs lxd in ubuntu 15.10, enabling the spinup-*-container scripts.

usage:

> containers/prep-ubuntu-15.10.sh

### containers/spinup-wheezy-container.sh

creates a minimal debian wheezy container ready to build openxt.  takes about 4-6 minutes depending on hardware and network.

usage:

> containers/spinup-wheezy-container.sh <container-name>

### containers/kickoff-jethro.sh

kicks off fresh jethro build within a container created with spinup-*-container

usage:

> containers/kickoff-jethro.sh <container-name>
