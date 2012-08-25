#!/bin/bash

configure terminal
no boot system
no boot kickstart
boot system bootflash:test_image_prashant.gbin
boot kickstart bootflash:test2.gbin
copy r s
exit
