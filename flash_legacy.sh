sudo upgrade_tool ul loader.bin
sudo upgrade_tool di -p parameter
sudo upgrade_tool di -k kernel.img

# rk3288
sudo upgrade_tool di -b boot_no_package_kernel.img

sudo upgrade_tool di uboot uboot.img || true
sudo upgrade_tool di trust trust.img || true
sudo upgrade_tool di resource resource.img
sudo upgrade_tool di linuxroot root.img
sudo upgrade_tool rd
