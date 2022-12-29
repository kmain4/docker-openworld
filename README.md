# docker-openworld

This project creates a docker container to run [Open World](https://github.com/TastyLollipop/OpenWorld), a Rimworld multiplayer mod as a server.

## Usage

Clone this repository for quick usage with `docker-compose up` command.

### Mods

To configure automatic mod list management from steam workshop, create a mods.txt and/or mod_whitelist.txt in the mounted openworld directory and poulate your mod ID's line by line. An example of this file will be provided in this document.

```txt
2773943594
2707120862
```

### Start

`docker-compose.yml` is the easiest start.
Clone this repo, create your modlist, and run `docker-compose up -d`.

Docker will publish TCP 25555 so NAT forward the port as you see fit.
