#!/bin/bash
apt-get -y -qq update
apt-get -y -qq upgrade
apt-get -y -qq dist-upgrade
apt-get -y -qq install curl
apt-get -y -qq install unzip
apt-get -y -qq install ca-certificates
apt-get -y -qq install screen
apt-get -y -qq install wget
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb
dpkg -i ./libssl1.1_1.1.0g-2ubuntu4_amd64.deb
rm libssl1.1_1.1.0g-2ubuntu4_amd64.deb
wget https://dot.net/v1/dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh -c 3.1
rm dotnet-install.sh
mkdir /openworld
cd /openworld
wget github.com/TastyLollipop/OpenWorld/releases/latest/download/LinuxX64.zip
unzip LinuxX64.zip
chmod +x /openworld/run.sh
chmod +x /openworld/Open\ World\ Server
mkdir /steamcmd
cd /tmp
wget steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -zxvf steamcmd_linux.tar.gz /steamcmd
/steamcmd/steamcmd.sh +quit

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

screen -S /openworld/run.sh
