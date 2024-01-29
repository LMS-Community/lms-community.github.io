---
layout: default
title: Getting Started with LMS
---

# Getting Started

Logitech Media Server is a fully open source server software to power a wide range of audio players. With the help of many plugins, Logitech Media Server can stream not only your local music collection, but content from many music services and internet radio stations to your players.

## Download

You can find packages for most platforms on the [https://lms-community.github.io/lms-server-repository/](https://lms-community.github.io/lms-server-repository/). Download the package for your preferred platform and follow the instructions below.

## Install

There are a couple of ways to get started with a server:

- [Install on Linux](#install-on-linux)
- [Install (easily) on Raspberry Pi](#install-on-raspberry-pi)
- [Install on Windows](#install-on-windows)
- [Install on MacOS](#install-on-macos)
- [Install using Docker](#install-using-docker)

### Install on Linux

Install using your operating system's package manager:

=== "Debian  (or Raspberry Pi OS, Ubuntu etc.)"

    ```
    sudo dpkg -i logitechmediaserver_8.3.1_amd64.deb
    ```

=== "RedHat"

    ```
    sudo rpm -i logitechmediaserver-8.3.1-1.noarch.rpm
    ```

### Install on Raspberry Pi

If you want to have an easily installed LMS on a Raspberry Pi and don't want to go the full Linux route as outlined above, you can use [piCorePlayer](https://picoreplayer.org). While its name suggests it's a player, it can be used to build a full LMS server with only a few clicks. See eg. [https://docs.picoreplayer.org/projects/build-simple-lms-server/](https://docs.picoreplayer.org/projects/build-simple-lms-server/).

### Install on Windows

Double click the downloaded package to launch the installation process in a familar installation assistant.

### Install on macOS

Double click the downloaded package to launch the installation process in the macOS installer.

### Install using Docker

See [lmscommunity/logitechmediaserver](https://hub.docker.com/r/lmscommunity/logitechmediaserver) on Docker hub.

## Configure

Now you should be able to browse to http://yourserver:9000 (replace "yourserver" with localhost if you are at the same system as your new installation or with the hostname or IP address of that system if using a different device) and begin configuring the Logitech Media Server.  
Congrats, you're all finished! 
