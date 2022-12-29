FROM ubuntu:22.04

ARG DEBIAN_FRONTEND='noninteractive'
RUN cd /tmp \
apt-get -y update \
apt-get -y upgrade \
apt-get -y dist-upgrade \
apt-get -y install screen \
apt-get -y install wget \
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb \
dpkg -i ./libssl1.1_1.1.0g-2ubuntu4_amd64.deb \
rm libssl1.1_1.1.0g-2ubuntu4_amd64.deb \
wget https://dot.net/v1/dotnet-install.sh \
chmod +x dotnet-install.sh \
./dotnet-install.sh -c 3.1 \
rm dotnet-install.sh \
mkdir /openworld \
wget github.com/TastyLollipop/OpenWorld/releases/latest/download/LinuxX64.zip \
unzip LinuxX64.zip –d /openworld
chmod +x /openworld/run.sh \
chmod +x /openworld/Open\ World\ Server \
rm -rf OpenWorld-Ubuntu-Install-Script

RUN mkdir -p /steamcmd && \
    cd /steamcmd && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
RUN /steamcmd/steamcmd.sh +quit

RUN curl -L https://dot.net/v1/dotnet-install.sh --output /tmp/dotnet.sh && \
    bash /tmp/dotnet.sh -c 6.0 && \
    rm /tmp/dotnet.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
