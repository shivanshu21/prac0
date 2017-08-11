#!/bin/bash
docker plugin disable -f vsphere:latest
docker plugin rm -f vsphere:latest

docker plugin disable -f kahuna:latest
docker plugin rm -f kahuna:latest
