#!/bin/sh
qemu-system-aarch64 -m 1024 -cpu cortex-a72 -M virt -nographic --no-reboot -kernel ../linux/arch/arm64/boot/Image -append "console=ttyAMA0 root=/dev/vda vm=router1" -drive file=../alpine-rootfs/rootfs.img,format=raw,snapshot=on -netdev user,id=netuser,net=192.168.100.0/24,hostfwd=tcp::2210-:22 -device e1000,netdev=netuser -netdev socket,id=netvm1,listen=:53481 -device e1000,netdev=netvm1 -object filter-dump,id=filtervm1,netdev=netvm1,file=/tmp/router1-vm1.pcap -netdev socket,id=netrouter2,listen=:38187 -device e1000,netdev=netrouter2 -object filter-dump,id=filterrouter2,netdev=netrouter2,file=/tmp/router1-router2.pcap