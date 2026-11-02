#!/bin/bash
set -e

# 解析宿主环境传递参数
for item in $*; do
    if grep -q "^VK.*=" <<<"${item}"; then
        KEY=${item%%=*}
        VALUE="${item##*=}"
        eval "export ${KEY}='${VALUE}'"
    fi
done

# 系统版本信息
[ -f /etc/os-release ] && source /etc/os-release

CURRENT_DIR=$(dirname "$(readlink -f "$0")")
[ -f "${CURRENT_DIR}"/public.sh ] && . "${CURRENT_DIR}"/public.sh
[ -f "${CURRENT_DIR}"/private.sh ] && . "${CURRENT_DIR}"/private.sh

CURRENT_ARCH=$(dpkg --print-architecture)

# 设置内网源
. "${CURRENT_DIR}"/apt_source-${CURRENT_ARCH}.sh

# 制作系统
if [ "${VK_CURRENT_TASK}" = "config" ]; then
    if (: "${VK_UPDATE}") 2>/dev/null && [ "${VK_UPDATE}" = "y" ]; then
        if [ -f /rootfs.deblist ] && [ ! -f /rootfs-update.deblist ]; then
            # 升级基础包
            for pkg in $(awk '{print $1}' /rootfs.deblist); do
                if ! grep "\-dbgsym$" <<<${pkg}; then
                    # MY_LOG_EXEC apt-get install -y -q --allow-downgrades ${pkg}
                    :
                else
                    MY_LOG_EXEC apt-get purge -y ${pkg}
                fi
            done
            # 升级后的列表
            dpkg-query -W --showformat='${Package} ${Version}\n' >/rootfs-update.deblist
            rm -rf /var/cache/apt/archives/*.deb
        fi
    fi

    run_scripts "${CURRENT_DIR}"/shells
else
    . "${CURRENT_DIR}"/${VK_CURRENT_TASK}.sh
fi

# 设置公网源
. "${CURRENT_DIR}"/apt_public-${CURRENT_ARCH}.sh

finish
