#!/usr/bin/env bash

sudo yum localupdate "$1" -y && sudo systemctl start plexmediaserver
