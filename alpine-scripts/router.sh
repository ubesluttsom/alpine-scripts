#!/bin/sh

set -e

echo "Configuring Ethernet devices ..."
echo 'auto eth1
iface eth1 inet static
      address 10.0.1.0
      netmask 255.255.255.0

auto eth2
iface eth2 inet static
      address 10.0.2.0
      netmask 255.255.255.0

auto eth3
iface eth3 inet static
      address 10.0.3.0
      netmask 255.255.255.0' > /etc/network/interfaces

echo "Set sysctl variables for routing ..."
sysctl -w net.ipv4.conf.all.proxy_arp=1
sysctl -w net.ipv4.ip_forward=1

echo "Resetting network service ..."
rc-update add networking boot
rc-update add dropbear
rc-service networking restart
hostname "router"

echo "Setting up static IP table ..."
ip route add 10.0.0.1/32 dev eth1
ip route add 10.0.0.2/32 dev eth2
ip route add 10.0.0.3/32 dev eth3
ip route show

/root/cong.sh lgc
/root/qdisc.sh 1 2 3
