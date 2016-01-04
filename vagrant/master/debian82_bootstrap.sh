#!/bin/bash

set -e
echo "Installing LXC + libvirt-devel + dependencies"
apt-get update
apt-get install -y libvirt-dev libvirt-bin lxc

echo "Enabling lxc and libvirtd"
systemctl enable lxc
systemctl enable libvirtd
virsh net-autostart default

adduser vagrant libvirt
sed -i.bak "s/^#\(unix_sock_group.*\)$/\1/" /etc/libvirt/libvirtd.conf
sed -i.bak "s/^\(GRUB_CMDLINE_LINUX=\"[^\"]*\\)\"/\1 cgroup_enable=memory\"/" /etc/default/grub
update-grub

