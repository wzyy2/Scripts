#!/bin/bash -e

# make sure you have install  glmark2

function rand(){
    min=$1    
    max=$(($2-$min+1))    
    num=$(date +%s%N)    
    echo $(($num%$max+$min))    
}  

while true; 
do 
	CPU_TEMP=`cat /sys/class/thermal/thermal_zone1/temp` ;  
	GPU_TEMP=`cat /sys/class/thermal/thermal_zone2/temp` ; 
	GPU_FREQ=`cat /sys/devices/platform/ffa30000.gpu/devfreq/ffa30000.gpu/cur_freq`; 
	CPU_FREQ=`cat  /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq`; 
	echo "CPU_TEMP" + $CPU_TEMP ; 
	echo "GPU_TEMP" + $GPU_TEMP ; 
	echo "CPU_FREQ" + $CPU_FREQ ;  
	echo "GPU_FREQ" + $GPU_FREQ ; 
	sleep 2; 
done & 
 

while true; 
do 
	rnd=$(rand 100 600) ;

	# cpu stress
	stress  --cpu 6  --io 4  --vm 2  --vm-bytes 128M --timeout 1000 &

	# gpu and cpu stress
	su linaro -c "DISPLAY=:0.0 glmark2-es2 --benchmark refract --run-forever --off-screen" &
	su linaro -c "DISPLAY=:0.0 glmark2-es2 --benchmark refract --run-forever --off-screen" &
	su linaro -c "DISPLAY=:0.0 glmark2-es2 --benchmark refract --run-forever --off-screen" &
	# Sleep and  the stress tool will run in backend
	sleep $rnd;

	killall stress;
	killall glmark2-es2 ;

	# Let temperature down, because we want gpu + cpu both run in max freq 
	# and temperature control will decrease freq.
	sleep $rnd;
done 
