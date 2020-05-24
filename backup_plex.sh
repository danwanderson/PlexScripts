#!/usr/bin/env bash

PLEX_LIBRARY_DIR="${HOME}/plex/config"
NOW=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="${HOME}/plex_backup_${NOW}.tar"
LOCK_FILE="${HOME}/backup_plex_lock"

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

cd "$PLEX_LIBRARY_DIR" || exit

tar --exclude="Cache/*" --exclude="Crash Reports/*" -cvf "$BACKUP_FILE" ./*

mv "$BACKUP_FILE" /mnt/Plex/backup