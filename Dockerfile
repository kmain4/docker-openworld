FROM ubuntu:20.04

ARG OPENWORLD_RELEASE_VERSION='1.2.5'
ARG DEBIAN_FRONTEND='noninteractive'
RUN apt update -yq && \
    apt install -y --no-install-recommends \
        curl \
        lib32gcc1 \
        unzip \
        ca-certificates \
        libicu66 \
        screen

RUN mkdir -p /steamcmd && \
    cd /steamcmd && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
RUN /steamcmd/steamcmd.sh +quit

RUN curl -L https://dot.net/v1/dotnet-install.sh --output /tmp/dotnet.sh && \
    bash /tmp/dotnet.sh -c 6.0 && \
    rm /tmp/dotnet.sh

RUN curl -L https://github.com/TastyLollipop/OpenWorld/releases/download/${OPENWORLD_RELEASE_VERSION}/LinuxX64.zip --silent --output /openworld.zip
RUN mkdir -p /openworld

COPY mods.base.txt /tmp/mods.base.txt

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]