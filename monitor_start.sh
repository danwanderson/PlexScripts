#!/usr/bin/env bash

function do_ping {
    fping 4.2.2.2
    return $?
}

function bounce_network {
    sudo ifdown bond0
    sleep 10s
    sudo ifup bond0
    sudo mount -a
}

function check_mounts {
    mount | grep '/mnt/Plex'
    return $?
}

function is_plex_running {
    docker ps | grep pms-docker
    return $?
}

function start_plex {
    cd ${HOME}/plex || exit
    if [ -f docker-compose.yml ];
    then
       docker-compose up -d
    else
        echo "docker-compose.yml not found"
        exit 2
    fi
}

while ! [ do_ping ];
do
    bounce_network
    sleep 10s
    if [ check_mounts ];
    then
        start_plex
        sleep 10s
        if [ is_plex_running ];
        then
            "Plex server successfully started"
            exit 0
        fi
    fi
done
