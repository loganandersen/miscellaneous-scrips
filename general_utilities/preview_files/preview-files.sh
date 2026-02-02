#!/usr/bin/env bash
# Logan Andersen
# /home/loga/Documents/programs/laptop/shell/general_usefull_utilities/preview_files/preview_files.sh

# This program gives you a random file for each folder in the directory. (May be slow)

# TODO options, make it so we can change the maxdepth of the find expressions and so that we can change how many items in each folder we print.

find "$@" -maxdepth 1 -type d |
    while read folder
    do
	find "$folder" -maxdepth 1 -type f | shuf | head -n 1
    done

