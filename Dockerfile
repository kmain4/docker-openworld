FROM ubuntu:22.04

ARG DEBIAN_FRONTEND='noninteractive'
RUN cd /tmp \
apt install -y --no-install-recommends \
        curl \
        lib32gcc1 \
        unzip \
        ca-certificates \
        libicu66 \
apt -y update \
apt -y upgrade \
apt -y dist-upgrade \
apt -y install screen \
apt -y install wget \
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb \
dpkg -i ./libssl1.1_1.1.0g-2ubuntu4_amd64.deb \
rm libssl1.1_1.1.0g-2ubuntu4_amd64.deb \
wget https://dot.net/v1/dotnet-install.sh \
chmod +x dotnet-install.sh \
./dotnet-install.sh -c 3.1 \
rm dotnet-install.sh \
mkdir /openworld \
wget github.com/TastyLollipop/OpenWorld/releases/latest/download/LinuxX64.zip \
unzip LinuxX64.zip –d /openworld \
chmod +x /openworld/run.sh \
chmod +x /openworld/Open\ World\ Server \
mkdir /steamcmd \
wget steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz \
tar -zxvf steamcmd_linux.tar.gz /steamcmd \
/steamcmd/steamcmd.sh +quit

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
