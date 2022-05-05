#!bin/bash

set -e

BASE_IMAGE="registry.access.redhat.com/ubi8/ubi:latest"

CONTAINER_ID=$(buildah from "$BASE_IMAGE")

function r () {
	buildah run "$CONTAINER_ID" -- "$@"
}

#. "$HERE/_env"

r dnf install --assumeyes  \
    git \
    cmake \
    fftw-devel \
	mbedtls-devel \
	boost-devel \

r git clone https://github.com/srsran/srsRAN.git \ 
  && mkdir srsbuild \
  && mkdir srstarget \
  && cd srsbuild \
  && cmake -DCMAKE_INSTALL_PREFIX=../srstarget ../srsRAN
  && make