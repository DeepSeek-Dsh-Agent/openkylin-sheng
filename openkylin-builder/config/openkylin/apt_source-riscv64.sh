#!/bin/bash
set -e


# 设置apt源优先级
cat >/etc/apt/preferences.d/kylin.pref <<EOF
Package: libc-bin
Pin: version 2.36-ok4
Pin-Priority: 9999

Package: locales
Pin: version 2.36-ok4
Pin-Priority: 9999
EOF

cat >/etc/apt/sources.list <<EOF
deb [trusted=yes] http://ppa.build.openkylin.top/mayukun/visionfive2-kernel-5.10/openkylin yangtze main 

deb [trusted=yes] http://archive.build.openkylin.top/OTHER/Internal-mirror/repack5/baseok0.fix yangtze main
deb [trusted=yes] http://archive.build.openkylin.top/OTHER/openkylin01/ok0 yangtze main

deb http://archive.build.openkylin.top/openkylin/ nile main cross pty
deb http://archive.build.openkylin.top/openkylin/ nile-security main cross pty
deb http://archive.build.openkylin.top/openkylin/ nile-updates main cross pty
deb http://archive.build.openKylin.top/openkylin/ nile-proposed main cross pty
EOF

apt-get update
