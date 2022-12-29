#!/bin/bash

mkdir -p /tmp/mods
mkdir -p /tmp/whitelisted_mods

# Required mods
if [ -f '/openworld/mods.txt' ]; then
    for mod_id in `cat /openworld/mods.txt`;
    do
        /steamcmd/steamcmd.sh \
            +force_install_dir /tmp/mods \
            +login anonymous \
            +workshop_download_item 294100 $mod_id \
            +quit
        cp -paxv /tmp/mods/steamapps/workshop/content/294100/$mod_id /openworld/Enforced\ Mods/
    done
fi

# Whitelisted mods
if [ -f '/openworld/mod_whitelist.txt' ]; then
    for mod_id in `cat /openworld/mod_whitelist.txt`;
    do
        /steamcmd/steamcmd.sh \
            +force_install_dir /tmp/mods \
            +login anonymous \
            +workshop_download_item 294100 $mod_id \
            +quit
        cp -paxv /tmp/mods/steamapps/workshop/content/294100/$mod_id /openworld/Whitelisted\ Mods/
    done
fi

screen -S /openworld/run.sh
