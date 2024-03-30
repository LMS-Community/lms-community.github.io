---
layout: default
title: Getting Started with LMS
---

# Getting Started

Lyrion Music Server is a fully open source server software to power a wide range of audio players. With the help of many plugins, Lyrion Music Server can stream not only your local music collection, but content from many music services and internet radio stations to your players.

<!--
    Please edit below section carefully: anything between the special comment tags will be replaced automatically
    with the latest information from the repository files. Removing the comment tags will break the auto updating.
    Changes within them will be overwritten.

    If you'd like to apply a change, update the plugin's repository file
    (https://github.com/LMS-Community/lms-server-repository) instead.
-->

## Download and install Logitech Media Server v<!--version-->8.5.0<!--/version-->

=== ":material-microsoft-windows: Windows"
    <!--win-->[:material-microsoft-windows: Windows 32-bit (70 MB)](https://downloads.lms-community.org/LogitechMediaServer_v8.5.0/LogitechMediaServer-8.5.0.exe){ .md-button } [:material-microsoft-windows: Windows 64-bit (16 MB)](https://downloads.lms-community.org/LogitechMediaServer_v8.5.0/LogitechMediaServer-8.5.0-win64.exe){ .md-button }<!--/win-->

    Then double click the downloaded package to launch the installation process in a familar installation assistant.


=== ":simple-raspberrypi: Raspberry Pi"
    **Easy install using piCorePlayer**

    If you want to have an easily installed LMS on a Raspberry Pi and don't want to go the full Linux route as outlined below, you can use [piCorePlayer](https://picoreplayer.org). While its name suggests it's a player, it can be used to build a full LMS server with only a few clicks. See the [piCorePlayer.org documentation](https://docs.picoreplayer.org/projects/build-simple-lms-server/).

    **Installation on Raspberry Pi OS**

    If you prefer to run your LMS on a full Linux system, or in parallel to other applications, use this method.

    <!--depbi-->[:simple-raspberrypi: Raspberry Pi OS (31 MB)](https://downloads.lms-community.org/LogitechMediaServer_v8.5.0/logitechmediaserver_8.5.0_arm.deb){ .md-button }<!--/debpi-->

    Then install using your operating system's package manager `dpkg`:

    ```
    sudo dpkg -i logitechmediaserver_x.y.z_*.deb
    ```


=== ":material-linux: Linux"
    <!--deb-->[:material-debian: Debian / :material-ubuntu: Ubuntu x86_64 (24 MB)](https://downloads.lms-community.org/LogitechMediaServer_v8.5.0/logitechmediaserver_8.5.0_amd64.deb){ .md-button } [:material-debian: Debian / :material-ubuntu: Ubuntu - ARM (31 MB)](https://downloads.lms-community.org/LogitechMediaServer_v8.5.0/logitechmediaserver_8.5.0_arm.deb){ .md-button }<!--/deb-->

    Then install using your operating system's package manager `dpkg`:

    ```
    sudo dpkg -i logitechmediaserver_x.y.z_*.deb
    ```

    <!--rpm-->[:material-redhat: RedHat / :material-fedora: Fedora (86 MB)](https://downloads.lms-community.org/LogitechMediaServer_v8.5.0/logitechmediaserver-8.5.0-1.noarch.rpm){ .md-button }<!--/rpm-->

    Install using `rpm`:

    ```
    sudo rpm -i logitechmediaserver-x.y.z-1.noarch.rpm
    ```


=== ":material-apple: Apple macOS"
    <!--mac-->[:material-apple: Apple macOS (43 MB)](https://downloads.lms-community.org/LogitechMediaServer_v8.5.0/LogitechMediaServer-8.5.0.pkg){ .md-button }<!--/mac-->

    Then double click the downloaded package to launch the installation process in the macOS installer.

    !!! note
        Sometimes macOS would refuse to open the installer, because the authenticity of the developer can't be confirmed. If that happens to you, open the installer using a right mouse click (or control-click), then "Open". You might have to do this twice, as first time you'd stil be rejected. But the second time around you should be able to launch it anyway.


=== ":material-docker: Docker"

    See [lmscommunity/logitechmediaserver](https://hub.docker.com/r/lmscommunity/logitechmediaserver) on Docker hub.


=== ":material-download: Other Downloads"

    You can find more packages for more platforms on [https://downloads.lyrion.org/](https://downloads.lyrion.org/).


## Configure

Now you should be able to browse to http://yourserver:9000 (replace "yourserver" with [localhost](http://localhost:9000) if you are at the same system as your new installation or with the hostname or IP address of that system if using a different device) and begin configuring the Lyrion Music Server.

Congrats, you're ready to Free your Music!
