#!/bin/bash

if [ "$#" -eq 0 ]; then
	echo "Output file not given. Please provide it as argument."
	exit 0
fi

rm $1

for((i=1;i<=10;i++))
do
echo "=============================================================================" >> $1 2>&1
echo "" >> $1 2>&1
echo "Request $i :-" >> $1 2>&1
echo "" >> $1 2>&1
ab -n 3600 http://10.1.0.209:80/ >> $1 2>&1
echo "" >> $1 2>&1
done
echo "=============================================================================" >> $1 2>&1
echo "done"
