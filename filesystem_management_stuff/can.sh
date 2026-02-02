#!/bin/bash
#this program cans a file (it puts it in the ~/.trash folder)
#I created this to avoid using rm for everything

time="$(date +%s)"

number=1

while [ "${!number}" != "" ] 
do
	name="$(basename -- "${!number}")"
	mv -- "${!number}" ~/".trash/$time-$name"
	number=$(("$number" + 1)) 
done 

