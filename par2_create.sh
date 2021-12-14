#!/usr/bin/env bash

set -euo pipefail
# set -x
IFS=$'\n\t'

# get input from cli
# sample usage: find . -type f -print0 | parallel -0 -n 1 -r ~/par2_create.sh
file="${1}"

# skip par2 files
if [[ ${file} =~ "par2" ]];
then
    exit 0
fi

# skip .DS_Store files
if [[ ${file} =~ ".DS_Store" ]];
then
    exit 0
fi


# If we already have a PAR file, skip creating one
if [ -f "${file}.par2" ];
then
    exit 0
else
    par2 create -q "${file}.par2" "${file}"
fi
