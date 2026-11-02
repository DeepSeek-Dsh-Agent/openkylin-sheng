#!/bin/bash
set -e

# 设置apt源优先级
cat >/etc/apt/preferences.d/openkylin.pref <<EOF
Package: *
Pin: origin "1-archive-proxy.factory.openkylin.top"
Pin-Priority: 1000
EOF

# 设置源地址
cat >/etc/apt/sources.list <<EOF
deb http://archive.build.openkylin.top/openkylin/ nile main cross pty
deb http://archive.build.openkylin.top/openkylin/ nile-security main cross pty
deb http://archive.build.openkylin.top/openkylin/ nile-updates main cross pty
deb http://ppa.build.openkylin.top/kylinsoft/anything2.0/openkylin/ nile main
deb http://software.openkylin.top/openkylin/ nile main all
EOF

cat >/etc/apt/apt.conf.d/01norecommend <<EOF
APT::Install-Suggests "false";
APT::Install-Recommends "false";
Aptitude::Recommends-Important "false";
EOF

# apt-get install -y gnupg
# apt-key adv --keyserver ppa.build.openkylin.top --recv-keys 2636AEDC49E9E2C8

apt-get update
