#!/usr/bin/env bash
# This program analyzes each file for a hash and prints a report with
# each hash and each duplicate

# Updated 2025-01-21 used uniq --all-repeated instead of uniq -c | awk ...
# I also removed cut -d, and the grep statement and used the field
# operators with sort and uniq instead. This allowed me to remove the
# use of temporary files entirely

# Every hash is exactly 32 characters long, if there was a way to work
# by fields, I would have done that instead.
find "$@" -type f -exec md5sum {} \; |
    sort |
    uniq --all-repeated --check-chars=32 
