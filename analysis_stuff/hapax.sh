#!/usr/bin/env bash
# Prints the hapax legomina of the files
sed -e 's/\b/\n/g' "$@" | tr -d ' \t\r\v\f' | sort | uniq -c | sort -rn
