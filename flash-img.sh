#!/bin/bash -e

METHOD=$1
if [ $# != 1 ] ; then
    METHOD="rk"
fi

case ${METHOD} in
	"rk")
		sudo ~/bin/upgt di -k kernel.img 
		sudo ~/bin/upgt di resource resource.img
	;;
	"gpt")
		sudo fastboot -i 0x2207 flash boot_a  kernel.img
	;;
esac





# sudo fastboot -i 0x2207 flash userdata ./image/kylin-rootfs.img
