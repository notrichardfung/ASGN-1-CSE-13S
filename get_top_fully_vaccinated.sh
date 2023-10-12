#!/bin/bash

# Check if the number of arguments is 2
if [ $# -ne 2 ]; then
    echo "Invalid number of arguments"
    exit 1
fi

# Get the input parameters
file=$1
k=$2

# Check if the file exists and is readable
if [ ! -r $file ]; then
    echo "Cannot find/read $file"
    exit 1
fi

# Print the top-k counties with the highest percentage of fully vaccinated population
awk -F, 'NR>1 {print $1 "," $2 "," $3}' $file | sort -t, -k3,3nr -k1,1 | head -$k
