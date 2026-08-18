---
layout: default
title: SSH Access to Radio/Touch/Controller
---

# SSH Access to SB Radio/Touch/Controller and UE Smart Radio

SSH access is only available on devices running the SqueezeOS platform. This is not the case for Squeezebox Classic/Boom/Transporter/Receiver.

!!! warning "Using SSH on *nix/macOS"
    If you are using the original firmware on the SB Radio/Touch/Controller devices you will find that you will need some additional ssh parameters to connect to the device as the algorithms used by these elderly devices haven't aged well and are deprecated. These extra parameters are not needed if you are using the [community firmware](https://forums.lyrion.org/forum/user-forums/3rd-party-software/110192-announce-community-firmware-for-squeezebox-radio-touch-controller-and-lms-8).

    ```
    ssh -c aes128-cbc -oHostKeyAlgorithms=+ssh-rsa,ssh-dss -oKexAlgorithms=+diffie-hellman-group1-sha1 root@[IP address or hostname of your device]
    ```

    Please note that some Linux distributions wouldn't even install support for the necessary algorithms any more. But these can be re-enabled. See eg. [this document for Fedora](https://fedoraproject.org/wiki/Changes/StrongCryptoSettings2#Upgrade/compatibility_impact).

## Squeezebox Radio / Touch / Controller

On the Squeezeboxen SSH can be enabled in Settings/Advanced Settings/Remote Access. Follow the instructions on screen.

## UE Smart Radio

On the UE Smart Radio enabling SSH is a little more complicated. Many of those useful developers features have been hidden in a Developers menu:

* Go to the "Settings" menu

* Press both the "Home" and the ">>" (forward) button simultaneously.

* Now there should be an additional "Developer" menu at the bottom of the "Settings" menu.

* In the Developer menu, go to "Remote Access".

* Follow the instructions on screen.

