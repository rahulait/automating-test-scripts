#!/bin/bash

configure terminal
no boot system
no boot kickstart
boot system bootflash:nexus-1000v.VSG1.2.gbin
boot kickstart bootflash:nexus-1000v-kickstart.VSG1.2.gbin
copy r s
exit
