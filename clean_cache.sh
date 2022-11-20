#!/usr/bin/env bash

DRYRUN=1

# Enable "strict mode" - http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

CACHEDIR="${HOME}/plex/config/Library/Application Support/Plex Media Server/Cache"

# make sure cache directory exists
cd "${CACHEDIR}" || exit

# Find files older than 7 days
if [[ ${DRYRUN} -eq 1 ]];
then
    find "${CACHEDIR}/PhotoTranscoder" -mtime +7 -depth -print
else
    find "${CACHEDIR}/PhotoTranscoder" -mtime +7 -depth -delete
fi