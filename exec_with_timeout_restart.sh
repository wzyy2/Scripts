#!/bin/bash

killtree() {
    local _pid=$1
    local _sig=${2:--TERM}
    kill -stop ${_pid} # needed to stop quickly forking parent from producing children between child killing and parent killing
    for _child in $(ps -o pid --no-headers --ppid ${_pid}); do
        killtree ${_child} ${_sig}
    done
    kill -9 ${_pid}
}

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

main() {
    ( $@ ) & pid=$!
    ( sleep $TIMEOUT && killtree $pid) 2>/dev/null & watcher=$!

    wait $pid 2>/dev/null
    RET=$?
    echo $RET

    pkill -HUP -P $watcher
    wait $watcher

    if [ $RET -eq 137 ]; then
        echo "command timeout, restart"
        main $@
    elif [ $RET -eq 0 ]; then
        echo "command finished"
        exit 0
    else
        echo "command wrong"
        exit 1
    fi
}

main $@
