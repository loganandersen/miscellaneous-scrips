#!/usr/bin/env bash 
# this program prints the code of a command (like the listing command
# on prolog) eg: listing listing will print this file
which "$@" | xargs cat
