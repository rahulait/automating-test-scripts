#!/bin/bash

i=1;

for(( ; ; ))
do
	sleep $i
	for((j=20;j<30;j++))
	do
		telnet 10.1.1.10 $j  > /dev/null 2>&1 &
	done
done
