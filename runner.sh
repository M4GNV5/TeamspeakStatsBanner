#!/bin/bash

while true
do
	./collectData.sh &
	sleep 60
	kill $!

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
