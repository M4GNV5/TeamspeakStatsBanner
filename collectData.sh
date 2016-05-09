#!/bin/bash

echo -n "" > data/cpu.dat
echo -n "" > data/mem.dat
echo -n "" > data/cache.dat

while true
do
	free | awk 'NR==2{print $3 * 100 / $2}' >> data/cache.dat
	free | awk 'NR == 2 { a = $2 } NR == 3 { print (a - $4) * 100 / a }' >> data/mem.dat
	top -bn2 | grep %Cpu | tail -1 | awk '{printf "%f\n", $2}' >> data/cpu.dat
done
