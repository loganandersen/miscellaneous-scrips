#!/usr/bin/env bash
# /home/loga/Documents/programs/laptop/shell/general_usefull_utilities/output_files_pretty/output-files-pretty.sh
# Logan Andersen
# July 21 2025
#
# output-files-pretty [FILE] ...
# this program outputs a file with its filename, a bar of ===== under it, and the line numbers It can do this with multiple files
awk 'BEGINFILE { print FILENAME "\n=================================" } ; { print FNR "\t" $0 } ; ENDFILE {print "\n"}' "$@"

