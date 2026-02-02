#!/bin/bash
# Extract tar.gpg file
gpg --decrypt "$1" | tar --extract --verbose --file -
