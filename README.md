# rpi_setup
This repository contains setup scripts for a headless rpi. Intended to work with stretch-lite image:

c4ed01ab67dcb2e209d558334eb33dc76ae58469 shasum 256 on 2017-11-29-raspbian-strecth-lite.zip

# Approach

## Flash raspberry pi image to sd

Use for example BalenaEtcher to flash the image to the sd card
Mount the flashed card to expose the /boot and /rootfs folder

## setup scripts
To initialize wifi and ssh access, run the setup_pi.sh script:

```bash
sh setup_pi.sh --rpibootfolder /media/<USER>/boot --ssid <WIFINAME> --psk <WIFIPASS> --enablessh
```
- adds ssh connection option
- adds wifi connection
