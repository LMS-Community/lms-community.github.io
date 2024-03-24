---
layout: default
title: Beginner's Docker Guide on Synology
---

# Beginner's Docker Guide on Synology

!!! note
    In case you have any difficulties following this guide or have found some errors, please leave a note on the [forums](https://forums.slimdevices.com/forum/developer-forums/developers/1668265-documentation-update-call-for-volunteers). Thanks!

If you have a Synology NAS which can run Docker containers, you are in luck! Look [here](https://www.synology.com/en-global/dsm/packages/ContainerManager) to check if your Synology NAS is able to run Docker containers.

This guide uses our ["official" Docker image](https://hub.docker.com/r/lmscommunity/logitechmediaserver/). Source and the dockerfile of the image can be found [here](https://github.com/Logitech/slimserver-platforms/tree/HEAD/Docker).

## Assumptions

In this guide the following assumptions apply:

- If you already have the Synology LMS packaged installed, uninstall it first. This will free up the LMS network ports so the container can use them.
- This docker container runs as your user. Note, you can also create a specific user for running the container, in that case replace the UID/PUID with the correct identifier.
- Your music is stored in the shared folder `music`.
- (Optional) you have a shared folder called playlist where LMS can store playlists.
- Your user has read-only or read-write access to the music folder. If you also have a playlist folder, your user needs read-write access to this folder.
- The state of the docker image is saved in the folder `/docker/logitechmediaserver`. The path can be anything, but it is advisable to restrict write access for other users to this folder.

## Find out the UID and GID of your user

The [UID](https://en.wikipedia.org/wiki/User_identifier) and [GID](https://en.wikipedia.org/wiki/Group_identifier) values for the default user on Synlogy NAS are usually 1026 and 100. There is a very simple way to check the values as follows\:

1. Create a new Scheduled task as an User-defined script
2. Name the script whatever you see fit
3. Set it to be not repeating
4. Set it to send run details to your email
5. Write the script\:

    ```
    id
    ```

6. Run it and soon enough, you will receive an email containing the UID and GID values.

## Download the Docker image

1. In the Synology GUI start up the app Container Manager.
2. Go to Register.
3. Search for `logitechmediaserver` and download the `lmscommunity/logitechmediaserver` image.
4. Select the `latest` tag. The image will now download.

## Configure the Docker container

Now the correct image has been downloaded, it is time to start and configure the container.

1. In the "Container Manager" app, go to "Image", select the `lmscommunity/logitechmediaserver` image and press "Run".
2. Choose a suitable name, e.g. `logitechmediaserver`, and press "Next".
3. In the "Port Settings" section, add the following ports :

    | Local port | Container port | Protocol |
    | --- | --- | --- |
    | 9000 | 9000 | tcp |
    | 9090 | 9090 | tcp |
    | 3483 | 3483 | tcp |
    | 3483 | 3483 | udp |

4. In the "Volume Settings" section, add the following volumes:

    | Local folder | Container folder | Mode |
    | --- | --- | --- |
    | /docker/logitechmediaserver | /config | rw |
    | /music | /music | ro |
    | /playlist | /playlist | rw |

5. Add the UID and GID from the step above, and the [appropriate TZ (timezone)](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) to the "Enviroment" section:

    | Variable | Value |
    | --- | --- |
    | PUID | for example `1026` (see the [UID/GID step above](#find-out-the-uid-and-gid-of-your-user)) |
    | PGID | for example `100` (see the [UID/GID step above](#find-out-the-uid-and-gid-of-your-user)) |
    | TZ | for example `Europe/Zurich` |
    | EXTRA_ARGS | `"--advertiseaddr=192.168.0.100"` (your Synology's IP address) |

    !!! note
        Please note that the `EXTRA_ARGS` entry is only required if you use the default `bridge` networking mode. If you decide to expose all of the container's services to the local network using the `host` mode, then defining the `advertiseaddr` is not required.

6. Select "Next" and "Done". The container will automatically start.

## Configure LMS

1. Launch your web browser (eg. Edge, Firefox) and type: `http://[hostname or ip address of your nas]:9000`. Then, press Enter. The Logitech Media Server web interface will open.
2. Skip the MySqueezebox.com account credentials step (because the MySB.com service is shut down).
3. Browse to your music folder location (`/music`), highlight the directory, and click "Next".
4. (Optional) browse to your playlists folder location (`/playlist`), highlight the directory, and click "Next".
5. You'll see the Summary page for your Logitech Media Server install. Click "Finish" to complete the installation. Congrats, you're done!

## Updating the Docker image

It is always advisable to regularly update your software, and with Docker on Synology it is made very easy.

1. In the "Container Manager" app, go to "Image", and check if the `lmscommunity/logitechmediaserver` image has any updates available.
2. If there are updates, click "Update available" and press "Update" twice.
3. Now the image is updated, refreshed and automatically restarted. If you followed the guide above all important data is saved and stored in Docker volumes, so this update will not overwrite anything in your configuration.
4. Done, and enjoy all new features and fixes!

!!! note
    If you use a different tag as `latest` then Synology does not automatically check for updates. To update go to "Container" and stop the LMS container. Then go to "Registry", search the `lmscommunity/logitechmediaserver` image and select the tag you are using. Once the updated image had been downloaded, go to "Container", select the LMS container and press "Reset". You get a warning that all data in the container will be lost, but that does not matter since all your configuration is in Docker volumes so you can press "Yes"! When that's done you can start the container again.
