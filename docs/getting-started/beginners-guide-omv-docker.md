---
layout: default
title: Beginner's Docker Guide on Open Media Vault
---

# Beginner's Docker Guide on Open Media Vault

!!! note
    In case you have any difficulties following this guide or have found some errors, please leave a note on the [forums](https://forums.lyrion.org/forum/developer-forums/developers/1668265-documentation-update-call-for-volunteers). Thanks!

If you have a Open Media Vault NAS which can run Docker containers aka. "Compose", you are in luck!

This guide uses our ["official" Docker image](https://hub.docker.com/r/lmscommunity/lyrionmusicserver/). Source and the dockerfile of the image can be found [here](https://github.com/LMS-Community/slimserver-platforms/tree/HEAD/Docker).

## Assumptions

In this guide the following assumptions apply:

- Your music is stored in a folder in a storage pool, `/pool0/media`
- Configuration will be stored in `/pool0/lyrion_config`
- You run your LMS in "host" mode meaning that the 9000 port needs to be free on you NAS

## Add an LMS application to Compose Files

1. Open "Service / Composer / Files"
2. Click "+" to create a new container
3. Set an "Name", i.e. "lms". It must be between 1 and 32 characters.
4. Paste the Docker Compose configuration, adapting it to your needs :
    ``` yaml
    services:
        lms:
            container_name: lms
            image: lmscommunity/lyrionmusicserver
            volumes:
                - /pool0/lyrion_config:/config:rw
                - /pool0/media:/music:ro
                - /pool0/media:/playlist:rw
                - /etc/localtime:/etc/localtime:ro
                - /etc/timezone:/etc/timezone:ro
            network_mode: host
            environment:
                - HTTP_PORT=9000
            restart: always
    ```
5. Click "Save" to save the container
6. Once created you should see your application in the list
7. Select the file from the list and 
8. Click the up button


## Open LMS

1. Launch your web browser and type: `http://[ip address you noted previously]:9000`. Then, press Enter. The Lyrion Music Server web interface will open.
2. Configure LMS as desired

## Updating the Docker image

It is always advisable to regularly update your software, and with Docker on Synology it is made very easy.

1. Open "Compose / Files" and select the "LMS" file
2. Click the pull button
