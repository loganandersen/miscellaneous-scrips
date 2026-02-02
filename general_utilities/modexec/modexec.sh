#!/bin/bash
# modexec will take a script name and then let you modify it, and
# execute that script on the rest of the arguments. Example

# example, modexec play-youtube-links thread

modscript=$(mktemp)
# Grab the name of the command I want
command="$1"
shift

#copy command over to the temp file
cp "$(which "$command")" "$modscript"

#make tempfile executable
chmod 755 "$modscript"

#edit the command
$EDITOR "$modscript"

#run it with args
"$modscript" "$@"

#delete tempfiles
rm "$modscript"
