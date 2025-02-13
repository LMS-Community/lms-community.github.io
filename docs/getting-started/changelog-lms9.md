## Version 9.1.0

- [Upstream fixes from Lyrion Music Server 9.0.x](#version-901)

- New Features:

- Server Changes:

	- [#1245](https://github.com/LMS-Community/slimserver/pull/1245) \- Added a Simple WebSocket client capability for 3rd Party Plugins to support this protocol (expectingtofly)

- Platform Support:

	- Make Docker a first class citizan: add Slim::Utils::OS::Docker insted of a Custom.pm
	- Remove Win32 legacy support files, code, control panels, build pipeline, etc.
	- Remove legacy Mac installer from build pipeline.
	- Remove code dealing with Perl < 5.10.
	- Upgrade DBD::SQLite to v1.75 for Perl 5.38 (Linux x86\_64), 5.36 (Linux x86\_64, aarch64, armv7), 5.34 (Linux x86\_64, aarch64; macOS), 5.32 (Linux x86\_64, aarch64, armv7).
	- [#73](https://github.com/LMS-Community/slimserver-platforms/pull/73) \- Add a note about setting the hostname in a Docker container (thanks @hartzell!)
	- [#86](https://github.com/LMS-Community/slimserver-platforms/pull/86) \- Add more tags to Docker images to better support automated updates (thanks @stavros-k!)

- Bug Fixes:

	- [#1287](https://github.com/LMS-Community/slimserver/pull/1287) \- fix method name for spdr protocol handler.

- Other:

	- Remove more left-overs from removed picture/video scanning.
	- Remove more left-overs from removed MySqueezebox integration.

## Version 9.0.2

- New Features:

	- Add a few more alarm clock sounds to the Sounds & Effects plugin.

- Server Changes:

- Platform Support:

	- Improve Windows installer to give better feedback on service start failure.
	- [#85](https://github.com/LMS-Community/slimserver-platforms/pull/85) \- Change permissions of user running LMS in Docker. Use "squeezeboxserver" group instead of "nogroup" (thanks @osnieh!)

- Bug Fixes:

	- Mitigate an [issue with uppercase umlauts and other non-latin characters](https://forums.lyrion.org/forum/developer-forums/developers/1747258) in the full text search on Windows.
	- [#1193](https://github.com/LMS-Community/slimserver/issues/1193) \- Don't throw error when fulltext search is being used before the end of a scan.
	- [#1288](https://github.com/LMS-Community/slimserver/issues/1288) \- Update Carp::Assert to latest to fix compatibility with recent Perl versions.
	- [#1303](https://github.com/LMS-Community/slimserver/pull/1303) \- Fix an issue where browsing releases would sometimes create thousands of parameters (and more - thanks @darrel-k!).
	- [#1306](https://github.com/LMS-Community/slimserver/pull/1306) \- Don't run the scanner before we're done with the setup wizard.
	- [#1307](https://github.com/LMS-Community/slimserver/pull/1307) \- Fix scanner progress information in the web UI.
	- [#1309](https://github.com/LMS-Community/slimserver/pull/1309) \- Limit works advanced search to discovered albums. (@darrel-k)
	- [#1314](https://github.com/LMS-Community/slimserver/issue/1314) \- The server would seemingly hang when trying to connect to the Material skin as long as no work has been found.
	- [#1319](https://github.com/LMS-Community/slimserver/pull/1319) \- Don't filter by release types if user pref is ignoreReleaseTypes (@darrel-k).
	- Improve compatibility with modern HTML/JS and more strict browsers (eg. Safari).

- Other:

	- [#1315](https://github.com/LMS-Community/slimserver/pull/1315) \- Return contiguous/non-contiguous flag in statusQuery (thanks @darrel-k).

## Version 9.0.1 - 2025-01-09 (e3effbe91)

- New Features:

	- [#1267](https://github.com/LMS-Community/slimserver/issues/1267) \- Provide easy installation of Date and Time screensaver for Classic/Boom/Transporter users.

- Server Changes:

	- Analytics: only check a small, well defined list of pref changes to decide whether a disconnected player had been active recently.
	- Initialize autoincrement start value for contributors table to prevent ID re-use on full wipe & rescans.
	- [#1259](https://github.com/LMS-Community/slimserver/issues/1259) \- Improve the way in which we initialize a "track added" timestamp. Use the file's timestamp on initial imports.

- Platform Support:

	- Fix helper search path initialisation on older macOS using Perl 5.18.
	- [#74](https://github.com/LMS-Community/slimserver-platforms/issues/74) \- Speed up Perl installation during an initial installation on Windows.
	- [#75](https://github.com/LMS-Community/slimserver-platforms/issues/75) \- Make sure newly installed LMS on Windows is running before sending the user to the web page.
	- [#76](https://github.com/LMS-Community/slimserver-platforms/issues/76) \- Start/stop LMS on Mac when the menu bar item is started/stopped.
	- [#77](https://github.com/LMS-Community/slimserver-platforms/issues/77) \- Add instructions to the macOS DMG file. Improve overall user experience.
	- [#78](https://github.com/LMS-Community/slimserver-platforms/issues/78) \- Fix crypto library linking issues in the Docker image.
	- [#80](https://github.com/LMS-Community/slimserver-platforms/issues/80) \- Reset update status when updating fromt he macOS menu bar item.
	- Have a newly installed LMS on Windows use "Lyrion" as the data path, rather than "Squeezebox".

- Bug Fixes:
	- Only re-initialize menu settings for connected players - otherwise Analytics considers them "active" due to a prefs change.
	- Fix display of final "Scan done" message in Material skin.
	- Fix track count caching in "titles" query.
	- [#1235](https://github.com/LMS-Community/slimserver/pull/1235) \- Need to utf8Decode album title for new & changed (thanks @darrel-k!)
	- [#1237](https://github.com/LMS-Community/slimserver/pull/1237) \- Fix create table syntax for MySQL (MariaDB) (thanks @JKDingwall!)
	- [#1238](https://github.com/LMS-Community/slimserver/pull/1238) \- Merge multiple works per track into one single work (thanks @darrel-k!)
	- [#1240](https://github.com/LMS-Community/slimserver/pull/1240) \- Add option to limit works scanning to classical genre(s) (thanks @darrel-k!)
	- [#1242](https://github.com/LMS-Community/slimserver/issues/1242) \- Fix plugin download - must wait for the download to finish before restarting the server
	- [#1247](https://github.com/LMS-Community/slimserver/issues/1247) \- Fix display of final "Scan done" message and "Abort scan" link in Material/Classic skins.
	- [#1250](https://github.com/LMS-Community/slimserver/issues/1250) \- Radio stations wouldn't show album artwork any more.
	- [#1246](https://github.com/LMS-Community/slimserver/issues/1264) \- Windows registry value "DataPath" is in the wrong place.
	- [#1273](https://github.com/LMS-Community/slimserver/pull/1273) \- Remove grouping & discsubtitle in new & changed scan if tags were removed (thanks @darrel-k!)

## Introducing... Lyrion Music Server Version 9.0.0! - 2024-11-29 (2ed5e147e)

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
	- [#1228](https://github.com/LMS-Community/slimserver/issues/1228) \- Allow user to define how many HTTP requests to follow.

- Server Changes:

	- Added Hungarian translations - thanks @ambrits!
	- Updated Czech translation - thanks @mipa87!
	- Updated Danish translation - thanks @cfuttrup!
	- Updated Dutch translation - thanks @terual!
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
	- [#1229](https://github.com/LMS-Community/slimserver/pull/1229) \- Only allow audio tracks for RandomPlay (thanks @jbylsma!)

- Other:

	- Move CLI documentation out of the server code to [lyrion.org](https://lyrion.org/reference/cli/introduction/).
	- Allow a caller (plugin) of Slim::Networking::SimpleAsyncHTTP to disable HTTPS certificate validation.

