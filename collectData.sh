#!/bin/bash

echo -n "" > data/cpu.dat
echo -n "" > data/mem.dat

while true
do
	free -m | awk 'NR==2{printf "%f\n", $3*100/$2}' >> data/mem.dat
	top -bn2 | grep %Cpu | tail -1 | awk '{printf "%f\n", $2}' >> data/cpu.dat
done
