#!/bin/bash

# NetworkManager
if [ -d /etc/NetworkManager/conf.d ]; then
    touch /etc/NetworkManager/conf.d/10-globally-managed-devices.conf
fi

# ssh allow root login
{
    if [ -f /etc/ssh/sshd_config ]; then
        if ! grep -q "^PermitRootLogin yes$" /etc/ssh/sshd_config; then
            sed -i.bak '/PermitRootLogin/d' /etc/ssh/sshd_config
            echo 'PermitRootLogin yes' >>/etc/ssh/sshd_config
        fi
    fi
}
