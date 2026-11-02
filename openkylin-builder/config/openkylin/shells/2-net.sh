#!/bin/bash

PKGS=(
    iputils-ping iproute2 net-tools
    network-manager
    wpasupplicant

    # ssh
    openssh-server
    openssh-client
)

install_pkgs "${PKGS[@]}"
