---
layout: default
title: Beginner's Docker Guide on QNAP
---

# Beginner's Docker Guide on QNAP

!!! note
    In case you have any difficulties following this guide or have found some errors, please leave a note on the [forums](https://forums.lyrion.org/forum/developer-forums/developers/1668265-documentation-update-call-for-volunteers). Thanks!

If you have a QNAP NAS which can run Docker containers aka. "Container Station", you are in luck!

If you're still running the QNAP AppCenter version of "LogitechMediaServer", you must know that it hasn't been updated since 2012 (v7.7.2). Upgrading using this method is recommended.

This guide uses our ["official" Docker image](https://hub.docker.com/r/lmscommunity/lyrionmusicserver/) (or [from the Github Container Registry](https://github.com/LMS-Community/slimserver/pkgs/container/lyrionmusicserver)). Our examples assume you are pulling from Docker Hub. Source and the dockerfile of the image can be found [here](https://github.com/LMS-Community/slimserver-platforms/tree/HEAD/Docker).

## Assumptions

In this guide the following assumptions apply:

- Your music is stored in the `Music` folder of your `Multimedia` share (`/share/Multimedia/Music`).
- The state of the docker image is saved in the folder `/share/Container/app-data/lms-config/`. The path can be anything, but it is advisable to restrict write access for other users to this folder.
- (Optional) You have a shared folder where LMS can store playlists (i.e. : `/share/Multimedia/Playlists/LMS`).
- (If applicable) You have disabled or uninstalled the "LogitechMediaServer" application installed via the QNAP AppCenter. This will free up the LMS network ports so the container can use them.

## Add an LMS application to your Container Station

1. Open "Container Station"
2. Open the "Applications" tab
3. Click "Create"
4. Set an "Application name", i.e. "lms". It must be between 1 and 32 characters. Valid characters: letters (a-z), numbers (0-9), hyphen (-), underscore (_)
5. Paste the Docker Compose configuration, adapting it to your needs :
    ``` yaml
    version: '3.9'
    services:
        lms:
            image: lmscommunity/lyrionmusicserver
            volumes:
                - /share/Container/app-data/lms-config/:/config:rw
                - /share/Multimedia/Music/:/music:ro
                - /share/Multimedia/Playlists/LMS/:/playlist:rw
            ports:
                - "9000:9000"
                - "9090:9090"
                - "3483:3483/udp"
                - "3483:3483/tcp"
    ```
6. Click "Validate" to ensure your syntax is correct
7. Click "Create"
8. Once created you should see your new application in the list
9. By default, Container Station exposes only one port per application in a NAT configuration. As we need multi ports, we'll switch to "bridge mode" :
   1. Click you application in the list (i.e. "lms")
   2. You'll see one container running (usually something like "lms-lms-1")
   3. Click the action cog wheel "⚙️" at the right of the container, and select "Edit"
   4. Click the "Network" tab
   5. Delete de default network using the bin icon "🗑️"
   6. Click "Add" to create a new network
   7. Choose "Bridge", select the wanted interface
   8. (Optional) Set a staci IP address, by ticking "Use a static IP address" and filling Address, Mask, and Gateway
   9. Click "Connect" to add the Network
   10. Click "Apply" to update your container
   11. Take note of the IP address of your container

## Open LMS

1. Launch your web browser and type: `http://[ip address you noted previously]:9000`. Then, press Enter. The Lyrion Music Server web interface will open.
2. Configure LMS as desired

## Updating the Docker image

It is always advisable to regularly update your software, and with Container Station on QNAP it is made very easy.

1. Open "Container Station"
2. Go to "Images" and click on the cog wheel "⚙️" next to "lmscommunity/lyrionmusicserver".
3. In the drop-down menu choose "Pull". It will download the latest version.
4. Go to "Applications"
5. Click the cog wheel next to the application (i.e. "lms"), and in the drop-down menu chose "Recreate"
6. The application will be undeployed and recreated, but all configurations are kept as it is mounted in a bind volume
7. ⚠️ You'll need to set the network configuration again, see step 9 of "Add an LMS application to your Container Station" section
8. Done, and enjoy all new features and fixes!
