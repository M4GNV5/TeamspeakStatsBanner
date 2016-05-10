#!/bin/bash

while true
do
	./collectData.sh &
	sleep 60
	kill $!

	echo -n "" > data/news.dat
	curl -H "X-Authorization: YOUR-KEY-HERE" http://api.zeit.de/content\?limit\=3 > data/rawnews.dat

	cat data/rawnews.dat | jq -r '.matches | .[0].title' >> data/news.dat
	cat data/rawnews.dat | jq -r '.matches | .[0].subtitle' >> data/news.dat
	cat data/rawnews.dat | jq -r '.matches | .[1].title' >> data/news.dat
	cat data/rawnews.dat | jq -r '.matches | .[1].subtitle' >> data/news.dat
	cat data/rawnews.dat | jq -r '.matches | .[2].title' >> data/news.dat
	cat data/rawnews.dat | jq -r '.matches | .[2].subtitle' >> data/news.dat

	echo -n "time" > data/uptime.dat
	uptime >> data/uptime.dat

	../PointerScript/bin/ptrs render.ptrs
	cp banner.png ~/screenshot/files/banner.png
done
