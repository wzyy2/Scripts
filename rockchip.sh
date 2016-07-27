#!/bin/bash

function link_mali() {
if [ "$1" == "rk3288" ];
then
    dpkg --remove --force-depends libmali-rk-utgard0 
    dpkg -i  /packages/libmali/libmali-rk-midgard0_1.4-4_armhf.deb
    rm -rf /packages
else
    dpkg --remove --force-depends libmali-rk-midgard0 
    dpkg -i  /packages/libmali/libmali-rk-utgard0_1.4-4_armhf.deb
    rm -rf /packages
fi

}

if [ ! -e "/usr/local/first_boot" ] ;
then
    echo "It's the first time booting."
    echo "The rootfs will be configured, according to your chip."
    touch /usr/local/first_boot
    COMPATIBLE=$(cat /proc/device-tree/compatible)
    CHIPNAME=${COMPATIBLE##*rockchip,}
    
    link_mali ${CHIPNAME}
    setcap CAP_SYS_ADMIN+ep /usr/bin/gst-launch-1.0

    ldconfig
fi

