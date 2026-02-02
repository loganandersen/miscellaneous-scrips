#!/usr/bin/env bash
# Logan Andersen

# View all of the PDFs in a folder, one by one, with them being being
# sorted by modification timestamp.
ls -at *.pdf | while read i ; do zathura "$i" ; done
