#!/bin/bash

configure terminal
no boot system
no boot kickstart
boot system bootflash:initial_sys_img.gbin
boot kickstart bootflash:initial_kickstart_img.gbin
copy r s
exit
