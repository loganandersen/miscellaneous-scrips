#!/usr/bin/env bash
# This script changes the domain of a set of urls in stdin with its
# first argument

# example
# $ echo https://www.x.org/ | x.com
# https://x.com/

newdomain="$1"
shift

sed -E 's/^([^:]*):\/\/([^/]*)'/'\1:\/\/'"$newdomain"/
