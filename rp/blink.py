#!/usr/bin/python

import sys
import time

sys.path.append(".")

import redpitaya_scpi

rp_s = scpi(sys.argv[1])

if (len(sys.argv) > 2):
    led = int(sys.argv[2])
else:
    led = 0

print ("Blinking LED["+str(led)+"]")

period = 1 # seconds

while 1:
    time.sleep(period/2.0)
    rp_s.tx_txt('DIG:PIN LED' + str(led) + ',' + str(1))
    time.sleep(period/2.0)
    rp_s.tx_txt('DIG:PIN LED' + str(led) + ',' + str(0))