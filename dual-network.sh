# /bin/sh

sudo route delete default
sudo route add -net 10.10.0.0 netmask 255.255.0.0 gw 172.16.21.1 metric 30 dev eth0
sudo route add default gw 192.168.31.1 dev wlan1

