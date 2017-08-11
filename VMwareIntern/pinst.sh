#!/bin/bash
docker plugin install --grant-all-permissions --alias vsphere vmware/docker-volume-vsphere:latest
docker plugin install --grant-all-permissions --alias kahuna shivanshug/vsphere-shared:kahuna-mount1
