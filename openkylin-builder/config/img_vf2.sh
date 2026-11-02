#!/bin/bash
set -e

PKGS=(
    gdisk
    parted

    u-boot-menu

    linux-image-5.10.79+
    # linux-firmware
    initramfs-tools

    # ntp
    openntpd ntpdate

    # language
    language-pack-zh-hans

    gcc python3
)

install_pkgs "${PKGS[@]}"

# resize root part
CURRENT_DIR=$(dirname "$(readlink -f "$0")")
cp -afv "${CURRENT_DIR}"/system/lib/systemd/system/resize-assistant.service /lib/systemd/system/resize-assistant.service
cp -afv "${CURRENT_DIR}"/system/usr/sbin/resize-assistant /usr/sbin/resize-assistant
chmod a+x /usr/sbin/resize-assistant

if [ -f /lib/systemd/system/resize-assistant.service ]; then
    systemctl enable resize-assistant
fi

config_en_utf8

USERNAME=openkylin
create_user ${USERNAME} openkylin

rm -rf /boot/initrd*
update-initramfs -c -k all

mkdir -p /boot/dtbs
cp -rf /usr/lib/linux-image-5.10.79+/starfive /boot/dtbs

if [ -f /usr/lib/systemd/system/iwd.service ]; then
    systemctl disable iwd.service
fi
