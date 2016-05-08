#!/bin/bash

while true
do
	for i in {1..30}
	do
		free -m | awk 'NR==2{printf "%f", $3*100/$2}' >> data
		echo -n " " >> data
		top -bn2 | grep %Cpu | tail -1 | awk '{printf "%f", $2}' >> data
		echo "" >> data
	done

	echo -n "" > news
	curl -H "X-Authorization: YOUR-KEY-HERE" http://api.zeit.de/content\?limit\=3 > rawnews

	cat rawnews | jq '.matches | .[0].title' >> news
	cat rawnews | jq '.matches | .[0].subtitle' >> news
	cat rawnews | jq '.matches | .[1].title' >> news
	cat rawnews | jq '.matches | .[1].subtitle' >> news
	cat rawnews | jq '.matches | .[2].title' >> news
	cat rawnews | jq '.matches | .[2].subtitle' >> news

	uptime > uptime

	../PointerScript/bin/ptrs render.ptrs

	echo "" > data
done
