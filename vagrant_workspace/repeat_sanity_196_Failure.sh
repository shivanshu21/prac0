#!/bin/bash
for i in `seq 1 100`;
do
    echo "Iteration $i"
    echo "====================  Iteration $i  ====================" >> log
    python sanity_tests.py --ifile=yes >> log 2>&1
    perl pcurl.pl
    sleep 10
done

grep ': Failed' log
