#!/bin/bash

unzip -ao /openworld.zip -d /openworld

mkdir -p /openworld/Mods
mkdir -p /tmp/mods

for mod_id in `cat /tmp/mods.base.txt`;
do
    /steamcmd/steamcmd.sh \
        +force_install_dir /tmp/mods \
        +login anonymous \
        +workshop_download_item 294100 $mod_id \
        +quit
    cp -paxv /tmp/mods/steamapps/workshop/content/294100/$mod_id /openworld/Mods/$mod_id
done

if [ -f '/openworld/mods.txt' ]; then
    for mod_id in `cat /openworld/mods.txt`;
    do
        /steamcmd/steamcmd.sh \
            +force_install_dir /tmp/mods \
            +login anonymous \
            +workshop_download_item 294100 $mod_id \
            +quit
        cp -paxv /tmp/mods/steamapps/workshop/content/294100/$mod_id /openworld/Mods/$mod_id
    done
fi

openworld /root/.dotnet/dotnet /openworld/Open\ World\ Server.dll
