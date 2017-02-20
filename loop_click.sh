
loop=0

X_point=$1
Y_point=$2

while true;do

echo "Loop: $loop"
date

xdotool mousemove $X_point $Y_point

sleep 1

xdotool click 1
xdotool click 1

sleep 60

echo ""
echo ""

loop=$(($loop+1))
done
