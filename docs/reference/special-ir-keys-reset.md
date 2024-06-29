---
layout: default
title: Special IR Keys
---

# Special IR Keys on Reboot for Factory Reset and Last FW

Some system operations that require you to point your remote control on the Squeezebox while starting the Squeezebox.

!!! question
    To be sure you're doing it right, pull the power from the unit, press and hold the appropriate button on the remote while keeping it pointed at the unit, and give the unit power again, while all the time keeping the remote button pressed and the remote pointed at the unit.

## ip3k-based Players

These codes apply to the ip3k-based players: Squeezebox1 (G), Squeezebox2, Squeezebox3, Boom.

* `ADD` - Factory reset
* `1` - Re-program Xilinx
* `2` - Factory test mode
* `3` - Audio sine test


## SqueezeOS-based players

These tips are applicable to SqueezePlay-based players only: Controller, Touch, and Radio.

* Revert to previous FW - hold down Volume UP (with a non-Boom remote), or REW (on device, where available), and power up the device. Keep the button held down until you see the "Free Your Music" screen.

* Factory Reset - hold down Add ("+") (with a non-Boom remote) and press the fab4 rear power button. Keep button held down until you see the "Free Your Music" screen.


## Taking screenshots

### On the Radio or using remote control

Press and hold `pause` and `rew` until you get an audible signal and a popup telling you the screenshot's file name.

### On the Squeezebox Touch

You'll need to plug in a keyboard to the USB port. Then press uppercase "`S`" or `shift prntscrn`.

### Getting the screenshots off of your device

Screenshots are stored as `squeezeplay9999.bmp` in `/etc/squeezeplay/userpath`. The `9999` is an increment for each image. [Enable SSH](enable-ssh.md) and use `scp` to copy the file to your host system.

!!! warning
    On more recent clients (eg. macOS Ventura and later) `scp` might fail with a message like `sh: /usr/libexec/sftp-server: not found`. In that case use `scp -O ...` to fall back to "outdated" protocols.

If you've inserted an SD card or USB stick to the SB Touch or Controller, the screenshots will be stored in `/media/sda1` (USB) or `/media/mmcblk0p1` (SD card).

