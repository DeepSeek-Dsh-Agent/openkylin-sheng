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

PKGS=(
    initramfs-tools
    # mkimage
    u-boot-tools
)
install_pkgs "${PKGS[@]}"

# 安装内核
(

    mkdir -p /opt/phyitumpi
    cd /opt/phyitumpi

    dpkg -i /local-data/*.deb
    rm -rf /local-data
)
rm -rf /opt/phyitumpi

cat > /usr/share/lightdm/lightdm.conf.d/97-ukui-greeter.conf <<EOF
[Seat:*]
user-session=UKUI-Lite
EOF
