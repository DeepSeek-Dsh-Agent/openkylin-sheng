#!/bin/bash

# 仅打印
function MY_LOG() {
    echo " => $*"
}
# 打印 并 执行
function MY_LOG_EXEC() {
    echo " => $*"
    eval "$*"
}

# 执行指定目录下的脚本
function run_scripts() {
    SCRIPTS_DIR="${1}"
    VK_ORDER=${VK_ORDER:-default}

    if [ -d "${SCRIPTS_DIR}" ]; then
        if [ -f "${SCRIPTS_DIR}/${VK_ORDER}" ]; then
            # 按照给定的顺序执行脚本
            for script_name in $(cat ${SCRIPTS_DIR}/${VK_ORDER} | sed '/^#/d'); do
                echo "---> . ${SCRIPTS_DIR}/${script_name}"
                . ${SCRIPTS_DIR}/${script_name} 2>&1 | tee /config/"$(basename ${script_name})".log
            done
        else
            # 按照sort -n排序，执行全部脚本
            for script_name in $(find ${SCRIPTS_DIR} -name "*.sh" | sort -n); do
                echo "---> . ${script_name}"
                . "${script_name}" 2>&1 | tee /config/"$(basename ${script_name})".log
            done
        fi
    fi
}

# 创建用户
function create_user() {
    USERNAME="$1"
    PASSWORD="$2"
    USERID="${3:-1000}"
    if ! awk -F: '{print $1}' /etc/passwd | grep -q ${USERNAME}; then
        useradd -m -s /bin/bash -u ${USERID} "${USERNAME}"
        usermod -c "${USERNAME}" "${USERNAME}"
        echo "${USERNAME}:${PASSWORD}" | chpasswd
        adduser ${USERNAME} sudo
        adduser ${USERNAME} adm
        adduser ${USERNAME} cdrom >/dev/null 2>&1 || true
        adduser ${USERNAME} dip >/dev/null 2>&1 || true
        adduser ${USERNAME} plugdev >/dev/null 2>&1 || true
        adduser ${USERNAME} lpadmin >/dev/null 2>&1 || true
        adduser ${USERNAME} sambashare >/dev/null 2>&1 || true
        adduser ${USERNAME} libvirtd >/dev/null 2>&1 || true
        adduser ${USERNAME} lxd >/dev/null 2>&1 || true
    else
        echo "user ${USERNAME} already exists"
    fi
}

function set_hostname() {
    HOSTNAME="$1"
    echo ${HOSTNAME} >/etc/hostname

    touch /etc/hosts
    if ! grep -q "127.0.0.1 localhost" /etc/hosts; then
        cat >>/etc/hosts <<EOF
127.0.0.1 localhost
127.0.1.1 ${HOSTNAME}
EOF
    fi
}

function install_pkgs() {
    # 整批安装；失败则逐个安装、缺失的包只告警（上游 nile 包列表会漂移）
    if ! MY_LOG_EXEC apt-get install -y --allow-downgrades "$*"; then
        MY_LOG "warn: batch install failed, retry one by one"
        for _pkg in "$@"; do
            apt-get install -y --allow-downgrades "${_pkg}" || MY_LOG "warn: skip missing package: ${_pkg}"
        done
    fi
}

# 循环单个安装
function install_pkgs_each() {
    for pkg in "$@"; do
        MY_LOG_EXEC apt-get install -y -q "${pkg}"
    done
}

# 结束，收尾
function finish() {
    # 禁止 kylin-virtual-keyboard, ukui-tablet-desktop.desktop 开机启动
    # sheng 是平板设备：需要屏幕虚拟键盘与 UKUI 平板桌面，保留这两个自启
    if [ "${VK_BOARD}" != "sheng" ]; then
        [ -f "/etc/xdg/autostart/kylin-virtual-keyboard.desktop" ] && mv -v /etc/xdg/autostart/kylin-virtual-keyboard.desktop{,.bak}
        [ -f "/etc/xdg/autostart/ukui-tablet-desktop.desktop" ] && mv -v /etc/xdg/autostart/ukui-tablet-desktop.desktop{,.bak}
    fi

    # 删除开始菜单图标
    rm -rf /usr/share/applications/vim.desktop
    rm -rf /usr/share/applications/org.kde.systemmonitor.desktop
    rm -rf /usr/share/applications/org.kde.plasma-systemmonitor.desktop
    rm -rf /usr/share/applications/org.kde.khelpcenter.desktop
    rm -rf /usr/share/applications/mate-user-guide.desktop
    rm -rf /usr/share/applications/yelp.desktop
    rm -rf /usr/share/applications/org.kde.kdeconnect.telhandler.desktop
    rm -rf /usr/share/applications/org.kde.kdeconnect.sms.desktop
    rm -rf /usr/share/applications/org.kde.kdeconnect.kcm.desktop
    rm -rf /usr/share/applications/org.kde.kdeconnect.app.desktop
    rm -rf /usr/share/applications/org.kde.kdeconnect.smshandler.desktop
    rm -rf /usr/share/applications/org.kde.kdeconnect.nonplasma.desktop
    rm -rf /usr/share/applications/org.kde.kdeconnect.daemon.desktop
    rm -rf /usr/share/applications/org.kde.kdeconnect_open.desktop
    rm -rf /usr/share/applications/org.kde.kinfocenter.desktop

    set_hostname "${VK_HOSTNAME:-openkylin}"

    if [ -f /lib/systemd/system/dnsmasq.service ]; then
        systemctl disable dnsmasq.service
    fi

    # 设置时区
    echo "Asia/Shanghai" >/etc/timezone
    rm -rf /etc/localtime
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

    echo "---> file system make finish"

    export HISTSIZE=0
    rm -rf /var/cache/apt/archives/*.deb
    if (: "${VK_KEEP_VAR_LIB_APT_LISTS}") 2>/dev/null && [ "${VK_KEEP_VAR_LIB_APT_LISTS}" = "y" ]; then
        rm -rf /var/cache/apt/*.bin
        rm -rf /var/lib/apt/lists/*_Packages
        rm -rf /var/lib/apt/lists/*_InRelease
        rm -rf /var/lib/apt/lists/*_Translation*
        rm -rf /root/.bash_history
        rm -rf /tmp/*
        rm -rf ~/.bash_history
    fi
}

# 设置默认语言为中文
function config_zh_cn() {
    cat >/etc/locale.gen <<EOF
zh_CN.UTF-8 UTF-8
en_US.UTF-8 UTF-8
EOF

    cat >/etc/default/locale <<EOF
LANG=zh_CN.UTF-8
LANGUAGE="zh_CN:zh"
EOF

    locale-gen
}

# 设置默认语言为英文
function config_en_utf8() {
    cat >/etc/locale.gen <<EOF
en_US ISO-8859-1
en_US.UTF-8 UTF-8
EOF

    cat >/etc/default/locale <<EOF
LANG=en_US.UTF-8
LANGUAGE="en_US:en"
EOF

    locale-gen
}
