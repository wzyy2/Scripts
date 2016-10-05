
#!/bin/bash    

function rand(){
    min=$1    
    max=$(($2-$min+1))    
    num=$(date +%s%N)    
    echo $(($num%$max+$min))    
}  

rnd=$(rand 1 50)    
echo $rnd"s" 

dmesg | grep "Modules linked in" 
if [ $? -eq 0 ]       
then  
echo "find bug1"
dmesg > /root/bug$(date +%y%m%d)
else
echo "didn't find1"
fi

sleep $rnd"s" 

dmesg | grep "flush_to_ldisc" 
if [ $? -eq 0 ]       
then  
echo "find bug2"
dmesg > /root/bug$(date +%y%m%d)
else
echo "didn't find2"
fi

sleep $rnd"s"

reboot
