#!/bin/bash

# 系统基础包
PKGS=(
    accountsservice
    adduser
    alsa-ucm-conf
    alsa-utils
    apt
    apt-utils
    at-spi2-core
    avahi-autoipd
    avahi-daemon
    base-files
    base-passwd
    bash
    bash-completion
    bsdmainutils
    bsdutils
    btrfs-progs
    coreutils
    cups
    dash
    debconf
    debianutils
    diffutils
    dnsmasq
    dpkg
    e2fsprogs
    engrampa
    fcitx5
    fcitx5-chinese-addons
    fcitx5-chinese-addons
    fcitx5-config-qt
    fcitx5-frontend-gtk2
    fcitx5-frontend-gtk3
    fcitx5-frontend-qt5
    fcitx5-gb18030
    fcitx5-module-chttrans
    findutils
    fontconfig
    fontconfig-config
    fonts-dejavu-core
    fonts-droid-fallback
    fonts-freefont-ttf
    fonts-liberation
    fonts-noto
    fonts-noto-cjk
    fonts-noto-cjk-extra
    gb-fonts
    gcc-10-base
    gdisk
    gir1.2-malcontent-0
    gnome-keyring
    grep
    gsettings-desktop-schemas
    gstreamer1.0-pulseaudio
    gzip
    hostname
    ifupdown
    iio-sensor-proxy
    im-config
    init-system-helpers
    initramfs-tools
    initramfs-tools-bin
    initramfs-tools-core
    install-info
    iputils-ping
    language-pack-gnome-zh-hans
    language-pack-gnome-zh-hans-base
    language-pack-zh-hans
    language-pack-zh-hans-base
    libblockdev-crypto2
    libime-bin
    libkylin-chkname1
    libmalcontent-0-0
    libmalcontent-0-dev
    libpam-malcontent
    libqt5waylandcompositor5
    libspa-0.2-bluetooth
    libxcb-imdkit1
    linux-firmware
    login
    logsave
    lsb-base
    mount
    ncurses-base
    ncurses-bin
    net-tools
    network-manager
    network-manager-gnome
    network-manager-pptp
    network-manager-pptp-gnome
    networkd-dispatcher
    nftables
    openssh-client
    orca
    original-awk
    parchives
    passwd
    perl-base
    pipewire
    pipewire-audio-client-libraries
    pipewire-pulse
    plymouth
    plymouth-label
    policykit-1
    policykit-1-gnome
    polkit-kde-agent-1
    ppp
    pppconfig
    pppoe
    pppoeconf
    procps
    pulseaudio
    pulseaudio-module-bluetooth
    python3-apport
    python3-brlapi
    python3-cairo
    python3-cups
    python3-dbus
    python3-gi
    python3-gi-cairo
    python3-louis
    python3-pyatspi
    python3-pyqt5
    python3-speechd
    python3-xlib
    python3.11
    python3:any
    qml-module-qtgraphicaleffects
    qml-module-qtquick-controls
    qml-module-qtquick2
    qt5-image-formats-plugins
    qttranslations5-l10n
    qtwayland5
    r8168-dkms
    rsync
    rsyslog
    sensible-utils
    shared-mime-info
    sudo
    systemd
    systemd-resolved
    systemd-timesyncd
    sysvinit-utils
    tar
    time-shutdown
    upower
    util-linux
    vim
    wget
    whiptail
    wireplumber
    wpasupplicant
    x11-xserver-utils
    xdg-user-dirs
    xdg-user-dirs-gtk
    xdg-utils
    xdiagnose
    xserver-xorg-core
    xserver-xorg-input-all
    xserver-xorg-input-synaptics
    xserver-xorg-video-ati
    xserver-xorg-video-fbdev
    xserver-xorg-video-radeon
    xserver-xorg-video-vesa
    # zip
)
install_pkgs "${PKGS[@]}"

# openkylin基础与环境包
PKGS=(
    dmz-cursor-theme
    kwin-wayland
    kwin-wayland-backend-drm
    kwin-wayland-backend-wayland
    kwin-x11
    kylin-calculator
    kylin-daq
    kylin-device-daemon
    kylin-driver-manager-service
    kylin-font-viewer
    kylin-id
    kylin-nm
    kylin-nm-plugin
    kylin-screenshot
    kylin-system-updater
    kylin-update-frontend
    kylin-update-notify
    kylin-user-guide
    libkylin-nm-base
    libkysdk-desktop
    libkysdk-log
    libukuiinputgatherclient1
    lightdm
    openkylin-default-settings
    openkylin-fonts
    openkylin-keyring
    openkylin-theme
    openkylin-wallpapers
    openkylin-wallpapers-yangtze
    peony
    peony-common
    peony-device-rename
    peony-extensions
    peony-open-terminal
    peony-print-pictures
    peony-share
    qml-module-org-ukui-qqc2desktopstyle
    qt5-styles-ukui
    qt5-ukui-platformtheme
    ukui-control-center
    ukui-desktop-environment
    ukui-desktop-environment-core
    ukui-framework
    ukui-globaltheme-common
    ukui-globaltheme-heyin
    ukui-globaltheme-light-seeking
    ukui-greeter
    ukui-menu
    ukui-panel
    ukui-polkit
    ukui-power-manager
    ukui-screensaver
    ukui-session-manager
    ukui-settings-daemon
    ukui-sidebar
    ukui-system-monitor
    ukui-window-switch
    xdg-desktop-portal-ukui
)
install_pkgs "${PKGS[@]}"

# # wlcom新窗管
# PKGS=(
#     kylin-wayland-compositor-client
#     kylin-wayland-compositor
# )
# install_pkgs "${PKGS[@]}"

# # 多语言
# PKGS=(
#     openkylin-language-pack-bo-cn
#     openkylin-language-pack-mn
#     openkylin-language-pack-kk-kz
#     openkylin-language-pack-ug-cn
#     openkylin-language-pack-ky-kg
#     openkylin-language-pack-zh-hk
#     openkylin-language-pack-de
#     openkylin-language-pack-es
#     openkylin-language-pack-fr
# )
# install_pkgs "${PKGS[@]}"

# 其他应用
PKGS=(
    #ukui-lite相关
    ukui-lite-manager

    #mate终端
    mate-terminal
    mate-terminal-common

    #文本编辑器
    pluma

    #ok输入法
    ok-input-method

    #搜狗输入法
    com.sogou.ime.ng.fcitx5.kylin
    cpis-base
    sogou-ime-ng
    sogou-ime-ng-cpis-dict-handwriting-chinese
    sogou-ime-ng-cpis-dict-handwriting-chinese-dict
    sogou-ime-ng-cpis-dict-handwriting-common
    sogou-ime-ng-cpis-dict-keyboard-chs-pcpy
    sogou-ime-ng-cpis-dict-keyboard-chs-pcwb
    sogou-ime-ng-cpis-dict-keyboard-multilingual-pcen
    sogou-ime-ng-cpis-user-default-profile
)
install_pkgs "${PKGS[@]}"


# # lite-ukui-config
# if apt-cache policy lite-ukui-config | grep -q lite-ukui-config; then
#     apt-get install -y lite-ukui-config
# fi
