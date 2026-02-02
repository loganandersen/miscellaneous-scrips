#!/usr/bin/env bash
# wikipedia-gencite.sh
# Generates a bibtex citation from wikipedia link
# 2025-06-23 Updated this to add commas to the citation 


# Dump the webpages
lynx -dump -listonly "$@" |
    grep -o 'https.*Special:CiteThisPage.*' | # look for links that say CiteThisPage
    sed 's/https:\/\/en.wikipedia.org\/w\/index.php?title=Special:CiteThisPage&page=\([^&]*\)&id=\([^&]*\).*/@misc{wikipedia'"$(date +'%Y')"'\1,\n  author={{Wikipedia contributors}},\n  title={\1},\n  date={'"$(date +'%Y-%m-%d')"'},\n  url={https:\/\/en.wikipedia.org\/w\/index.php?title=\1\&oldid=\2},\n  urldate={'"$(date +'%Y-%m-%d')"'}\n}\n/' # Extract data from the CiteThisPage link to create a citation. The link has all the data you need to create a citation so there's no need to actually open the webpage.

###################################################################
# example url extracted with wget and grep: https://en.wikipedia.org/w/index.php?title=Special:CiteThisPage&page=Chinese_characters&id=1292058245&wpFormIdentifier=titleform

# Explaination of sed expression
# First half: 's/https:\/\/en.wikipedia.org\/w\/index.php?title=Special:CiteThisPage&page=\([^&]*\)&id=\([^&]*\).*/'
# Remove the front part https:\/\/en.wikipedia.org\/w\/index.php?title=Special:CiteThisPage&
# Grab the page name: page=\([^&]*\)& 
# Grab the id name: id=\([^&]*\)
# Remove everything else .*/
# Second Half: @misc{wikipedia'"$(date +'%Y')"'\1\n  author={{Wikipedia contributors}}\n  title={\1}\n  date={'"$(date +'%Y-%m-%d')"'}\n  url={https:\/\/en.wikipedia.org\/w\/index.php?title=\1\&oldid=\2}\n  urldate=\{2025-05-24\}\n}\n/
# @misc{wikipedia'"$(date +'%Y')"'\1\n : create first line that looks like something like this: @misc{wikipedia2025Omorashi
#   author={{Wikipedia contributors}}\n  title={\1}\n  date={'"$(date +'%Y-%m-%d')"'}\n fairly obvious
# url={https:\/\/en.wikipedia.org\/w\/index.php?title=\1\&oldid=\2}\n create new URL that links to the exact wikipedia version
# 

# Potential improvements I would like it if I could remove the _s from
# the title and lowercase it in the first part. I could probably do
# this by changing the seperator and using read. I would replace sed
# expression with one that just creates a nice amount of variables IE
# \1\t\2 use read to read them in and then finally cat into a here doc
# with $() to do what I want. Probably do while read.

# I should also change it so HTML codes like %28 turn into their
# literal characters IE. "("
