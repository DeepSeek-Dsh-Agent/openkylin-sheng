#!/bin/bash

PKGS=(
    fdisk
    initramfs-tools
)

install_pkgs "${PKGS[@]}"

apt-get install -y linux-image-4.19.246-phytium-embeded linux-headers-4.19.246-phytium-embeded
(
    cd /boot
    cp -v /usr/lib/linux-image-4.19.246-phytium-embeded/phytium/e2000d-demo-board.dtb e2000d-chilli.dtb
    rm -rf System.map-4.19.246-phytium-embeded
    cp -v vmlinuz-4.19.246-phytium-embeded Image.gz
    gunzip -vf Image.gz
)
