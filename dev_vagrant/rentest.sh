#!/bin/bash
python deletethings.py --ifile=yes
python makethings.py --ifile=yes
python showthings.py --ifile=yes
python dssrequester.py
python showthings.py --ifile=yes
