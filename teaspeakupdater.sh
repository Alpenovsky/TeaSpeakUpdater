#!/bin/bash
######################################################
#
#               TeaSpeakUpdater by Alpen
#
######################################################
#     
# at first you must configure the path to the server and backup, which are below.
#
# Variables
backup_dir="/home/ts3/backup/"                    # backup path
teaspeak_dir="/home/ts3/teaspeak_current/"        # TeaSpeak Server path
teaspeak_latest_version=$(curl -k https://repo.teaspeak.de/server/linux/amd64/latest)		         
teaspeak_latest_file=TeaSpeak-"$teaspeak_latest_version".tar.gz					                       
teaspeak_current_version=$(grep "Version: " "$teaspeak_dir"buildVersion.txt | sed 's/.*: //')	
name=$(date '+%Y%m%d%H%M%S')							
######################################################
# Code
if [ "$teaspeak_latest_version" == "$teaspeak_current_version" ]
then
        echo "-----------------------------------------------------------------"
        echo "|         You have the latest version"
        echo "| Currently installed          ==> $teaspeak_current_version"
        echo "| Available                    ==> $teaspeak_latest_version"
        echo "-----------------------------------------------------------------"
else
        echo "-----------------------------------------------------------------"
        echo "|                 New version is available"
        echo "| Currently installed             ==> $teaspeak_current_version" 
        echo "| New available version           ==> $teaspeak_latest_version"
        echo "-----------------------------------------------------------------"
        echo -n "Do you want to install updates (y/n)?"
        read answer
        if [ "$answer" != "${answer#[Yy]}" ] ;then
                echo "update in progress..."
               "$teaspeak_dir"teastart.sh stop
                tar cvf "$backup_dir""teaspeak_backup_$name.tar" "$teaspeak_dir"
                echo "Back created."
                cd "$teaspeak_dir"
                wget https://repo.teaspeak.de/server/linux/amd64/"$teaspeak_latest_file"
                tar -xzvf "$teaspeak_latest_file"
                rm "$teaspeak_latest_file"
                "$teaspeak_dir"teastart.sh start
               echo "Updated!"
        else
            exit 1
        fi
fi



