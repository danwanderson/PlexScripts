#!/usr/bin/env bash

sudo dnf install "$1" -y && sudo systemctl start plexmediaserver
