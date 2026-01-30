---
layout: default
title: Overview
---

## Squeezebox Hardware (Discontinued)

Between 2001 and 2010 Logitech (and its predecessor Slim Devices) released a series of network music players. The lineup consisted of the Squeezebox Classic, an all-in-one Squeezebox Boom, the dual unit Squeezebox Duet, the audiophile grade Transporter, the small and optionally battery powered Squeezebox Radio, and the newest of the bunch, the Squeezebox Touch.

Additionally, the Squeezebox Controller provides control of all your players via an attractive full color display. The Controller and Receiver were sold together as the Squeezebox Duet package.

- [Hardware comparison](hardware-comparison.md)
- [Squeezebox Touch](squeezebox-touch.md)
- [Squeezebox Radio](squeezebox-radio.md)
- [Squeezebox Boom](squeezebox-boom.md)
- Squeezebox Duet
    - [Squeezebox Controller](squeezebox-controller.md)
    - [Squeezebox Receiver](squeezebox-receiver.md)
- [Transporter](transporter.md)
- [Squeezebox 3rd Generation](squeezebox-classic.md)
- [Squeezebox2](squeezebox2.md)
- [Squeezebox, SB1](squeezebox1.md)
- [SLIMP3](SLIMP3.md)

Though discontinued, Squeezebox hardware can often be found on eBay and other auction sites. Squeezebox Touch, if available, is an ideal LMS player having a touch screen, remote control, and both analog and S/PDIF (coaxial and optical) outputs supporting digital formats up to 24/96. With its optional "Enhanced Digital Output" add-in, the Touch can support USB output and 24/192 including DoP (DSD-over-PCM; see LMS "DSDPlayer" plugin).

The Radio, Touch and Controller software (operating system and application) is available as source code and have been modified by "the community".
Software from Logitech: [Operating system](https://github.com/LMS-Community/squeezeos) - [Application](https://github.com/LMS-Community/squeezeplay)
Community versions: [Operating system](https://github.com/ralph-irving/squeezeos)  - [Application](https://github.com/ralph-irving/squeezeos-squeezeplay)

## Other Hardware

Several streamers and amps available from [WiiM](https://www.wiimhome.com/) natively support LMS. Presently, this includes all models except for the Mini.

Other streaming hardware manufacturers that offer native support of LMS include [AmpliPro](https://www.amplipro.com/), [Antipodes](https://antipodes.audio/), [Eversolo](https://eversolo.com/), [Holo Audio](https://www.kitsunehifi.com/), [Innuos](https://innuos.com/), [Sonore](https://www.sonore.us/), [SOtM](https://sotm-audio.com/) and [Str@mbo](https://nohta.it/).

Hardware streamers running the Android OS -- such as several available from [FiiO](https://www.fiio.com/) -- can install one of the Squeezebox player apps listed below.

Any Android or Apple mobile device (tablet, phone, mini-PC) can be made into an LMS player with the installation of a controller and/or player app. Some of these devices allow connection to an external DAC.

Any laptop PC, desktop PC, or mini-PC running Windows, macOS, or linux can serve as both LMS player and server. Configured with internal or external storage, it can hold your music library while providing convenient file transfer access via remote desktop. These devices typically connect via USB to an external DAC or digital receiver. A "fanless" configuration -- such as several offered by [MeLE](https://store.mele.cn/collections/mini-pc) -- is ideal if this device is to be placed in the listening room.

With its "UPnP/DLNA bridge" plugin installed, LMS can play to any DLNA-compatible networked device.

After 2010 the LMS community developed DIY hardware offerings:

- [Squeezelite-ESP32](https://github.com/sle118/squeezelite-esp32)
- [SqueezeAMP](https://github.com/philippe44/SqueezeAMP) - which is an implementation of Sqeezelite-ESP32
- [Muse Radio](https://github.com/RASPIAUDIO/squeezelite-esp32) - An ESP32-S3 radio made for Lyrion, resembling the Squeezebox Radio and running Squeezelite-ESP32
- [Muse Luxe](https://raspiaudio.com/muse/) - An ESP32 speaker made for Lyrion, running Squeezelite-ESP32

## Software based players

- [Squeezelite](squeezelite.md)
- [SqueezePlay](squeezeplay.md) - [Source](https://github.com/ralph-irving/squeezeplay)
  This is based on the player and user interface in Squeezebox Radio and Squeezebox Touch
- [SoftSqueeze](softsqueeze.md)

For mobile phones and tablets:

- [iPeng](https://penguinlovesmusic.de/) (iOS - paid) - in-app purchase to also be a player
- [LyrPlay](https://apps.apple.com/gb/app/lyrplay/id6746776736) (iOS - free) - incorporates player and slightly modified Material GUI
- [xTune](https://apps.apple.com/gb/app/xtune-lyrion-remote-player/id6744552136) (iOS - paid)
- [SlimLibrary](https://apps.apple.com/us/app/slimlibrary/id1022479972) (iOS - paid) [Announcement](https://forums.lyrion.org/forum/user-forums/3rd-party-software/100649-announce-slimlibrary-new-ios-remote-control-and-player-for-logitech-media-server?view=thread)
- [SB Player](https://play.google.com/store/apps/details?id=com.angrygoat.android.sbplayer) (Android - paid)
- [SqueezePlayer](https://play.google.com/store/apps/details?id=de.bluegaspode.squeezeplayer) (Android - paid)
- [Squeezelite via Termux](https://github.com/CDrummond/lms-material-app/wiki/Squeezelite-via-Termux) (Android)
- [Squeeze Client](https://github.com/maniac103/squeezeclient) (Android) With local playback.

## Specialist operating system with player / server

- [piCorePlayer](https://www.picoreplayer.org/) (Raspberry Pi)

Using piCorePlayer as its operating system, a basic Raspberry Pi can be configured to act as a full-featured LMS player. Raspberry Pi can output via USB to an external DAC or power attached headphones. With the addition of an appropriate [HAT board](https://www.raspberrypi.com/news/introducing-raspberry-pi-hats/), the Raspberry Pi can add S/PDIF digital outputs or a small stereo amplifier.

- [Daphile](https://www.daphile.com/) (x86/x64 architecture - PC)

## Software based controllers

- [Jivelite](jivelite.md)
- [iPeng](https://penguinlovesmusic.de/) (iOS - paid) - in-app purchase to also be a player
- [LyrPlay](https://apps.apple.com/gb/app/lyrplay/id6746776736) (iOS - free) - incorporates player and slightly modified Material GUI
- [xTune](https://apps.apple.com/gb/app/xtune-lyrion-remote-player/id6744552136) (iOS - paid)
- [Material Skin](https://github.com/CDrummond/lms-material) and [Android App](https://github.com/CDrummond/lms-material-app)
- [Squeezer](https://github.com/kaaholst/android-squeezer) (Android)
- [OpenSqueeze](https://github.com/orangebikelabs/opensqueeze) (Android)
- [Squeeze Ctrl](https://play.google.com/store/apps/details?id=com.angrygoat.android.squeezectrl) (Android - paid)
- [Orange Squeeze](https://play.google.com/store/apps/details?id=com.orangebikelabs.orangesqueeze) (Android - paid)
- [SqueezePad](https://apps.apple.com/us/app/squeezepad/id380003002) (iOS - paid)
- [slimpris2](https://github.com/mavit/slimpris2) (Desktop integration on Linux, etc.)
