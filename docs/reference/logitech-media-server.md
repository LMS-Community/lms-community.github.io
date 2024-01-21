---
layout: default
title: Logitech Media Server
---

# Logitech Media Server

Logitech Media Server is the server software that powers audio players from Logitech (formerly known as Slim Devices), including [Squeezebox 3rd Generation](../players-and-controllers/squeezebox-classic.md), [Squeezebox Boom](../players-and-controllers/squeezebox-boom.md), [Squeezebox Receiver](../players-and-controllers/squeezebox-receiver.md), [Transporter](../players-and-controllers/transporter.md), [Squeezebox2](../players-and-controllers/squeezebox2.md), [Squeezebox](../players-and-controllers/squeezebox1.md) and [SLIMP3](../players-and-controllers/SLIMP3.md).

Before version 7.7 LMS was known as Squeezebox Server (version 7.4 to 7.6) and SlimServer (before 7.4). Version 7.7 was the last version released by Logitech, from version 7.8 and onwards LMS had been released by the LMS Community. 

Logitech Media Server is Open Source Software and written in Perl. Logitech Media Server runs on pretty much any platform that Perl runs on, including Linux, Mac OSX, Solaris and Windows.

## Version history

### LMS 8.4

Still under development, not yet released.

### LMS 8.3

Current stable. Initially released on Nov 4, 2022.

Logitech Media Server 8.3.0 is mostly a maintenance release without any major new features. Oh, hold on... unless you're a Mac user! Apple provided a good reason to get LMS 8.3.0 out: macOS 13 Ventura removed the Perl version we've relied on for about a decade. So, the new feature is:

- Support for macOS 13 (native Apple Silicon as well as Intel)

But there are a ton of changes, smaller or bigger. A few noteworthy changes:

- Updated French, British English, Czech, and Dutch translations.
- Improved indexing performance for the Fulltext Search of large playlists (thousands of tracks).
- Improved security for the MySqueezebox.com integration.
- Improved JavaScript support for the Settings pages in the Classic/Light skin (and thus Material).
- More robust https streaming for some very long (but finite) streams and larger files (hires).
- [Removal of video/picture support.](https://forums.slimdevices.com/forum/developer-forums/beta/113076-v8-3-0-bye-bye-video-picture-support)

Other important changes are the removal of PowerPC, Sparc, i386 (Mac), and really old Perl versions are no longer part of the builds.

[Release notes](https://forums.slimdevices.com/forum/user-forums/logitech-media-server/113782-logitech-media-server-8-3-0-released)

### LMS 8.2

Initially released on Aug 3, 2021. This release comes with a lot of improvements, not big new features. But many of them address long standing pain points. Some of the highlights are:

- Improved podcast support (search, more robust playback)
- Improved online music integration (smarter matching of artists, track stats support)
- Improved shuffling method to give more "balanced" results
- Add Balance setting for players which support it
- Improved robustness for online streams
- Add resampling for Ogg/Flac streams

[Release notes](https://forums.slimdevices.com/forum/user-forums/logitech-media-server/111679-logitech-media-server-8-2-0-released)

### LMS 8.1

Initially released on Dec 23, 2020, LMS 8.1 brings the following changes:

- Support for Deezer lossless (FLAC) streaming
- Improvements to the transcoding framework to allow protocol handlers to enforce transcoding (eg. TIDAL lossless)
- Support for macOS 11 Big Sur and Apple Silicon (M1 CPU - using Rosetta)
- Optionally allow installation of plugins which were targeted at Logitech Media Server 7.*

Other important changes are the removal of the ReadyNAS NV/Duo/Pro devices, and Perl 5.8 in general. We actually broke Perl 5.8 compatibility somewhere around LMS 7.9.3. These platforms haven't been working correctly since then. Removing them thus doesn't really change anything. ReadyNAS users please note: this is really only about the old, legacy, generation 1/2 Raidiator v4 based devices. Any recent ReadyNAS unit, which was based on Debian, should still continue to work as before. Good or bad.

[Release notes](https://forums.slimdevices.com/forum/user-forums/logitech-media-server/110224-logitech-media-server-8-1-0-released)

### LMS 8.0

Initially released on Nov 22, 2020, LMS 8 adds a lot of improvements for users of online music. But there's more:

- Import your online music library to your music library. No matter whether your favorite album or artist is stored on your disk, or on some music service - it shows up right where you expect "your music" to be.
- https is the new http: most web sites nowadays are delivered over the secure https protocol. And so are more and more online music streams. Logitech Media Server 8 allows you to continue to listen to your favorite stations, as well as music services like TIDAL.
- Allow to paste TIDAL and Deezer web links to the Tune In field (or use the corresponding CLI command) to play those items.
- Plugins now can use SOCKS to access online sources.
- Helper applications (faad, flac) have been updated, as well as some of the Perl libraries, like Audio::Scan (not all supported platforms).
- Docker is everywhere. A Logitech Media Server image is now available on Docker Hub.
- Updated translations for Swedish and Dutch.

[Release notes](https://forums.slimdevices.com/forum/user-forums/logitech-media-server/109995-logitech-media-server-8-0-0-released)

### LMS 7.9

Initially released on Mar 8, 2017. LMS 7.9 comes with lots of improvements, both under the hood as well as in your preferred user interface:

- [Fulltext search](https://forums.slimdevices.com/forum/developer-forums/beta/98887-new-in-7-9-fulltext-search)
- Native support of DSD
- Customizable browse modes
- Direct access to other source (LMS or UPnP)
- Playback of local tunes without adding them to the library
- Filtered views

[Release notes](https://forums.slimdevices.com/forum/user-forums/logitech-media-server/103726-logitech-media-server-7-9-0-is-out)

### LMS 7.8

Initially released on Mar 27, 2014, this is the first community supported version of LMS. Major improvements over the "official" 7.7.x version:

- Improved Podcast plugin to support all players
- Add new scanner step to discover new/changed/removed standalone artwork for album covers
- Improved Internet Radio integration to work independently from mysb.com if needed
- Support for Ogg FLAC in the server and Squeezeplay-based players
- Added support for setting alarm playlist shuffle mode (thanks hickinbottoms!)
- Volume adjustment for internet music services
- Add Triode's LocalFile 'loc' ProtocolHandler support for squeezelite.

[Release notes](https://forums.slimdevices.com/forum/user-forums/logitech-media-server/97738-logitech-media-server-7-8-0-now-available)
