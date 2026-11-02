#!/bin/bash

PKGS=(
    fdisk
    initramfs-tools
    linux-firmware

    # linux-headers-5.15.0-23-generic
    # linux-hwe-5.15-headers-5.15.0-23
    # linux-image-5.15.0-23-generic
    # linux-modules-5.15.0-23-generic
    # linux-modules-extra-5.15.0-23-generic

    linux-headers-6.1.0-3-generic
    linux-headers-6.1.0-3
    linux-image-unsigned-6.1.0-3-generic
    linux-modules-6.1.0-3-generic
    linux-modules-extra-6.1.0-3-generic

)

install_pkgs "${PKGS[@]}"

# apt-get install -y -qq --no-install-recommends linux-generic
