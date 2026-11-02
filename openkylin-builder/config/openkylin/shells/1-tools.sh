#!/bin/bash

PKGS=(
    # base tools
    apt-utils
    kmod
    kbd
    whiptail
    locales

    systemd-resolved

    # extra tools
    vim
    lsof
    cpio
    file
    sudo
    tree
    wget
    rsync
    fdisk
    gdisk
    parted
    psmisc
    rsyslog
    dosfstools
    lsb-release
    archdetect-deb
    bash-completion
    zstd
)

install_pkgs "${PKGS[@]}"
