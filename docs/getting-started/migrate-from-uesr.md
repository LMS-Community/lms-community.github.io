---
layout: default
title: Migrate from UE Smart Radio
---

# Migrate from UE Smart Radio (UESR)

## Reasons to transition to Squeezebox

* You want to be independent of a cloud service (UESmartRadio.com).

* You want to use and sync your device alongside other Squeezebox devices such as Touch, Boom, Classic or other Squeezebox Radios.

* You want to use the [Logitech Media Server (aka. LMS)](../reference/logitech-media-server.md) to play music from attached NAS storage devices or using 3rd party developer plug-ins.
    
* You want to stream music files stored on your PC or Mac to your Radio but do not have a permanent Internet connection available.


## How to proceed

!!! note
    Please note that Smart Radios transitioned to Squeezebox Radios will require [Logitech Media Server](../getting-started/index.md)</a> version 8.3.1 or above. Install it before you continue the migration.

To initiate the transition, navigate to "Advanced Settings" on your Smart Radio and scroll down to select "Switch to Squeezebox", then "Free your music".

![](assets/uesr-migration/migrate-uesr-sb.png) 
![](assets/uesr-migration/migrate-uesr-sb-free.png)

After a restart the Radio should start downloading the new firmware, followed by another reboot and a factory reset:

![](assets/uesr-migration/waiting-progress-download.png) 
![](assets/uesr-migration/factory-restore.png) 

Choose your preferred language. Then follow the network setup according to your environment.

![](assets/uesr-migration/choose-network.png) 

When asked to create an account on MySqueezebox.com, skip that step and continue without account. You should then get the main menu where you can select "My Music" to connect to your LMS.
