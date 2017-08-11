#!/bin/sh

echo "Stopping VIF"
/sbin/ifdown $1:ucarp
