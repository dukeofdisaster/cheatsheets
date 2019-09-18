#!/bin/sh
# Credits to: https://github.com/scipag/nac_bypass
while true
do
    NETWORK_STATE_INTERFACE=`cat "/sys/class/net/$INTERFACE/carrier"`

    if [ "$NETWORK_STATE_INTERFACE" -ne "$STATE_INTERFACE" ]; then

        STATE_COUNTER=0

        if [ "$NETWORK_STATE_INTERFACE" -eq 1 ]; then
            echo "[!] $INTERFACE is now up!"
        else
            echo "[!] $INTERFACE is now down!"
        fi
    else

        if [ "$STATE_COUNTER" -eq "$THRESHOLD_UP" ] && [ "$NETWORK_STATE_INTERFACE" -eq 1 ]; then
            echo "[!!] Set new config"
            bash nac_bypass_setup.sh -a -c

        elif [ "$STATE_COUNTER" -eq "$THRESHOLD_DOWN" ] && [ "$NETWORK_STATE_INTERFACE" -eq 0 ]; then
            echo "[!!] Reset config"
            bash nac_bypass_setup.sh -a -r
            bash nac_bypass_setup.sh -a -i
        fi

        echo "[*] Waiting"
        ((STATE_COUNTER++))
    fi

    STATE_INTERFACE=$NETWORK_STATE_INTERFACE
    sleep $TIMER
done
