#!/bin/bash
# Check if the number of arguments is 2
if [ "$#" -ne 2 ]; then
    echo "Invalid number of arguments"
    exit 1
fi
# Read the stop words from the file and store them in an array
stop_words=($(<stopwords))
# Read the text file, convert all the words to lowercase, and remove the stop words
# Count the frequency of each word and store the results in an associative array
declare -A word_count
while read -r word; do
    word=${word,,}
    if [[ ! " ${stop_words[@]} " =~ " ${word} " ]]; then
        ((word_count[$word]++))
    fi
done < "$1"
# Print the top k most frequent words
for word in $(printf '%s\n' "${!word_count[@]}" | sort -rnk2 | head -n "$2"); do
    echo "$word"
done
exit 0
