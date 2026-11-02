#!/bin/bash

CURRENT_ARCH=$(dpkg --print-architecture)

if [ "${CURRENT_ARCH}" == "amd64" ]; then
    PKGS=(
        grub-efi
        grub-common
        grub2-common
        # label.so
        plymouth-label
    )

    install_pkgs "${PKGS[@]}"
fi
