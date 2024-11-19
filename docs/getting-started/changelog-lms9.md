## Introducing... Lyrion Music Server Version 9.0.0!

- [Upstream fixes from Logitech Media Server 8.5.x](changelog-lms8.md)

- New Features:

	- New product name! Welcome Lyrion Music Server!
	- New visuals - thanks @gobuleberbu & @mikes!
	- Default skin refresh (the old version is still available as "Logic Teal")
	- [Massive upgrade for (Classical) music lovers](https://github.com/LMS-Community/slimserver/pull/930): add support for Works, Performances, Disc Subtitles, Roles. Thanks a ton @darrel-k!
	- Improved first start setup: suggest a few plugins to install on initial startup.
	- Add new "Recently Changed" browse mode to complement the "New Music" menu. The latter is no longer based on the file's timestamp, but on the time added to the collection, as stored in the persistant track table.
	- [#1095](https://github.com/LMS-Community/slimserver/issues/1095) \- Link from online tracks and albums to local library (if possible).
	- [#1115](https://github.com/LMS-Community/slimserver/pull/1115) \- Add option to show tracks from a given year, even if their album would be listed in a different year.
	- [#1132](https://github.com/LMS-Community/slimserver/pull/1132) \- Allow user defined contributor roles (thanks @darrel-k!).

- Server Changes:

	- Added Hungarian translations - thanks @ambrits!
	- Updated Czech translation - thanks @mipa87!
	- Updated Danish translation - thanks @cfuttrup!
	- Updated French translation - thanks @Franck-Berry!
	- Updated Portuguese translation - thanks @DuLac!
	- Improved Plugin Manager: add categories, icons, and search.
	- [#1124](https://github.com/LMS-Community/slimserver/pull/1124) \- Return 'Random Mix' state in player status message (thanks @CraigD!)
	- [#1144](https://github.com/LMS-Community/slimserver/pull/1144) \- Remove unnecessary delay reporting volume changes (thanks @SamInPgh!)

- Platform Support:

	- Replace the macOS Preference Pane with a menubar item (requires macOS 10.11 El Capitan).
	- [#64](https://github.com/LMS-Community/slimserver-platforms/pull/64) \- Upgrade Docker base image to Debian 12 (Bookworm) - thanks @mavit!
	- [#1198](https://github.com/LMS-Community/slimserver/issues/1198) \- Add support for Perl 5.40 on x86\_64 Linux.
	- Much improved RPM packages to better integrate with system standards (thanks @JohanSaaw!)
	- Update Windows 64-bit installer to be compatible with new Windows on ARM machines.
	- Updated Audio::Scan to v1.09 on Windows 32-bit, v1.10 on Windows 64-bit and Linux Perl 5.36/5.38 - thanks @ralphy!
	- Dropped support for Windows 32-bit and macOS < 10.11.

- Bug Fixes:

	- [#1027](https://github.com/LMS-Community/slimserver/issues/1027) \- Play count increase with in-track jumps (thanks @darrel-k!)
	- [#1116](https://github.com/LMS-Community/slimserver/pull/1116) \- Fix album info track count when there are more than 50 tracks in an album (thanks @darrel-k!)
	- [#1138](https://github.com/LMS-Community/slimserver/issues/1138) \- "Add all songs" from search not working (thanks @darrel-k!)
	- [#1146](https://github.com/LMS-Community/slimserver/pull/1146) \- Restore partial Cometd support for CLI clients (thanks @sodface!)
	- [#1203](https://github.com/LMS-Community/slimserver/pull/1203) \- Fix display of album roles in the playlist (thanks @darrel-k!)
	- [#1213](https://github.com/LMS-Community/slimserver/issues/1213) \- Modify #CURRTRACK to first track when playlist finishes

- Other:

	- Move CLI documentation out of the server code to [lyrion.org](https://lyrion.org/reference/cli/introduction/).

