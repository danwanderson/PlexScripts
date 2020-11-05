#!/usr/bin/env bash

# Enable "strict mode" - http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Variables
PLEX_LIBRARY_DIR="${HOME}/plex/config"
NOW=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="${HOME}/plex_backup_${NOW}.tar"
LOCK_FILE="${HOME}/backup_plex_lock"
# NFS mount
BACKUP_DIR="/mnt/Plex/backup"

function finish {
    rm -f "$LOCK_FILE"
}
trap finish EXIT SIGINT SIGTERM

if [ -f "$LOCK_FILE" ];
then
    echo "Lock file exists. Is there another backup running?"
    exit 2
else
    touch "$LOCK_FILE"
fi

if [ ! -d "$PLEX_LIBRARY_DIR" ];
then
    echo "Plex library directory not found"
    exit 1
fi

# Try to mount the NFS directory if it doesn't exist
if [ ! -d "${BACKUP_DIR}" ];
then
    sudo mount -a
fi

# Likely because the NFS mount failed
if [ ! -d "${BACKUP_DIR}" ];
then
    echo "Plex backup directory not found"
    exit 1
fi

cd "$PLEX_LIBRARY_DIR" || exit

tar --exclude="Cache/*" --exclude="Crash Reports/*" -cvf "$BACKUP_FILE" ./*

mv "$BACKUP_FILE" "$BACKUP_DIR"

BACKUP_FILENAME=$(basename "${BACKUP_FILE}")

ln -sf "${BACKUP_DIR}/${BACKUP_FILENAME}" "${BACKUP_DIR}/plex_backup_latest.tar"
