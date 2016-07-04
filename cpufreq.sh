cat > /sbin/cpufreq.sh <<EOF
#!/bin/sh


# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_f requencies
# 126000 216000 408000 600000 696000 816000 1008000 1200000 1416000 1512000 1608000 1704000 1800000
echo 216000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 216000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq


echo 0 > /sys/devices/system/cpu/cpu1/online
echo 0 > /sys/devices/system/cpu/cpu2/online
echo 0 > /sys/devices/system/cpu/cpu3/online

echo "online cpu is: cpu`cat /sys/devices/system/cpu/online`"
echo "cpu freq is `cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq`"

echo "gpu freq is `cat /sys/devices/ffa30000.gpu/clock`"


EOF

chmod +x /sbin/cpufreq.sh


cd /sys/devices/ff610000.dmc/devfreq/ff610000.dmc
echo userspace > governor
echo 200000000 > userspace/set_freq
