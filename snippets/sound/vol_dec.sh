#!/bin/bash

VOL_STEP=4

Sinks=$(pactl list sinks short | grep -i running | grep -o  ^[0-9])
for s in $Sinks; do
    pactl set-sink-volume $s -$VOL_STEP%
done
