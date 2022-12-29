#!/bin/bash

cd /openworld

# Required mods
if [ -f '/openworld/mods.txt' ]; then
    mkdir /tmp/mods
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
    mkdir /tmp/whitelisted_mods
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

which screen
screen -S /openworld/run.sh
