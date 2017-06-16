git branch --set-upstream-to=origin/morty morty

make ARCH=arm savedefconfig && mv defconfig arch/arm/configs/rockchip_linux_defconfig
make ARCH=arm64 savedefconfig && mv defconfig arch/arm64/configs/rockchip_linux_defconfig
