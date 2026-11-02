#!/bin/bash

PKGS=(
    xinit lightdm xdg-user-dirs ukui-control-center ukui-desktop-environment ukui-desktop-environment-core ukui-greeter openkylin-wallpapers
    ukui-globaltheme-heyin
    libukuiinputgatherclient1 xserver-xorg-video-fbdev
    xserver-xorg-input-all

    # 网络设置
    network-manager-gnome

    # 便签
    ukui-notebook libqt5sql5-sqlite
    # 屏幕键盘
    onboard python3-xdg
    # VNC工具
    remmina remmina-plugin-vnc

    kylin-daq
    kylin-app-manager
)

install_pkgs "${PKGS[@]}"

# lite-ukui-config
if apt-cache policy lite-ukui-config | grep -q lite-ukui-config; then
    apt-get install -y lite-ukui-config
fi
