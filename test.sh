#!/bin/bash

sum1=0
sum2=0
sum3=0

echo "Testing process started for Unpatched image."
sshpass -p "pass1" ssh admin@10.10.10.1 "copy tftp://10.10.10.2/unpatched.sh bootflash:" >> /tmp/pfm_logs 2>&1
sshpass -p "pass1" ssh admin@10.10.10.1 "run-script bootflash:unpatched.sh" >> /tmp/pfm_logs 2>&1
sshpass -p "pass1" ssh admin@10.10.10.1 "delete bootflash:unpatched.sh" >> /tmp/pfm_logs 2>&1
sshpass -p "pass1" ssh admin@10.10.10.1 "reload" >> /tmp/pfm_logs 2>&1 &
sleep 150
echo "Testing by sending traffic from traffic VMs."
/root/get_test_stats.sh /root/unpatched.txt
echo "Testing by sending traffic from traffic VMs over."

echo "Testing process started for patched (AND/OR) image."
sshpass -p "pass1" ssh admin@10.10.10.1 "copy tftp://10.10.10.2/patched.sh bootflash:" >> /tmp/pfm_logs 2>&1
sshpass -p "pass1" ssh admin@10.10.10.1 "run-script bootflash:patched.sh" >> /tmp/pfm_logs 2>&1
sshpass -p "pass1" ssh admin@10.10.10.1 "delete bootflash:patched.sh" >> /tmp/pfm_logs 2>&1
sshpass -p "pass1" ssh admin@10.10.10.1 "reload" >> /tmp/pfm_logs 2>&1 &
sleep 150
echo "Testing by sending traffic from traffic VMs."
/root/get_test_stats.sh /root/patched.txt
echo "Testing by sending traffic from traffic VMs over."

#================================================================
# For only OR patched VSG
echo "Testing process started for patched (OR) image."
sshpass -p "pass1" ssh admin@10.10.10.1 "copy tftp://10.10.10.2/or_patched.sh bootflash:" >> /tmp/pfm_logs 2>&1
sshpass -p "pass1" ssh admin@10.10.10.1 "run-script bootflash:or_patched.sh" >> /tmp/pfm_logs 2>&1
sshpass -p "pass1" ssh admin@10.10.10.1 "delete bootflash:or_patched.sh" >> /tmp/pfm_logs 2>&1
sshpass -p "pass1" ssh admin@10.10.10.1 "reload" >> /tmp/pfm_logs 2>&1 &
sleep 150
echo "Testing by sending traffic from traffic VMs."
/root/get_test_stats.sh /root/or_patched.txt
echo "Testing by sending traffic from traffic VMs over."

#===============================================================

x1=$(egrep -o "Requests per second:    [0-9]+" < patched.txt | cut -d' ' -f7 )
x2=$(egrep -o "Requests per second:    [0-9]+" < unpatched.txt | cut -d' ' -f7 )
x3=$(egrep -o "Requests per second:    [0-9]+" < or_patched.txt | cut -d' ' -f7 )
j=0; for i in $x1; do sum1=$[sum1+i]; j=$[j+1]; done
for i in $x2; do sum2=$[sum2+i]; done
for i in $x3; do sum3=$[sum3+i]; done
sum1=$[sum1/j]
sum2=$[sum2/j]
sum3=$[sum3/j]

echo "Number of requests per second for patched image(AND/OR both) = $sum1"
echo "Number of requests per second for unpatched image = $sum2"
echo "Number of requests per second for patched image(OR Only) = $sum3"
