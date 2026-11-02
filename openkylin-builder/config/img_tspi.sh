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

(
    # 设置wifi 蓝牙
    mv ../tspi "${CURRENT_DIR}"
    tar -xvf "${CURRENT_DIR}"/tspi/tspi.tar.gz -C "${CURRENT_DIR}"/tspi
    cp -afv "${CURRENT_DIR}"/tspi/lib/systemd/system/wifibt-init.service /lib/systemd/system/wifibt-init.service
    cp -afv "${CURRENT_DIR}"/tspi/usr/bin/* /usr/bin/

    chmod a+x /usr/bin/wifi*
    chmod a+x /usr/bin/brcm_patchram_plus1

    if [ -f /lib/systemd/system/wifibt-init.service ]; then
        systemctl enable wifibt-init
    fi

    # 删除默认的固件，使用tspi的固件
    rm -rf /usr/lib/firmware
    cp -afv "${CURRENT_DIR}"/tspi/usr/lib/firmware /usr/lib/
    cp -afv "${CURRENT_DIR}"/tspi/usr/lib/modules /usr/lib/
    mkdir -p /system/etc
    ln -sf /system /vendor
    ln -sf /usr/lib/firmware /system/etc/firmware
)

(
    # 设置音频
    cp -afv "${CURRENT_DIR}"/tspi/var/lib/alsa/* /var/lib/alsa/
    cp -afv "${CURRENT_DIR}"/tspi/etc/udev/rules.d/* /etc/udev/rules.d/
    cp -afv "${CURRENT_DIR}"/tspi/usr/local/bin/* /usr/local/bin/
    chmod 755 /usr/local/bin/audio_switch.sh
)

config_zh_cn

USERNAME=openkylin
create_user ${USERNAME} openkylin

cat >> /etc/fstab <<EOF
LABEL=ROOT   /           ext4    rw,relatime 0 1
EOF

cat > /usr/share/lightdm/lightdm.conf.d/97-ukui-greeter.conf <<EOF
[Seat:*]
user-session=UKUI-Lite
EOF

nowtime=`date "+%Y%m%d%H%M"`
cat > /etc/kylin-build <<EOF
build_time: $nowtime
EOF
