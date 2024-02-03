#!/usr/bin/env bash

#set -euo pipefail

for trailer in *-trailer*; do
    if ! [ -d Trailers ]; then
        mkdir Trailers
    fi
    NEWNAME=$(echo "${trailer}" | sed 's/-trailer//')
    mv -v "${trailer}" Trailers/"${NEWNAME}"
done

for featurette in *-featurette* *-behindthescenes*; do
    if ! [ -d Featurettes ]; then
        mkdir Featurettes
    fi
    NEWNAME=$(echo "${featurette}" | sed 's/-featurette//')
    NEWNAME=$(echo "${NEWNAME}" | sed 's/-behindthescenes//')
    mv -v "${featurette}" Featurettes/"${NEWNAME}"
done

for short in *-short*; do
    if ! [ -d Shorts ]; then
        mkdir Shorts
    fi
    NEWNAME=$(echo "${short}" | sed 's/-short//')
    mv -v "${short}" Shorts/"${NEWNAME}"
done

for deleted in *-deleted*; do
    if ! [ -d Deleted\ Scenes ]; then
        mkdir Deleted\ Scenes
    fi
    NEWNAME=$(echo "${deleted}" | sed 's/-deleted//')
    mv -v "${deleted}" Deleted\ Scenes/"${NEWNAME}"
done

for interview in *-interview*; do
    if ! [ -d Interviews ]; then
        mkdir Interviews
    fi
    NEWNAME=$(echo "${interview}" | sed 's/-interview//')
    mv -v "${interview}" Interviews/"${NEWNAME}"
done
