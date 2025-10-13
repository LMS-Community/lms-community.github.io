---
layout: default
title: Squeezelite
---

# Squeezelite

Squeezelite is one of several software clients available for Lyrion Music Server. Squeezelite does not have any user interface of its own and must be controlled via Lyrion Music Server's web interface or another Lyrion Music Server client.

## Features

Squeezelite supports:

- gapless playback,
- a wide range of sample rates (44.1 kHz / 48 kHz / 88.2 kHz / 96 kHz / 176.4 kHz / 192 kHz / 352.8 kHz / 384 kHz) and
- direct streaming for Lyrion Music Server plugins that require it such as Spotify.

It is capable of utilizing Lyrion Music Server's client synchronization feature which allows grouping clients for simultaneous, synchronized music playback. Squeezelite uses ALSA for audio output on Linux and PortAudio for other platforms.

## Download

### Windows and macOS

Binaries compiled from the :octicons-mark-github-16: [source code](https://github.com/ralph-irving/squeezelite) can be found on :simple-sourceforge: [SourceForge](https://sourceforge.net/projects/lmsclients/files/squeezelite/).

Squeezelite-X combines the Squeezelite player with Lyrion server default web user interface. It can be installed from [Microsoft App Store](https://apps.microsoft.com/detail/9pbhmtnp9037).

### Android

Packages are available from the following repositories, or [from :octicons-mark-github-16: GitHub](https://github.com/CDrummond/squeezelite/releases).

[<img src="https://f-droid.org/badge/get-it-on.png" alt="Get it on F-Droid" height="80">](https://f-droid.org/packages/org.lyrion.squeezelite)
[<img src="https://gitlab.com/IzzyOnDroid/repo/-/raw/master/assets/IzzyOnDroid.png" height="80" alt="Get it at IzzyOnDroid">](https://apt.izzysoft.de/packages/org.lyrion.squeezelite)

Use an [F-Droid client](https://f-droid.org/en/packages/org.fdroid.fdroid/) to get automatic updates.

### Linux/BSD

Squeezelite is available in the following distribution repositories:

- [Arch AUR](https://aur.archlinux.org/packages/squeezelite)
- [Debian](https://packages.debian.org/stable/squeezelite)
- [Fedora](https://packages.fedoraproject.org/pkgs/squeezelite/squeezelite/)
- [FreeBSD](http://www.freebsd.org/cgi/ports.cgi?stype=all&query=squeezelite)
- [Gentoo](http://packages.gentoo.org/package/media-sound/squeezelite)
- [OpenBSD](https://openports.eu/ports/audio/squeezelite)
- [Ubuntu](http://packages.ubuntu.com/jammy/squeezelite)

Use the package manager of your distribution to install. If your distribution is not listed here, you can find binaries on [SourceForge](https://sourceforge.net/projects/lmsclients/files/squeezelite/).

## Usage

See the [squeezelite manpage](squeezelite-manpage.md) for usage details.

## Troubleshooting

In case you encounter some problems please head over to the [forums](https://forums.lyrion.org/forum/user-forums/linux-unix/94258-announce-squeezelite-a-small-headless-squeezeplay-emulator-for-linux-alsa-only) for assistance.
