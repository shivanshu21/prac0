#!/bin/bash
#Temp file to build kahuna plugins

#docker plugin install --grant-all-permissions --alias vsphere shivanshug/docker-volume-vsphere:kahuna-Talker
#docker plugin install --grant-all-permissions --alias vsphere shivanshug/docker-volume-vsphere:kahuna-Listener

EXTRA_TAG=-0.4 VERSION_TAG=kahuna make build-shared
