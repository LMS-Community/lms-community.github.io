## Introducing... Lyrion Music Server Version 9.0.0!

- [Upstream fixes from Logitech Media Server 8.5.x](changelog-lms8.md)

- New Features:

	- New product name! Welcome Lyrion Music Server!
	- New visuals - thanks @gobuleberbu & @mikes!
	- Default skin refresh (the old version is still available as "Logic Teal")
	- Improved first start setup: suggest a few plugins to install on initial startup.
	- Add new "Recently Changed" browse mode to complement the "New Music" menu. The latter is no longer based on the file's timestamp, but on the time added to the collection, as stored in the persistant track table.
	- [Massive upgrade for Classical music lovers](https://github.com/LMS-Community/slimserver/pull/930): add support for Works, Performances, Disc Subtitles. Thanks a ton @darrel-k!
	- [#1095](https://github.com/LMS-Community/slimserver/issues/1095) \- Link from online tracks and albums to local library (if possible).
	- [#1115](https://github.com/LMS-Community/slimserver/pull/1115) \- Add option to show tracks from a given year, even if their album would be listed in a different year.

- Server Changes:

	- Updated Czech translation - thanks @mipa87!
	- Updated French translation - thanks @Franck-Berry!
	- Improve Plugin Manager: add categories, icons, search, nicer UX.
	- [#1124](https://github.com/LMS-Community/slimserver/pull/1124) \- Return 'Random Mix' state in player status message (thanks @CraigD!)

- Platform Support:

	- [#64](https://github.com/LMS-Community/slimserver-platforms/pull/64) \- Upgrade Docker base image to Debian 12 (Bookworm) - thanks @mavit!

- Bug Fixes:

	- [#1027](https://github.com/LMS-Community/slimserver/issues/1027) \- Play count increase with in-track jumps (thanks @darrel-k!)
	- [#1116](https://github.com/LMS-Community/slimserver/pull/1116) \- Fix album info track count when there are more than 50 tracks in an album (thanks @darrel-k!)
	- Fix "serverstatus" subscriptions for prefs changes.

- Other:

	- Move CLI documentation out of the server code to [lyrion.org](https://lyrion.org/reference/cli/introduction/).

