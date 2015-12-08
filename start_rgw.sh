#!/bin/bash
if [ $# -gt 0 ]; then
FILENAME=$1
else
FILENAME="rgw.log"
fi

if [ -z "$CEPH_BUILD_ROOT" ]; then
        [ -z "$CEPH_BIN" ] && CEPH_BIN=.
else
        [ -z $CEPH_BIN ] && CEPH_BIN=$CEPH_BUILD_ROOT/bin
fi
[ -z "$CEPH_RGW_PORT" ] && CEPH_RGW_PORT=8000

#kill radosgw
ps -ef | grep lt-radosgw | awk '{print $2}' | xargs kill 

#make radosgw  # Need to test it 
    
# Start server
    echo start rgw on http://localhost:$CEPH_RGW_PORT
    RGWDEBUG=""
   # if [ "$debug" -ne 0 ]; then
        RGWDEBUG="--debug-rgw=20"
   # fi

    RGWSUDO=
    [ $CEPH_RGW_PORT -lt 1024 ] && RGWSUDO=sudo
    #$RGWSUDO $CEPH_BIN/radosgw --log-file=./out/$FILENAME ${RGWDEBUG} --debug-ms=0 -c /home/mon4/src/ceph/src/ceph.conf #-n client.radosgw.gateway
    $RGWSUDO $CEPH_BIN/radosgw --log-file=./out/$FILENAME ${RGWDEBUG} --debug-ms=0 -c /home/mon4/src/ceph/src/new.conf #-n client.radosgw.gateway