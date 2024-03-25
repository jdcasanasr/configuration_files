#!/bin/bash
# Check if the script is run as root.
if [ $EUID -ne 0 ]; then
    echo "Error: This script must be run as root. Aborting." 
    exit 1
fi

# Check if a device argument is provided.
if [ $# -eq 0 ]; then
    echo "Error: No device specified. Aborting."
    exit 1
fi

# Check if the device exists.
if [ ! -e "$1" ]; then
	echo "Error: Device $1 not found. Aborting."
	exit 1
fi

# Write zeroes to the device, with its particular
# block size.
device="$1"
block_size=$(blockdev --getbsz "$device")
dd if=/dev/zero of="$device" bs="$block_size" conv=noerror,sync status=progress
