#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Invalid number of arguments"
    exit 1
fi

log_file=$1
# Calculate the total content size and the count of unique response codes

total_size=0
declare -A response_codes
while read -r line; do
    # Parse the content size and response code from the log line
    content_size=$(echo "$line" | awk '{print $NF}')
    response_code=$(echo "$line" | awk '{print $(NF-1)}')
    # Treat "-" as 0 and add the content size to the total
    if [ "$content_size" = "-" ]; then
    content_size=0
    fi
    ((total_size += content_size))
    # Increment the count for the current response code
    ((response_codes[$response_code]++))
done < "$log_file"

# Calculate the average content size and round to the nearest integer
num_requests=$(wc -l < "$log_file")
average_size=$(( (total_size + (num_requests/2)) / num_requests ))

# Count the number of unique response codes
num_response_codes=${#response_codes[@]}

echo "$average_size"
echo "$num_response_codes"