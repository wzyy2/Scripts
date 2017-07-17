git branch --set-upstream-to=origin/morty morty

make ARCH=arm savedefconfig && mv defconfig arch/arm/configs/rockchip_linux_defconfig
make ARCH=arm64 savedefconfig && mv defconfig arch/arm64/configs/rockchip_linux_defconfig

/workbench/debian-sdk/kernel/scripts/Lindent  *.c


astyle *.c  --style=knf --indent=tab

./scripts/checkpatch.pl -f outging/*
./scripts/get_maintainer.pl arch/arm/mach-rockchip -f
git send-email outgoing/* --to ***@gmail.com --cc ***@rock-chips.com


git send-email gpu/* --tolinux-rockchip@lists.infradead.org --cc linux-kernel@vger.kernel.org -cc linux-arm-kernel@lists.infradead.org \
 -cc devicetree@vger.kernel.org  -cc heiko@sntech.de -cc robh+dt@kernel.org -cc mark.rutland@arm.com -cc kever.yang@rock-chips.com

git send-email  dts64/* --to linux-rockchip@lists.infradead.org --cc linux-kernel@vger.kernel.org -cc linux-arm-kernel@lists.infradead.org \
 -cc devicetree@vger.kernel.org  -cc heiko@sntech.de   -cc kever.yang@rock-chips.com  -cc kever.yang@rock-chips.com  -cc kever.yang@rock-chips.com


 git send-email  rga/* --to linux-rockchip@lists.infradead.org --cc linux-kernel@vger.kernel.org -cc linux-arm-kernel@lists.infradead.org \
  -cc devicetree@vger.kernel.org  -cc heiko@sntech.de   -cc robh+dt@kernel.org -cc mchehab@kernel.org -cc linux-media@vger.kernel.org -cc laurent.pinchart+renesas@ideasonboard.com \
  -cc hans.verkuil@cisco.com -cc s.nawrocki@samsung.com -cc tfiga@chromium.org -cc nicolas@ndufresne.ca
