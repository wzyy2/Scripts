# /bin/sh

sudo route delete default
sudo route add -net 10.10.0.0 netmask 255.255.0.0 gw 172.16.21.1 metric 30 dev eth0
sudo route add default gw 192.168.31.1 dev wlan1


nmcli connection modify aef90753-c540-45f9-9029-afb827eb7dd1 +ipv4.addresses 10.42.1.1/24

