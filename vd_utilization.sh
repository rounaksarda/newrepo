#!/bin/bash

# Set the threshold for underutilization 
THRESHOLD=20

# Run df command to get disk usage information
DISK_USAGE=$(df -h | awk 'NR>1 {print $5}' | sed 's/%//')

# Loop through the disk usage values and check for underutilization
UNDERUTILIZED=0
while read -r USAGE; do
    if ((USAGE < THRESHOLD)); then
        UNDERUTILIZED=1
	echo $USAGE
    fi
done <<< "$DISK_USAGE"

# Check if any disk is underutilized and print the result
if [ $UNDERUTILIZED -eq 1 ]; then
    echo "The virtual hard drive is underutilized."
else
    echo "The virtual hard drive is adequately utilized."
fi

