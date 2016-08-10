/*
 * Copyright (C) 2013-2015 ROCKCHIP, Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/etherdevice.h>
#include <linux/of.h>
#include <linux/of_net.h>

#define MAC_INDEX

/**
 * rk_dt_set_mac_from_efuse - Add mac-address property using
 * ethernet hwaddr from efuse
 * @np:		Pointer to the gmac to set mac address of
 */
static void rk_dt_set_mac_from_efuse(struct device_node *np)
{
	struct property *prop;
	u32 lo, hi;
	u8 *mac;

	lo = 0xfe;
	hi = 0xf0;

	prop = kzalloc(sizeof(*prop) + ETH_ALEN, GFP_KERNEL);
	if (!prop)
		return;

	prop->value = prop + 1;
	prop->length = ETH_ALEN;
	prop->name = kstrdup("mac-address", GFP_KERNEL);
	if (!prop->name) {
		kfree(prop);
		return;
	}

	mac = prop->value;

	mac[0] = hi;
	mac[1] = hi >> 8;
	mac[2] = hi >> 16;
	mac[3] = hi >> 24;
	mac[4] = lo;
	mac[5] = lo >> 8;

	of_update_property(np, prop);

	pr_info("gmac: No hwaddr in dt. Using %pM from efuse\n", mac);
}

static int __init rk_dt_mac_fixup(void)
{
	struct device_node *np;

	if (0)
		return -ENODEV;

	for_each_compatible_node(np, NULL, "rockchip,rk3288-gmac") {
		if (!of_get_mac_address(np))
			rk_dt_set_mac_from_efuse(np);
	}

	return 0;

}

arch_initcall(rk_dt_mac_fixup);
