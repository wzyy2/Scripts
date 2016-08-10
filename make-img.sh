#!/bin/bash -e

export ARCH=arm 
export CROSS_COMPILE=arm-none-eabi-

LOCALPATH=$(pwd)
ROOTDIR=$(dirname $(dirname $(readlink -f $0)))
OUT=${LOCALPATH}/
IMAGE=${LOCALPATH}/
BOARD=$1
DEFCONFIG=""
DTB=""
KERNELIMAGE=""

finish() {
    echo -e "\e[31m MAKE KERNEL IMAGE FAILED.\e[0m"
    exit -1
}
trap finish ERR

if [ $# != 1 ] ; then
    BOARD=rk3288-evb
fi

KERNELIMAGE=kernel.img

[ ! -d ${OUT} ] && mkdir ${OUT}
[ ! -d ${IMAGE} ] && mkdir ${IMAGE}

case ${BOARD} in
    "rk3288-evb")
        DEFCONFIG=rockchip_linux_defconfig
        DTB=rk3288-evb-act8846.dtb
        ;;
    "kylin")
        DEFCONFIG=rockchip_linux_defconfig
        DTB=rk3036-kylin.dtb
        ;;
    "firefly")
        DEFCONFIG=rockchip_linux_defconfig
        DTB=rk3288-firefly.dtb
        ;;
    "rk3036evb")
        DEFCONFIG=rockchip_linux_defconfig
        DTB=rk3036-evb.dtb
        ;;        
     "fennec")
        DEFCONFIG=rockchip_linux_defconfig
        DTB=rk3288-fennec.dtb
        ;;               
    *)
        echo "board '${BOARD}' not supported!"
        return
        ;;
esac

echo Building kernel for ${BOARD} board!
echo Using ${DEFCONFIG}

cd ${LOCALPATH}
make ${DEFCONFIG}
make  -j8
scripts/mkkrnlimg arch/arm/boot/zImage kernel.img>/dev/null
echo '  Image:  kernel.img is ready'
scripts/resource_tool arch/arm/boot/dts/${DTB}
echo " Image:  resource.img (with '${DTB}' is ready"

cat arch/arm/boot/zImage arch/arm/boot/dts/${DTB} > kernel2.img.zimage
mkimage -A arm -O linux -T kernel -C none -a 0x60800800 -d kernel2.img.zimage kernel2.img
rm kernel2.img.zimage
echo '  Image:  kernel2.img (with ${DTB} is ready'

cp arch/arm/boot/zImage ./
cp arch/arm/boot/dts/${DTB} ./
