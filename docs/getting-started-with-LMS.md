---
layout: default
title: Getting Started with LMS
---

# Getting Started

Logitech Media Server is a fully open source server software to power a wide range of audio players. With the help of many plugins, Logitech Media Server can stream not only your local music collection, but content from many music services and internet radio stations to your players.

## Install

There are a couple of ways to get started with a server:

- [Install using Docker](#install-using-docker)
- [Install using docker-compose](#install-using-docker-compose)
- [Install on Linux](#install-on-linux)
- [Install on Windows](#install-on-windows)
- [Install on MacOS](#install-on-macos)

### Install using Docker

Run:

```
docker run -it \
      -v "<somewhere>":"/config":rw \
      -v "<somewhere>":"/music":ro \
      -v "<somewhere>":"/playlist":rw \
      -v "/etc/localtime":"/etc/localtime":ro \
      -v "/etc/timezone":"/etc/timezone":ro \
      -p 9000:9000/tcp \
      -p 9090:9090/tcp \
      -p 3483:3483/tcp \
      -p 3483:3483/udp \
      lmscommunity/logitechmediaserver
```

Please note that the http port always has to be a 1:1 mapping. You can't just map it like -p 9002:9000, as Logitech Media Server is telling players on which port to connect. Therefore if you have to use a different http port for LMS (other than 9000) you'll have to set the HTTP_PORT environment variable, too:

```
docker run -it \
      -v "<somewhere>":"/config":rw \
      -v "<somewhere>":"/music":ro \
      -v "<somewhere>":"/playlist":rw \
      -v "/etc/localtime":"/etc/localtime":ro \
      -v "/etc/timezone":"/etc/timezone":ro \
      -p 9002:9002/tcp \
      -p 9090:9090/tcp \
      -p 3483:3483/tcp \
      -p 3483:3483/udp \
      -e HTTP_PORT=9002 \
      lmscommunity/logitechmediaserver
```

### Install using docker-compose

```
version: '3'
services:
  lms:
    container_name: lms
    image: lmscommunity/logitechmediaserver
    volumes:
      - /<somewhere>:/config:rw
      - /<somewhere>:/music:ro
      - /<somewhere>:/playlist:rw
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
    ports:
      - 9000:9000/tcp
      - 9090:9090/tcp
      - 3483:3483/tcp
      - 3483:3483/udp
    restart: always
```

### Install on Linux

Go to https://lms-community.github.io/lms-server-repository/ and download the correct installer for your OS. Subsequently install the package with:

=== "Debian"

    ```
    sudo dpkg -i logitechmediaserver_8.3.1_amd64.deb
    ```

=== "RedHat"

    ```
    sudo rpm -i logitechmediaserver-8.3.1-1.noarch.rpm
    ```


### Install on Windows

### Install on macOS

