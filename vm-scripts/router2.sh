#!/bin/sh
qemu-system-aarch64 -m 1024 -cpu cortex-a72 -M virt -nographic --no-reboot -kernel ../linux/arch/arm64/boot/Image -append "console=ttyAMA0 root=/dev/vda vm=router2" -drive file=../alpine-rootfs/rootfs.img,format=raw,snapshot=on -netdev user,id=netuser,net=192.168.100.0/24,hostfwd=tcp::2220-:22 -device e1000,netdev=netuser -netdev socket,id=netvm2,listen=:57985 -device e1000,netdev=netvm2 -object filter-dump,id=filtervm2,netdev=netvm2,file=/tmp/router2-vm2.pcap -netdev socket,id=netrouter1,connect=:38187 -device e1000,netdev=netrouter1 -object filter-dump,id=filterrouter1,netdev=netrouter1,file=/tmp/router2-router1.pcap -netdev socket,id=netvm3,listen=:44585 -device e1000,netdev=netvm3 -object filter-dump,id=filtervm3,netdev=netvm3,file=/tmp/router2-vm3.pcap