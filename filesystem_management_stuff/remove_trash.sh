#!/usr/bin/env bash
# Deletes trash folder

echo The following will be removed, 
ls ~/.trash/ 
echo are you sure you want these to be deleted y/n? 
read answer 

if [ "$answer" == 'y' ] ; then 
        rm -rf -- ~/.trash/*
        echo deleted 
else 
        echo not deleted 
fi

