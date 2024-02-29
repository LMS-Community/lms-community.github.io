---
layout: default
title: Getting Started with LMS
---

# Getting Started

Logitech Media Server is a fully open source server software to power a wide range of audio players. With the help of many plugins, Logitech Media Server can stream not only your local music collection, but content from many music services and internet radio stations to your players.

## Download

<!--
	Do not edit this below section marked with DOWNLOADS/ENDDONWLOADS! It is automatically generated from the repository files.
	Any change to the file would be overwritten next time changes from the plugin repository are embedded.
	If you'd like to apply a change, update the plugin's repository file
	(https://github.com/LMS-Community/lms-server-repository) instead.
-->
<!--DOWNLOADS-->

=== ":material-microsoft-windows: Windows"
    [:material-microsoft-windows: Windows 32-bit (70 MB)](https://downloads.slimdevices.com/LogitechMediaServer_v8.4.0/LogitechMediaServer-8.4.0.exe){ .md-button }
    [:material-microsoft-windows: Windows 64-bit (16 MB)](https://downloads.slimdevices.com/LogitechMediaServer_v8.4.0/LogitechMediaServer-8.4.0-win64.exe){ .md-button }

=== ":material-debian: Debian / :material-ubuntu: Ubuntu"
    [:material-debian: Debian / :material-ubuntu: Ubuntu x86_64 (25 MB)](https://downloads.slimdevices.com/LogitechMediaServer_v8.4.0/logitechmediaserver_8.4.0_amd64.deb){ .md-button }
    [:material-debian: Debian / :material-ubuntu: Ubuntu - ARM (32 MB)](https://downloads.slimdevices.com/LogitechMediaServer_v8.4.0/logitechmediaserver_8.4.0_arm.deb){ .md-button }

=== ":simple-raspberrypi: Raspberry Pi OS:"
    [:simple-raspberrypi: Raspberry Pi OS (32 MB)](https://downloads.slimdevices.com/LogitechMediaServer_v8.4.0/logitechmediaserver_8.4.0_arm.deb){ .md-button }

=== ":material-redhat: RedHat / :material-fedora: Fedora"
    [:material-redhat: RedHat / :material-fedora: Fedora (87 MB)](https://downloads.slimdevices.com/LogitechMediaServer_v8.4.0/logitechmediaserver-8.4.0-1.noarch.rpm){ .md-button }

=== ":material-apple: Apple macOS"
    [:material-apple: Apple macOS (44 MB)](https://downloads.slimdevices.com/LogitechMediaServer_v8.4.0/LogitechMediaServer-8.4.0.pkg){ .md-button }

<!--ENDDOWNLOADS-->

You can find more packages for more platforms on [https://lms-community.github.io/lms-server-repository/](https://lms-community.github.io/lms-server-repository/). For the Docker image [see below](#install-using-docker).

Download the package for your preferred platform and follow the instructions in the next section.

## Install

There are a couple of ways to get started with a server:

- [Install on Linux](#install-on-linux)
- [Install (easily) on Raspberry Pi](#install-on-raspberry-pi)
- [Install on Windows](#install-on-windows)
- [Install on MacOS](#install-on-macos)
- [Install using Docker](#install-using-docker)

### Install on Linux

Install using your operating system's package manager:

=== ":material-debian: Debian / :simple-raspberrypi: Raspberry Pi OS / :material-ubuntu: Ubuntu"

    ```
    sudo dpkg -i logitechmediaserver_8.4.0_amd64.deb
    ```

=== ":material-redhat: RedHat / :material-fedora: Fedora"

    ```
    sudo rpm -i logitechmediaserver-8.4.0-1.noarch.rpm
    ```

### Install on Raspberry Pi

If you want to have an easily installed LMS on a Raspberry Pi and don't want to go the full Linux route as outlined above, you can use [piCorePlayer](https://picoreplayer.org). While its name suggests it's a player, it can be used to build a full LMS server with only a few clicks. See eg. [https://docs.picoreplayer.org/projects/build-simple-lms-server/](https://docs.picoreplayer.org/projects/build-simple-lms-server/).

### Install on Windows

Double click the downloaded package to launch the installation process in a familar installation assistant.

### Install on macOS

Double click the downloaded package to launch the installation process in the macOS installer.

!!! note
    Sometimes macOS would refuse to open the installer, because the authenticity of the developer can't be confirmed. If that happens to you, open the installer using a right mouse click (or control-click), then "Open". You might have to do this twice, as first time you'd stil be rejected. But the second time around you should be able to launch it anyway.

### Install using Docker

See [lmscommunity/logitechmediaserver](https://hub.docker.com/r/lmscommunity/logitechmediaserver) on Docker hub.

## Configure

Now you should be able to browse to http://yourserver:9000 (replace "yourserver" with [localhost](http://localhost:9000) if you are at the same system as your new installation or with the hostname or IP address of that system if using a different device) and begin configuring the Logitech Media Server.
Congrats, you're all finished!
