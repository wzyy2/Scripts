#!/bin/bash
# dmesg | egrep 'isp|camera|5695|v4l2'

echo 1 > /sys/module/video_rkisp1/parameters/debug
#echo 7 > /sys/module/videobuf2_core/parameters/debug

function trace_on {
	cd /sys/kernel/debug/tracing/
	echo function_graph > current_tracer 
	echo 0 > tracing_on 
	echo > trace
	echo rkisp1_isp_isr >> set_ftrace_filter 

	echo 1 > tracing_on

}

function trace_off {
	cd /sys/kernel/debug/tracing/
	echo 0 > tracing_on
	cat trace > /tmp/trace
}

function links_enable {
	media-ctl -l '"ov5695 7-0036":0->"rockchip-sy-mipi-dphy":0[1]'
	media-ctl -l '"rockchip-sy-mipi-dphy":1->"rkisp1-isp-subdev":0[1]'
	media-ctl -l '"rkisp1-input-params":0->"rkisp1-isp-subdev":1[1]'
	media-ctl -l '"rkisp1-isp-subdev":2->"rkisp1_mainpath":0[1]'
	media-ctl -l '"rkisp1-isp-subdev":2->"rkisp1_selfpath":0[1]'
	media-ctl -l '"rkisp1-isp-subdev":3->"rkisp1-statistics":0[1]'
}

function stream_restart_test {
	for i in $(seq 1 100000)
	do
		sleep .5
		time=$(( $RANDOM % 3 + 2 ))
		echo Test seq $i last $time seconds
		timeout $time v4l2-ctl -d /dev/video3 --stream-mmap=8 --stream-to=/dev/null --stream-count=600000 --stream-poll;
	done
}

function arc_test {
	arc_camera3_test --gtest_filter=Camera3FrameTest/Camera3MultiFrameTest.GetFrame/5
}

function mock_hal_test {
	media-ctl -vvv -d /dev/media0 --set-v4l2 '"ov5695 7-0036":0[fmt:SBGGR10/640x480]'
	media-ctl -vvv -d /dev/media0 --set-v4l2 '"rkisp1-isp-subdev":0[fmt:SBGGR10/640x480]' #sink
	media-ctl -vvv -d /dev/media0 --set-v4l2 '"rkisp1-isp-subdev":0[fmt:SBGGR10/640x480]' --set-v4l2 '"rkisp1-isp-subdev":0[crop:(0,0)/640x480]' #sink
	media-ctl -vvv -d /dev/media0 --set-v4l2 '"rkisp1-isp-subdev":2[fmt:YUYV2X8/640x480]' #source
	media-ctl -vvv -d /dev/media0 --set-v4l2 '"rkisp1-isp-subdev":2[fmt:YUYV2X8/640x480]' --set-v4l2 '"rkisp1-isp-subdev":2[crop:(0,0)/640x480]'

	# self path
	WIDTH=640 #output
	HEIGHT=480
	WIDTH_CROP=640
	HEIGHT_CROP=480
	v4l2-ctl -d /dev/video3 --set-selection=target=crop,top=0,left=0,width=$WIDTH_CROP,height=$HEIGHT_CROP --set-fmt-video=width=$WIDTH,height=$HEIGHT,pixelformat=NV21 --stream-mmap=8 --stream-to=/tmp/self.stream.out --stream-count=3 --stream-poll > /dev/kmsg 2>&1
}

links_enable
trace_on
mock_hal_test
trace_off
