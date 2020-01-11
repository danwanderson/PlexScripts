#!/usr/bin/env bash

SUMFILE="Plex_Library_SHA512SUM"

rm -f "$SUMFILE"

find Library/Audiobooks/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/Camera\ Uploads/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/Dee\'s\ Camera\ Uploads/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/Exercise/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/Grooming/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/Misc/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/Misc\ DVD\ Extras/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/Movies/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/Music/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/Music\ Videos/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/Pet\ Training/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/Photos/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/Tablo/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/Tablo\ Movies/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/Technical\ Training/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/TV\ Show\ Extras/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/TV\ Shows/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
find Library/WoW\ Screenshots/ -type f -print0  | xargs -0 sha512sum >> "$SUMFILE"
