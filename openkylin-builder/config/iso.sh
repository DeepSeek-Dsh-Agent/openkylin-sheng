#!/bin/bash
set -e

PKGS=(
    casper lupin-casper
    kylin-os-installer
)

install_pkgs "${PKGS[@]}"
