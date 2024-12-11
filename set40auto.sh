#!/bin/bash

# usage ./set40.sh <powerlevel>
if [[ -z $1 ]]; then
    echo "Usage: $0 <powerlevel>"
    exit 1
fi

# Path to the NIC configuration file
FILE="/etc/default/wifibroadcast"

# Extract NIC names from the configuration file
if [[ -f "$FILE" ]]; then
    NIC_NAMES=$(grep -oP '^WFB_NICS="\K[^"]+' "$FILE")
    
    if [[ -n "$NIC_NAMES" ]]; then
        # Convert NIC names into an array
        IFS=' ' read -r -a NICS <<< "$NIC_NAMES"
    else
        echo "No NIC names found in WFB_NICS variable. Exiting."
        exit 1
    fi
else
    echo "File $FILE not found. Exiting."
    exit 1
fi

# Begin script execution
echo "Stopping wifibroadcast"
sudo systemctl stop wifibroadcast

echo "Unloading 88XXau_wfb module"
sudo modprobe -r 88XXau_wfb
sleep 1

echo "Loading 88XXau_wfb module with power level $1"
sudo modprobe 88XXau_wfb rtw_tx_pwr_idx_override=$1
sleep 5

echo "Setting NICs to 40MHz"
for NIC in "${NICS[@]}"; do
    echo "Configuring NIC: $NIC"
    sudo iw dev "$NIC" set channel 161 HT40+
done

echo "Starting wifibroadcast"
sudo systemctl start wifibroadcast

