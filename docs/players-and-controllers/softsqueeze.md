---
layout: default
title: SoftSqueeze
---

# SoftSqueeze

<figure markdown="span">
  ![](assets/softsqueeze-transporter.png){ width="400" }
  <figcaption>SoftSqueeze with the Transporter skin</figcaption>
</figure>

SoftSqueeze is a community supported software music player that allows you to play music streamed from Lyrion Music Server. Since 2009 SoftSqueeze is no longer included in the LMS distribution and is replaced by [SqueezePlay](squeezeplay.md). Although it has since been replaced, SoftSqueeze can still be useful in the present day to simulate the screens of for instance the [Squeezebox Classic](squeezebox-classic.md) and [Transporter](transporter.md). The SoftSqueeze emulator has the look and feel of the [Transporter](transporter.md), [Squeezebox Classic](squeezebox-classic.md), [Squeezebox Boom](squeezebox-boom.md), [Squeezebox 2](squeezebox2.md) and [Squeezebox 1](squeezebox1.md) hardware, and their remote controls.

SoftSqueeze is written in Java by Richard Titmuss and is currently maintained by Ralph Irving.

## Download

SoftSqueeze can be downloaded from [SourceForge](https://softsqueeze.sourceforge.net/). The source code can be found on [Github](https://github.com/ralph-irving/softsqueeze3).

## Features

- Audio Playback
	- Native playback of Flac, MP3, WAV and AIFF audio.
	- Support for Ogg Vorbis, WMA and AAC by transcoding in SqueezeCenter.
	- Gapless playback for most audio formats.
	- Synchronization with Squeezebox2, Squeezebox and Slimp3 (requires Java 1.8)
	- Pause, volume control and mute buttons.
	- Supports Windows Direct Sound on a Windows PC.
	- Supports the pulseaudio mixer on a Linux PC.
- Squeezebox2 Graphics Support
	- Emulation of the new 320x32 graphic display.
	- Full support for all Squeezebox fonts.
	- Spectrum Analyzer, VU meters.
	- Fixes display issues on MacOS.
- Skins
	- Slim Devices skin with horizontal or vertical remotes.
	- Excession and Excession Large skins.
	- LCD skin, designed for use on laptop computers.
	- Quick link to slim server web interface
	- Window snapping
	- Also supports headless operation
- Music search and playlist editor
- Emulation of Slim IR Remote control
	- Button auto repeat (for example press and hold pause stop's the player)
	- Keyboard shortcuts for common remote control functions (uses the same keys as winamp and xmms).
- [Slim Protocol](../reference/slimproto-protocol.md)
	- Supports Slim Server version 7.7 upwards.
	- Support for password encrypted servers.
	- Auto reconnection to Slim Server when connection is lost.
	- Built-in ssh tunneling support for remote connections.
	- Slim server discovery.
- Installers
	- Java web start and applet support
	- install4j Java installer builder
