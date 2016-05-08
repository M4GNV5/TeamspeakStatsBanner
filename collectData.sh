#!/bin/bash

while true
do
	free -m | awk 'NR==2{printf "%f", $3*100/$2}' >> data
	echo -n " " >> data
	top -bn2 | grep %Cpu | tail -1 | awk '{printf "%f", $2}' >> data
	echo "" >> data
done
