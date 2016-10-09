#!/bin/sh
set -x
# WARNING: this script doesn't check for errors, so you have to enhance it in case any of the commands
# below fail.
lsmod | grep 'xmerge'
rmmod sys_xmergesort
insmod sys_xmergesort.ko
lsmod | grep 'xmerge'
