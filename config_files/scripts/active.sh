#! /bin/bash

echo "Started at $(date)"

while true;
do
	for i in $(seq 1 360);do xdotool mousemove_relative -p $i 2;done
done
