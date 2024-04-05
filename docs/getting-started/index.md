---
layout: default
title: Getting Started with LMS
---

# Getting Started

Lyrion Music Server is a fully open source server software to power a wide range of audio players. With the help of many plugins, Lyrion Music Server can stream not only your local music collection, but content from many music services and internet radio stations to your players.

## Download and install Logitech Media Server v{{ version }}

=== ":material-microsoft-windows: Windows"
    {{ win }}

    Then double click the downloaded package to launch the installation process in a familar installation assistant.


=== ":simple-raspberrypi: Raspberry Pi"
    **Easy install using piCorePlayer**

    If you want to have an easily installed LMS on a Raspberry Pi and don't want to go the full Linux route as outlined below, you can use [piCorePlayer](https://picoreplayer.org). See the "[Beginner's guide...](beginners-guide-lms-on-raspberry-pi.md)".

    **Installation on Raspberry Pi OS**

    If you prefer to run your LMS on a full Linux system, or in parallel to other applications, use this method.

    {{ debpi }}

    Then install using your operating system's package manager `dpkg`:

    ```
    sudo dpkg -i logitechmediaserver_x.y.z_*.deb
    ```


=== ":material-linux: Linux"
    {{ deb }}

    For Debian/Ubuntu you first need to install the necessary Perl dependencies:

    ```
    sudo apt install libcrypt-openssl-rsa-perl
    ```
    
    Then install using your operating system's package manager `dpkg`:

    ```
    sudo dpkg -i logitechmediaserver_x.y.z_*.deb
    ```

    {{ rpm }}

    Install using `rpm`:

    ```
    sudo rpm -i logitechmediaserver-x.y.z-1.noarch.rpm
    ```


=== ":material-apple: Apple macOS"
    {{ mac }}

    Then double click the downloaded package to launch the installation process in the macOS installer.

    !!! note
        Sometimes macOS would refuse to open the installer, because the authenticity of the developer can't be confirmed. If that happens to you, open the installer using a right mouse click (or control-click), then "Open". You might have to do this twice, as first time you'd stil be rejected. But the second time around you should be able to launch it anyway.


=== ":material-docker: Docker"

    See [lmscommunity/logitechmediaserver](https://hub.docker.com/r/lmscommunity/logitechmediaserver) on Docker hub.

    For Docker on Synology NAS see the [Beginner's Docker Guide on Synology](beginners-guide-synology-docker.md).


=== ":material-download: Other Downloads"

    You can find more packages for more platforms on [https://downloads.lyrion.org/](https://downloads.lyrion.org/).


## Configure

Now you should be able to browse to http://yourserver:9000 (replace "yourserver" with [localhost](http://localhost:9000) if you are at the same system as your new installation or with the hostname or IP address of that system if using a different device) and begin configuring the Lyrion Music Server.

Congrats, you're ready to Free your Music!
