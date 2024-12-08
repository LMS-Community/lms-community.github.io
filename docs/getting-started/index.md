---
layout: default
title: Getting Started with LMS
---

# Getting Started

Lyrion Music Server is a fully open source server software to power a wide range of audio players. With the help of many plugins, Lyrion Music Server can stream not only your local music collection, but content from many music services and internet radio stations to your players.

## Download and install Lyrion Music Server v{{ latest.version }}

=== ":material-microsoft-windows: Windows"
    !!! note
        The 64-bit version is the way to go moving forward. An existing 32-bit version must be uninstalled before installing the 64-bit version (The LMS 9 installer will do this automatically). Please note that there's no Control Panel app any more, nor a tray icon. Tools like eg. [ServiceTray](https://www.coretechnologies.com/products/ServiceTray/) allow you to easily start/stop the LMS service.

    {{ win64 }}

    Then double click the downloaded package to launch the installation process in a familiar installation assistant.


=== ":simple-raspberrypi: Raspberry Pi"
    **Easy install using piCorePlayer**

    If you want to have an easily installed LMS on a Raspberry Pi and don't want to go the full Linux route as outlined below, you can use [piCorePlayer](https://picoreplayer.org). See the "[Beginner's guide...](beginners-guide-lms-on-raspberry-pi.md)".

    **Installation on Raspberry Pi OS**

    If you prefer to run your LMS on a full Linux system, or in parallel to other applications, use this method.

    {{ debpi }}

    Download the above package, then install it with its depencencies using the operating system's package manager `apt`:

    ```
    sudo apt install /path/to/lyrionmusicserver_{{ latest.version }}_*.deb
    ```


=== ":material-linux: Linux"
    {{ deb }}

    Download the package, then install it with its depencencies using the operating system's package manager `apt`:

    ```
    sudo apt install /path/to/lyrionmusicserver_{{ latest.version }}_*.deb
    ```

    {{ rpm }}

    Install on Fedora/Red Hat Enterprise Linux/CentOS, etc.:

    ```
    sudo dnf install {{ latest.rpm.url }}
    ```

    Install on openSUSE and derivatives:

    ```
    sudo zypper install {{ latest.rpm.url }}
    ```


=== ":material-apple: Apple macOS"
    {{ macos }}

    Then double click the downloaded image. Drag the application to the Applications folder. Launch Lyrion Music Server from the Applications folder, then check the menu bar item for Start/Stop options.

    !!! note
        If you want to use external disks, you'll have to grant the `perl` executable "full disk access" permissions. You'd usually find it in `/Applications/Lyrion Music Server.prefPane/Contents/MacOS/perl`. See "Security & Privacy Preferences > Privacy > Full Disk Access" in the Mac's preference pane.


=== ":material-docker: Docker"

    See [lmscommunity/lyrionmusicserver](https://hub.docker.com/r/lmscommunity/lyrionmusicserver) on Docker hub.

    For Docker on Synology NAS see the [Beginner's Docker Guide on Synology](beginners-guide-synology-docker.md).


=== ":material-download: Other Downloads"

    You can find more packages for more platforms on [https://lyrion.org/downloads](../downloads/index.md).


## Configure

Now you should be able to browse to http://yourserver:9000 (replace "yourserver" with [localhost](http://localhost:9000) if you are at the same system as your new installation or with the hostname or IP address of that system if using a different device) and begin configuring the Lyrion Music Server.

Congrats, you're ready to Free your Music!
