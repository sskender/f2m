#!/bin/bash

F2MHOME="https://f2m.nyqcd.org"
SAVE="F2M"

mkdir $SAVE && cd $SAVE

# list of predmeti
for i in \
    $(curl $F2MHOME | \
    grep "indexcolicon" | grep "\[DIR\]" | awk -F'href="' '{print $2}' | awk -F'">' '{print $1}')
do
    # predmet folder and download
    mkdir $i

    for file in \
        $(curl $F2MHOME/$i | \
        grep "indexcolicon" | grep "td" | grep -v "PARENT" | awk -F'href="' '{print $2}' | awk -F'"><' '{print $1}')
    do
        wget "$F2MHOME/$i/$file" -P $i
    done

done
