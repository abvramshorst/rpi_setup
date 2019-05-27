#!/usr/bin/env bash

### functions

usage ()
{
    echo 'usage: setup_pi.sh --rpibootfolder <FOLDER> --ssid <SSID> --psk <PSK> --enablessh'
}

set_ssh_file ()
{
    filedestination=$1'/ssh'
    if [ ! -e $filedestination ]
    then
        echo 'setting ssh activation file in ' $1
        touch $filedestination
    else
        echo 'ssh file already set in ' $1
    fi
}

set_wifi ()
{
    filedestination=$1'/wpa_supplicant.conf'
    if [ ! -e $filedestination ]
    then
        echo 'setting wifi config file in ' $1
        touch $filedestination
        echo 'ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev\nnetwork={\nssid="'$2'"\npsk="'$3'"\nkey_mgmt=WPA-PSK\n}' > $filedestination
    else
        echo 'wifi config file already set in ' $1
    fi
}

### parse arguments

enable_ssh=0

while [ "$1" != "" ]; do
    case $1 in
        --rpibootfolder )       shift
                                bootfolder=$1
                                ;;
        --enablessh )           enable_ssh=1
                                ;;
        --ssid )                shift
                                wifi_name=$1
                                ;;
        --psk )                 shift
                                wifi_pass=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

### main


if [ ! -z $bootfolder ]
then
    if [ -d $bootfolder ]
    then
        echo 'target folder:' $bootfolder
        echo 'bootfolder found'

        if [ $enable_ssh -eq 1 ]
        then
            set_ssh_file $bootfolder
        fi

        if [ ! -z $wifi_name ] && [ ! -z $wifi_pass ]
        then
            set_wifi $bootfolder $wifi_name $wifi_pass
        fi

    else
        echo 'bootfolder not found'
    fi
else
    echo 'bootfolder must be provided'
fi
