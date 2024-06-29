---
layout: default
title: Custom Firmware for Radio/Touch/Controller
---

# How to install Custom Firmware for SB Radio/Touch/Controller

It is possible to tell Lyrion Music Server to push a specific build of Squeezebox Radio/Touch/Controller firmware out to devices that connect to it by using specially named `custom.<device>.*` files.

!!! danger
    Load custom firmware at your own risk. While an unlikely scenario, it is possible to "brick" your device by loading a corrupted or buggy-because-not-formally-qualified firmware. If you get in a situation where the custom firmware you've attempted to install won't load, you may be able to recover it by booting to the previous firmware. This is done by continually [holding down the rew key during boot](special-ir-keys-reset.md).

## Loading Custom Squeezebox Firmware

* Begin by obtaining a firmware for the device that you want to load. These are typically named in the form `baby_X.Y.Z_rXXXX`.bin, where "baby" is the device type (use "baby" for Radio, "fab4" for the SB Touch, or "jive" for the SB Controller), X.Y.Z is the software branch, and rXXXX is the subversion revision. For example, `baby_7.6.0_r9155.bin`.

* Rename this file `custom.baby.bin`.

* This bin file is actually a zip file in disguise. Inside the zip are a few files

```
-rw-r--r--  1 user user 2.8M 2010-10-07 01:48 zImage
-rw-r--r--  1 user user  13M 2010-10-07 01:48 root.cramfs
-rw-r--r--  1 user user   62 2010-10-07 01:48 jive.version
-rw-r--r--  1 user user   72 2010-10-07 01:48 board.version
-rw-r--r--  1 user user   87 2010-10-07 01:48 upgrade.md5
```

* The important file for this exercise is jive.version. This file needs to be extracted from the archive and renamed `custom.baby.version`.

!!! note
    While the file in the archive is called jive.version, it is important to name the extracted file `custom.<device>.version`, eg. `custom.baby.version`

* Depending on OS, there are a variety of ways to extract this file from the zip archive.

    * In windows, a utility like WinZip can be used. Modern versions of Windows can do Zip archive inspection natively, though you will have to convince windows explorer that your .bin file is actually a .zip file.
    * Mac and Linux are very simple from the command line (see also scripting instructions below). This command extracts the file jive.version from the archive custom.baby.bin and prints it to STDOUT. This output is redirected to the file custom.baby.version

```
zip -p custom.baby.bin jive.version > custom.baby.version
```

## Install firmware using SD card or USB stick (SB Controller/Touch)

If you're the owner of a Squeezebox Touch or Controller, you're lucky! Those devices feature an SD card slot or USB port (Touch only).

You can install the firmware by copying the files to the storage medium of your choice (and availability). Insert the medium to your device, restart it. You should now be able to install the firmware from the device's Settings/Advanced/Software Update menu.

## Have firmware served by your Lyrion Music Server

The two files `custom.baby.bin` and `custom.baby.version` need to be placed in the Cache/Updates folder of the LMS installation. See Settings/Information in LMS to see where that folder is on your system.

Once you restart your LMS and your device connects to it, it should offer you the new firmware for installation.
