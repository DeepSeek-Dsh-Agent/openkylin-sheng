#!/bin/bash
# Xiaomi Pad 6S Pro (sheng) 设备适配层

MY_LOG "---> sheng: install device debs"
if ls /config/sheng-debs/*.deb >/dev/null 2>&1; then
    # 指纹包依赖 fprintd(>=1.94.5) / libgusb2(>=0.4.9)，nile 基座无 fprintd 且 libgusb2 仅 0.4.8，跳过
    DEBS=$(find /config/sheng-debs -maxdepth 1 -name '*.deb' ! -name '*fingerprint*' | sort)
    if [ -n "${DEBS}" ]; then
        # shellcheck disable=SC2086
        dpkg -i ${DEBS} || true
    fi
    apt-get install -f -y || true
else
    MY_LOG "---> sheng: no debs found, skip"
fi

# 账号 / 主机名 / 时区 / locale
create_user "${VK_USERNAME:-xiaomi}" "${VK_PASSWORD:-200322}"
set_hostname "${VK_HOSTNAME:-Mi-Pad-6SPro}"
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime || true
echo "Asia/Shanghai" >/etc/timezone || true
sed -i 's/^# *\(zh_CN\.UTF-8\)/\1/' /etc/locale.gen 2>/dev/null || true
sed -i 's/^# *\(en_US\.UTF-8\)/\1/' /etc/locale.gen 2>/dev/null || true
locale-gen || true
echo "LANG=zh_CN.UTF-8" >/etc/default/locale

# LightDM 自动登录（UKUI）
mkdir -p /etc/lightdm/lightdm.conf.d
cat >/etc/lightdm/lightdm.conf.d/50-sheng-autologin.conf <<CONF
[Seat:*]
autologin-user=${VK_USERNAME:-xiaomi}
autologin-user-timeout=0
user-session=ukui
CONF
systemctl enable lightdm || true
systemctl set-default graphical.target || true
systemctl enable NetworkManager || true
systemctl enable ssh || true

# WLAN MAC（persist 分区）
mkdir -p /mnt/sheng-persist /usr/lib/firmware/ath12k/WCN7850/hw2.0
ln -sf /mnt/sheng-persist/kiwi_v2/wlan_mac.bin /usr/lib/firmware/ath12k/WCN7850/hw2.0/wlan_mac.bin || true
if [ -f /config/sheng-assets/sheng-wlan.conf ]; then
    install -D -m 0644 /config/sheng-assets/sheng-wlan.conf /etc/modprobe.d/sheng-wlan.conf
fi
if [ -f /config/sheng-assets/sheng-wlan.service ]; then
    install -D -m 0644 /config/sheng-assets/sheng-wlan.service /lib/systemd/system/sheng-wlan.service
    systemctl enable sheng-wlan.service || true
fi

# About 面板设备信息
cat >/etc/machine-info <<CONF
CHASSIS=tablet
DEPLOYMENT=production
HARDWARE_VENDOR=Xiaomi
HARDWARE_MODEL=Pad 6S Pro 12.4 (Tablet, 24018RPACC, sheng)
CONF

# 清理 live 安装器 / 缓存
rm -rf /etc/xdg/autostart/*installer* 2>/dev/null || true
apt-get clean || true
rm -rf /var/lib/apt/lists/* || true
rm -rf /tmp/* 2>/dev/null || true
MY_LOG "---> sheng: device layer done"
