#!/bin/bash
# Encrypt tar gpg file
tar --create --verbose --file - "$1" | gpg --symmetric > "$(echo $1 | tr /\  ._ )".tar.gpg
