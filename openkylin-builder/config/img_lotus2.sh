#!/bin/bash
set -e

PKGS=(
    gdisk
    parted

    gcc
    python3
)

install_pkgs "${PKGS[@]}"

config_en_utf8

USERNAME=openkylin
create_user ${USERNAME} openkylin
