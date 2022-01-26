#!/usr/bin/env bash

set -euo pipefail
# set -x

NOW=$(date +%Y-%m-%d_%H-%M-%S)
LOCK_FILE="Plex_Library_par2.lock"
LOGFILE="./${NOW}_create_plex_par2_out.log"

function finish {
    rm -f "$LOCK_FILE"
}
trap finish EXIT SIGINT SIGTERM

if ! [ -x $(whence par2) ];
then
    echo "Please install par2 (apt install par2)"
    exit 3
fi

if [ -f "$LOCK_FILE" ];
then
    echo "Lock file exists. Is there another job running?"
    exit 2
else
    touch "$LOCK_FILE"
fi

if ! [ -d "Library" ];
then
    echo "Please cd to the parent directory of the Library"
    exit 1
fi

{
    find Library/American\ Truck\ Simulator\ Screenshots/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Audiobooks/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Camera\ Uploads/ -type f  ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Camera\ Uploads\ 2020/ -type f  ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Dee\'s\ Camera\ Uploads/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Exercise/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Grooming/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Misc/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Misc\ DVD\ Extras/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Movies/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Music/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Music\ Videos/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Pet\ Training/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Photos/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Podcasts/ -type f  ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Radio\ Shows/ -type f  ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Tablo/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Tablo\ Movies/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/Technical\ Training/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/TV\ Show\ Extras/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/TV\ Shows/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
    find Library/WoW\ Screenshots/ -type f ! -name '*@*' -print0  | parallel --null --max-args=1 --no-run-if-empty ./par2_create.sh
} > ${LOGFILE}