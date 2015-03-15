#!/bin/bash

configure terminal
no boot system
no boot kickstart
boot system bootflash:system_img.gbin
boot kickstart bootflash:kickstart.gbin
copy r s
exit
