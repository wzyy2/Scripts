git branch --set-upstream-to=origin/morty morty

make ARCH=arm savedefconfig && mv defconfig arch/arm/configs/rockchip_linux_defconfig
make ARCH=arm64 savedefconfig && mv defconfig arch/arm64/configs/rockchip_linux_defconfig

/workbench/debian-sdk/kernel/scripts/Lindent  *.c


astyle *.c  --style=knf --indent=tab

./scripts/checkpatch.pl -f outging/*
./scripts/get_maintainer.pl arch/arm/mach-rockchip -f
git send-email outgoing/* --to ***@gmail.com --cc ***@rock-chips.com
