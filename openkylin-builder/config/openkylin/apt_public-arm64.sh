#!/bin/bash
set -e

cat >/etc/apt/sources.list <<EOF
deb http://archive.build.openkylin.top/openkylin/ nile main cross pty
deb http://archive.build.openkylin.top/openkylin/ nile-security main cross pty
deb http://archive.build.openkylin.top/openkylin/ nile-updates main cross pty
deb http://archive.build.openKylin.top/openkylin/ nile-proposed main cross pty
EOF
