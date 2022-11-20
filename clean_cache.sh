#!/usr/bin/env bash

# Enable "strict mode" - http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'


DRYRUN=1

function cleanup() {
    exit
}

function usage() {
    echo "Usage $0 [OPTIONS]"
    echo ""
    echo "-d|--dryrun           Don't print built output"
    echo "-n|--nodryrun           Don't print built output"
    echo "-h|--help             Print this message and exit"
}

trap cleanup SIGINT SIGTERM

while (( $# ));
do
    case "$1" in
        --) # end argument parsing
            shift
            break
            ;;
        -h|--help)
            usage
            exit
            ;;
        -d|--dryrun)
            DRYRUN=1
            shift
            ;;
        -n|--no_dryrun|--nodryrun)
            DRYRUN=0
            shift
            ;;
        --debug)
            set -x
            shift
            ;;
        -*|--*=) # unsupported flags
            echo "Error: unsupported flag $1" >&2
            exit 2
            ;;
        *) # Preserve positional arguments
            PARAMS="$PARAMS $1"
            shift
            ;;
    esac
done

# Set positional arguments in their proper place
eval set -- "$PARAMS"

CACHEDIR="${HOME}/plex/config/Library/Application Support/Plex Media Server/Cache"

# make sure cache directory exists
cd "${CACHEDIR}" || exit

# Find files older than 7 days
if [[ ${DRYRUN} -eq 1 ]];
then
    find "${CACHEDIR}/PhotoTranscoder" -depth -mtime +14 -print
else
    find "${CACHEDIR}/PhotoTranscoder" -depth -mtime +14 -delete
fi