## Version 9.1.0

- [Upstream fixes from Lyrion Music Server 9.0.x](#version-903)

- New Features:

	- Optionally navigate playlists by folders, allowing you to organise your playlists hierarchically.
	- Implement an artist portrait picture handler. This will read images from folders where you've stored them under the artist's name, or from the artist folder in a typical artist/album/track hierarchy.
	- Add a plugin to try to fetch artwork for radio stations which don't provide track artwork.
	- [#1425](https://github.com/LMS-Community/slimserver/pull/1425) \- Add playlist drag and drop support to the Classic skin (thanks @oreillymj)
	- [#1426](https://github.com/LMS-Community/slimserver/pull/1426) \- add support for ListenBrainz to AudioScrobbler plugin (thanks @vysmaty & AI)
	- Allow GETting the JSONRPC.js handler with a "request" parameter to simplify access by limited clients.
	- [#1294](https://github.com/LMS-Community/slimserver/issues/1294) \- Bring back list view in the Manage Plugins section. The view can be toggled between grid an list view.
	- [#1422](https://github.com/LMS-Community/slimserver/issues/1422) \- Add new sort orders "playcount" and "recentlyplayed" to "albums" query.
	- Provide a hook which would allow a plugin or other to register a method to display track artwork for radio stations which don't provide their own.

- Server Changes:

	- Improve support for 3rd party player icons, add some for piCorePlayer, SqueezeAMP, WiiM players.
	- Update downloader now validates the installers checksum.
	- Updated French translation - thanks @Franck-Berry!
	- Updated Chinese translation - thanks @xdsnet!
	- Improve cache purging reliability to avoid unnecessary growth.
	- Update the custom user agent string: pretending to be iTunes probably caused more problems than it solved.
	- Enable log rotation on Docker based systeme.
	- Don't re-encode lossy streams when bitrate limiting if original stream is of lower or equal bitrate already (thanks @ralphy!)
	- Add prefs folder to search list for custom types/convert/strings files (macOS/Windows).
	- Use online service to convert WEBP images to JPEG if needed (only works with online images).
	- [#1216](https://github.com/LMS-Community/slimserver/pull/1216) \- Reset playing position to first track once a playlist or album has ended (@ml-1)
	- [#1245](https://github.com/LMS-Community/slimserver/pull/1245) \- Added a Simple WebSocket client capability for 3rd Party Plugins to support this protocol (@expectingtofly)
	- [#1356](https://github.com/LMS-Community/slimserver/pull/1356) \- Use ORIGINALDATE tag with Flac (@jbylsma)
	- [#1363](https://github.com/LMS-Community/slimserver/pull/1363) \- Allow item removal even if playlist has only 1 item (@mw9)
	- [#1364](https://github.com/LMS-Community/slimserver/pull/1364) \- store/return playqueue entry context flag ("addedFromWork")
	- [#1377](https://github.com/LMS-Community/slimserver/pull/1377) \- Provide new /time/tz endpoint for Squeezeplay to fetch the local timezone (@mw9)
	- [#1399](https://github.com/LMS-Community/slimserver/pull/1399) \- Use artwork appropriate for a Work if multiple album covers

- Platform Support:

	- Make piCorePlayer a first class citizan: add Slim::Utils::OS::pCP to support it
	- Make Docker a first class citizan: add Slim::Utils::OS::Docker instead of a Custom.pm
	- Remove Win32 legacy support files, code, control panels, build pipeline, etc.
	- Remove legacy Mac installer from build pipeline.
	- Remove code dealing with Perl < 5.10.
	- Remove support for older Perl versions from the RPM (thanks @mavit!) and DEB packages.
	- Stop building i386 DEB package.
	- Updated Audio::Scan to v1.11 on Linux Perl 5.36/5.40, and Windows - thanks @ralphy!
	- Upgrade DBD::SQLite to v1.75 for Perl 5.40 (Linux x86\_64, aarch64), 5.38 (Linux x86\_64), 5.36 (Linux x86\_64, aarch64, armv7), 5.34 (Linux x86\_64, aarch64; macOS), 5.32 (Linux x86\_64, aarch64, armv7).
	- [#73](https://github.com/LMS-Community/slimserver-platforms/pull/73) \- Add a note about setting the hostname in a Docker container (thanks @hartzell!)
	- [#86](https://github.com/LMS-Community/slimserver-platforms/pull/86) \- Add more tags to Docker images to better support automated updates (thanks @stavros-k!)
	- [#101](https://github.com/LMS-Community/slimserver-platforms/pull/101) \- Add package opus-tools to docker image (thanks @terual!)

- Bug Fixes:

	- The AudioScrobbler failed to report tracks from online music services when they were integrated with the local library.
	- Let the image proxy tell the upstream server what image formats we support, because we don't support WEBP.
	- [#1287](https://github.com/LMS-Community/slimserver/pull/1287) \- fix method name for spdr protocol handler.
	- [#1359](https://github.com/LMS-Community/slimserver/pull/1359) \- Update UPnP ConnectionManager.pm to add checks for Wav and Opus (@BoringName15).
	- [#1362](https://github.com/LMS-Community/slimserver/pull/1362) \- Update UPnP AVTransport.pm to move LMS event registration (@BoringName15).
	- [#1367](https://github.com/LMS-Community/slimserver/pull/1367) \- Update UPnP support to fix gapless playback (setNextAVTransport) (@BoringName15).
	- [#1414](https://github.com/LMS-Community/slimserver/pull/1414) \- Make sure custom image proxy handlers are always called (fixes incompatibility with Radio Now Playing's SVG handler).
	- [#1442](https://github.com/LMS-Community/slimserver/pull/1442) \- Avoid log flood when player discovery JSON is empty (@mikecappella).
	- [#1444](https://github.com/LMS-Community/slimserver/pull/1444) \- Fix search using terms with quotes in the Default skin (@darrell-k).
	- [#1444](https://github.com/LMS-Community/slimserver/pull/1444) \- Fix search using terms with quotes in the Default skin (@darrell-k).
	- [#1460](https://github.com/LMS-Community/slimserver/pull/1460) \- Don't close HTTP when 1.1, unless explicit asked (@philippe44).

- Other:

	- Remove more left-overs from removed picture/video scanning.
	- Remove more left-overs from removed MySqueezebox integration.
	- Remove support for MySQL. Existing configurations using it will log an error.
	- [#1458](https://github.com/LMS-Community/slimserver/pull/1458) \- Add devcontainer configuration with Dockerfile and docker-compose setup (@LMSSonos).

## Version 9.0.4

- New Features:

- Server Changes:

	- Updated Czech translation - thanks @mipa87!

- Platform Support:

	- [#1441](https://github.com/LMS-Community/slimserver/issues/1441) \- Install procps package Docker image in support of plugins which need the tools to manage their helper processes.

- Bug Fixes:

	- Classic/Transporter/Boom [would not navigate down the artist](https://forums.lyrion.org/forum/user-forums/logitech-media-server/1794277) of the currently playing track.
	- [#1280](https://github.com/LMS-Community/slimserver/issues/1280) \- persists current song on last track (thanks @MrC!).

- Other:

## Version 9.0.3 - 2025-10-03 (9977737c1)

- Server Changes:

	- [#1386](https://github.com/LMS-Community/slimserver/pull/1386) \- Store the calculated replay gain in the song object when beginning playback (@SamInPgh)

- Platform Support:

	- Add support for Perl 5.40 on aarch64/armv7 Linux.
	- [#1339](https://github.com/LMS-Community/slimserver/issues/1339) \- Add ghcr.io as an alternative container registry in addition to Docker Hub.
	- Download Strawberry Perl for Windows from our own download site. strawberryperl.com has been unstable recently.

- Bug Fixes:
	- [#1373](https://github.com/LMS-Community/slimserver/issues/1373) \- Transcoding of some APE files does not work with LMS 9 - upgrade the mac binary to v10 (thanks @ralphy!).
	- [#1378](https://github.com/LMS-Community/slimserver/issues/1378) \- Rescanning a track with MusicBrainz ID can lead to corrupted ID value in database.
	- [#1423](https://github.com/LMS-Community/slimserver/pull/1423) \- Fix compatibility with Squeezer app (thanks @darrell-k).
	- [#1429](https://github.com/LMS-Community/slimserver/pull/1429) \- Make sure work is removed from track if removed in tags (thanks @darrell-k).

## Version 9.0.2 - 2025-03-13 (1470c9412)

- New Features:

	- Add a few more alarm clock sounds to the Sounds & Effects plugin.

- Platform Support:

	- Improve Windows installer to give better feedback on service start failure.
	- [#85](https://github.com/LMS-Community/slimserver-platforms/pull/85) \- Change permissions of user running LMS in Docker. Use "squeezeboxserver" group instead of "nogroup" (thanks @osnieh!)

- Bug Fixes:

	- Mitigate an [issue with uppercase umlauts and other non-latin characters](https://forums.lyrion.org/forum/developer-forums/developers/1747258) in the full text search on Windows.
	- [#1193](https://github.com/LMS-Community/slimserver/issues/1193) \- Don't throw error when fulltext search is being used before the end of a scan.
	- [#1214](https://github.com/LMS-Community/slimserver/issues/1214) \- If item in queue can't be played, StreamingController leaves player in a bad state, failing further playback.
	- [#1288](https://github.com/LMS-Community/slimserver/issues/1288) \- Update Carp::Assert to latest to fix compatibility with recent Perl versions.
	- [#1303](https://github.com/LMS-Community/slimserver/pull/1303) \- Fix an issue where browsing releases would sometimes create thousands of parameters (and more - thanks @darrell-k!).
	- [#1306](https://github.com/LMS-Community/slimserver/pull/1306) \- Don't run the scanner before we're done with the setup wizard.
	- [#1307](https://github.com/LMS-Community/slimserver/pull/1307) \- Fix scanner progress information in the web UI.
	- [#1309](https://github.com/LMS-Community/slimserver/pull/1309) \- Limit works advanced search to discovered albums. (@darrell-k)
	- [#1314](https://github.com/LMS-Community/slimserver/issues/1314) \- The server would seemingly hang when trying to connect to the Material skin as long as no work has been found.
	- [#1319](https://github.com/LMS-Community/slimserver/pull/1319) \- Don't filter by release types if user pref is ignoreReleaseTypes (@darrell-k).
	- [#1320](https://github.com/LMS-Community/slimserver/pull/1320) \- Scanner crashes on unexpected system folders.
	- [#1325](https://github.com/LMS-Community/slimserver/pull/1325) \- Fix scanning multiple MusicBrainz IDs (@darrell-k).
	- Improve compatibility with modern HTML/JS and more strict browsers (eg. Safari).

- Other:

	- [#1315](https://github.com/LMS-Community/slimserver/pull/1315) \- Return contiguous/non-contiguous flag in statusQuery (thanks @darrell-k).

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
	- [#1235](https://github.com/LMS-Community/slimserver/pull/1235) \- Need to utf8Decode album title for new & changed (thanks @darrell-k!)
	- [#1237](https://github.com/LMS-Community/slimserver/pull/1237) \- Fix create table syntax for MySQL (MariaDB) (thanks @JKDingwall!)
	- [#1238](https://github.com/LMS-Community/slimserver/pull/1238) \- Merge multiple works per track into one single work (thanks @darrell-k!)
	- [#1240](https://github.com/LMS-Community/slimserver/pull/1240) \- Add option to limit works scanning to classical genre(s) (thanks @darrell-k!)
	- [#1242](https://github.com/LMS-Community/slimserver/issues/1242) \- Fix plugin download - must wait for the download to finish before restarting the server
	- [#1247](https://github.com/LMS-Community/slimserver/issues/1247) \- Fix display of final "Scan done" message and "Abort scan" link in Material/Classic skins.
	- [#1250](https://github.com/LMS-Community/slimserver/issues/1250) \- Radio stations wouldn't show album artwork any more.
	- [#1246](https://github.com/LMS-Community/slimserver/issues/1264) \- Windows registry value "DataPath" is in the wrong place.
	- [#1273](https://github.com/LMS-Community/slimserver/pull/1273) \- Remove grouping & discsubtitle in new & changed scan if tags were removed (thanks @darrell-k!)

## Introducing... Lyrion Music Server Version 9.0.0! - 2024-11-29 (2ed5e147e)

- [Upstream fixes from Logitech Media Server 8.5.x](changelog-lms8.md)

- New Features:

	- New product name! Welcome Lyrion Music Server!
	- New visuals - thanks @gobuleberbu & @mikes!
	- Default skin refresh (the old version is still available as "Logic Teal")
	- [Massive upgrade for (Classical) music lovers](https://github.com/LMS-Community/slimserver/pull/930): add support for Works, Performances, Disc Subtitles, Roles. Thanks a ton @darrell-k!
	- Improved first start setup: suggest a few plugins to install on initial startup.
	- Add new "Recently Changed" browse mode to complement the "New Music" menu. The latter is no longer based on the file's timestamp, but on the time added to the collection, as stored in the persistant track table.
	- [#1095](https://github.com/LMS-Community/slimserver/issues/1095) \- Link from online tracks and albums to local library (if possible).
	- [#1115](https://github.com/LMS-Community/slimserver/pull/1115) \- Add option to show tracks from a given year, even if their album would be listed in a different year.
	- [#1132](https://github.com/LMS-Community/slimserver/pull/1132) \- Allow user defined contributor roles (thanks @darrell-k!).
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

	- [#1027](https://github.com/LMS-Community/slimserver/issues/1027) \- Play count increase with in-track jumps (thanks @darrell-k!)
	- [#1116](https://github.com/LMS-Community/slimserver/pull/1116) \- Fix album info track count when there are more than 50 tracks in an album (thanks @darrell-k!)
	- [#1138](https://github.com/LMS-Community/slimserver/issues/1138) \- "Add all songs" from search not working (thanks @darrell-k!)
	- [#1146](https://github.com/LMS-Community/slimserver/pull/1146) \- Restore partial Cometd support for CLI clients (thanks @sodface!)
	- [#1203](https://github.com/LMS-Community/slimserver/pull/1203) \- Fix display of album roles in the playlist (thanks @darrell-k!)
	- [#1213](https://github.com/LMS-Community/slimserver/issues/1213) \- Modify #CURRTRACK to first track when playlist finishes
	- [#1229](https://github.com/LMS-Community/slimserver/pull/1229) \- Only allow audio tracks for RandomPlay (thanks @jbylsma!)

- Other:

	- Move CLI documentation out of the server code to [lyrion.org](https://lyrion.org/reference/cli/introduction/).
	- Allow a caller (plugin) of Slim::Networking::SimpleAsyncHTTP to disable HTTPS certificate validation.

