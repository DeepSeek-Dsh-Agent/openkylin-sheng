#!/bin/bash
set -e

PKGS=(
    gdisk
    parted
)

install_pkgs "${PKGS[@]}"

# resize root part
CURRENT_DIR=$(dirname "$(readlink -f "$0")")
cp -afv "${CURRENT_DIR}"/system/lib/systemd/system/resize-assistant-chilliepi.service /lib/systemd/system/resize-assistant.service
cp -afv "${CURRENT_DIR}"/system/usr/sbin/resize-assistant /usr/sbin/resize-assistant
chmod a+x /usr/sbin/resize-assistant

if [ -f /lib/systemd/system/resize-assistant.service ]; then
    systemctl enable resize-assistant
fi

config_zh_cn

USERNAME=openkylin
create_user ${USERNAME} openkylin

nowtime=`date "+%Y%m%d%H%M"`
cat > /etc/kylin-build <<EOF
build_time: $nowtime
EOF
