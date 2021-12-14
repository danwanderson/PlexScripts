#!/usr/bin/env bash

set -euo pipefail
# set -x
IFS=$'\n\t'

# get input from cli
# sample usage: find . -type f -print0 | parallel -0 -n 1 -r ~/par2.sh
file="${1}"

# skip anything other than par2 files
if ! [[ ${file} =~ "par2" ]];
then
    if ! [ -f "${file}.par2" ];
    then
        echo "${file} does not have a par2 created"
        exit 0
    fi
    exit 0
fi

# skip volume files
if [[ ${file} =~ "vol.*par2" ]];
then
    exit 0
fi

# run a verify on the par2 file
if [[ ${file} =~ "par2" ]];
then
    par2 verify -q "${file}"
fi
