## Version 8.5.3

- New Features:

- Server Changes:

- Platform Support:

	- Add Windows Start menu item to run LMS interactively when not using as a background service (64-bit version).

- Bug Fixes:

	- Sometimes setting a music or playlist folder might lead the server into an infinite recursion.
	- Fix running the scanner from outside LMS on Windows 64-bit.

- Other:

## Version 8.5.2 - 2024-05-26 (88ba56f2c)

- Server Changes:

	- Fall back to "latest" firmware folder if no server version specific files can be found.
	- Improve Analytics reporting to cover more player types.

- Platform Support:

	- Improve macOS architecture detection

- Bug Fixes:

	- [#1056](https://github.com/Logitech/slimserver/pull/1056) \- Fix playback of certain mp4 files (thanks philippe44!)
	- [#1047](https://github.com/Logitech/slimserver/pull/1047) \- Fix sort collation when requesting artists
	- [#1083](https://github.com/LMS-Community/slimserver/pull/1083) \- Fixes for playlist add via Release Type groups (thanks darrel-k!)
	- Fix /music/current/cover artwork handler for certain cases where resizing would fail (eg. [Podcasts](https://forums.slimdevices.com/forum/developer-forums/developers/1699734))
	- [Fix RandomPlay](https://forums.slimdevices.com/forum/user-forums/3rd-party-software/106269-announce-material-skin/page652#post1707487) when overriding a selected library view with "all music" (see when using Material skin)
	- Use ORIGINALYEAR, ORIGINALDATE, or DATE to parse the year from Ogg files.

## Version 8.5.1 - 2024-04-15 (3b46196aa)

- New Features:

	- Add plugin to report data about your LMS installation - see [forum discussion](https://forums.slimdevices.com/forum/user-forums/general-discussion/1697108).

- Server Changes:

	- Add links to the settings of the AudioAddict based services.
	- Add support for "DELETE" HTTP verb to SimpleAsyncHTTP.

- Bug Fixes:

	- Fix definition of track-level favorites' artwork.
	- Correctly prefix settings links from Plugins page with the web root.
	- [#1020](https://github.com/LMS-Community/slimserver/pull/1020) \- Add icon to favorites in Default web UI et al. (thanks philippe44 && darrell-k)
	- [#1029](https://github.com/LMS-Community/slimserver/pull/1029) \- Fix incorrect HTTP skipping (thanks philippe44 && bpa!)
	- [#1045](https://github.com/LMS-Community/slimserver/issues/1045) \- "shufflemode" is missing from "alarms" query (thanks @CDrummond!)

## Version 8.5.0 - 2024-03-14 (8762186a4)

- [Upstream fixes from Logitech Media Server 8.4.x](#version-841)

- Server Changes:

	- Remove all dependency on MySqueezebox.com.
	- Remove warning about "incompatible" Radio firmware version 7.\*.
	- [#1003](https://github.com/LMS-Community/slimserver/issues/1003) \- Add alarm information to player "status" query.

- Bug Fixes:

	- [#998](https://github.com/LMS-Community/slimserver/pull/998) \- Fix Sounds & Effects playback when password protection is enabled.
	- [#1007](https://github.com/LMS-Community/slimserver/pull/1007) \- Fix track favorite links in album listings (thanks darrell-k!).

## Version 8.4.1

- Server Changes:

	- Improve Release Type readout in Ogg and WMA files.

- Bug Fixes:

	- Don't fail http caching due to extended characters in the URL.
	- Playing all items from a genre might fail under certain circumstances.
	- Use valid sorting arguments if sort order "albums" is requested when queuing up items.
	- Fix Last.fm scrobbling issue with some streaming service tracks.

## Version 8.4.0 - 2024-02-08 (e225575dc)

- [Upstream fixes from Logitech Media Server 8.3.x](#version-832)

- New Features:

	- [#879](https://github.com/LMS-Community/slimserver/issues/879) \- Add support for Release Types (see eg. on [MusicBrainz](https://musicbrainz.org/doc/Release_Group/Type)).
	- New "Advanced Tag View" plugin allows you to show more information in the Track Info menu, without the need to drill down to "View Tags"
	- Allow editing of a favourite's icon.
	- Add plugins for ClassicalRadio.com, DI.fm, JazzRadio.com, RadioTunes.com, RockRadio.com, ZenRadio.com.
	- Add an optional artist albums view which groups albums by release type and contribution. (thanks darrell-k!)
	- Add an option to import playlists from online music services.
	- [#987](https://github.com/LMS-Community/slimserver/pull/987) \- Add OggFlac support (thanks philippe44!)

- Server Changes:

	- Improve integration of the external image resizing helper daemon.
	- Improve built-in imageproxy: don't proxy image if original size is requested, re-direct instead; add support for custom headers when using external image proxy.
	- Updated Dutch translation - thanks blackfiction!
	- Updated French translation - thanks thanks Frank-Berry & philippe317!
	- Improve rendering of links in the web UI menus (comments, file download, etc.)
	- Sort tracks in "title" sort order by artist and album, too, if they're part of the result set.
	- Add option to check for updates every hour.
	- Optionally don't remove online duplicates from library views.
	- [#846](https://github.com/LMS-Community/slimserver/pull/846) \- Improve display of multiline lyrics and comments in the web UI (thanks mw9!)
	- Move persist.db out of the cache folder - it's music data which can't be restored from the music files.
	- Log warning if the server's time seems to be off (only if MySqueezebox integration is enabled).
	- Re-implement Sounds & Effects plugin to not depend on MySqueezebox for the navigation and content selection.
	- Report actual replay gain value for the currently playing track in "status" query.
	- Add "Q" tag to songinfo, status queries etc. to return lossless flag for tracks (thanks AF-1!).
	- [#862](https://github.com/LMS-Community/slimserver/pull/862) \- Make lyrics on Default skin songinfo page collapsible (thanks AF-1!)
	- [#868](https://github.com/LMS-Community/slimserver/pull/868) \- Populate the release year ('year') attribute for remote tracks in the player queue (thanks SamInPgh!)
	- [#956](https://github.com/LMS-Community/slimserver/pull/956) \- Add raw AAC (ADTS) file support (thanks philippe44!)
	- [#964](https://github.com/LMS-Community/slimserver/pull/964)/ [#985](https://github.com/LMS-Community/slimserver/pull/985) \- Handle case where user moves/adds/removes tracks in a playlist while the next track is already fully streamed (thanks philippe44!)
	- [#986](https://github.com/LMS-Community/slimserver/pull/986) \- Add a 'V' query that will return the maximum seek point in seconds within the current track duration for a 'live' radio stream (thanks expectingtofly & philippe44!)
	- Fix Napster playback on community firmware players

- Platform Support:

	- Tweak Apple OS Architecture discovery: use the "arm64" string rather than the CPU's name (eg. "Apple M1")
	- Add Perl 5.38 support for Linux x86\_64.
	- Add **experimental** support for Windows 64-bit - requires installation of [Strawberry Perl 5.32](https://strawberryperl.com/releases.html)!
	- Update Windows installer to use latest InnoSetup 6 - dropping support for Windows XP, 2003 Server, and Windows Home Server.

- Bug Fixes:

	- [#212](https://github.com/LMS-Community/slimserver/issues/212) \- Unicode sorting for Browse Music Folder broken (thanks kimmot!)
	- [#622](https://github.com/LMS-Community/slimserver/issues/622) \- \_\_requestRE should only match words provided to Slim::Control::Request::subscribe. (thanks earlchew!)
	- [#799](https://github.com/LMS-Community/slimserver/issues/799) \- Update IO::String to latest, fixing some odd Perl version check.
	- [#829](https://github.com/LMS-Community/slimserver/issues/829) \- Don't override a content type set by a page handler.
	- [#905](https://github.com/LMS-Community/slimserver/issues/905) \- Browsing in to playlists is extremely slow.
	- [#911](https://github.com/LMS-Community/slimserver/issues/911) \- Don't shut down the server on "restartserver" when we actually can't restart it.
	- [#939](https://github.com/LMS-Community/slimserver/issues/939) \- Player can't be switched from MySqueezebox.com to LMS
	- [#962](https://github.com/LMS-Community/slimserver/issues/962) \- Fix album\_contributor updates in New & Changed scan (thanks darrell!)
	- [#979](https://github.com/LMS-Community/slimserver/issues/979) \- New and changed contributor scanning improvements (thanks darrell!)
	- [Respect a contributor's Musicbrainz ID to separate artists of the same name.](https://forums.slimdevices.com/forum/user-forums/logitech-media-server/1648813)
	- [#969](https://github.com/LMS-Community/slimserver/pull/969) \- Add utf-8 guess decoding on Ogg metadata - thanks philippe44!
	- Try harder to avoid duplicate (but empty) album entries on singles.
	- Clear the Various Artists ID when a scan has finished.
	- Don't remove online libraries from library views unless there really is a local copy of the same album.
	- Fix Deezer SmartRadio track duration calculation.
	- Allow pausing Deezer Flow.
	- Fix resizing with a defined background color.

- Other:

	- Simplify plugin and server update repository handling.

## Version 8.3.2

- Platform Support:

	- [#891](https://github.com/LMS-Community/slimserver/issues/891) \- Add Perl 5.36 support for Linux aarch64, armv7.

- Bug Fixes:

	- [#874](https://github.com/LMS-Community/slimserver/pull/874) \- Fix shuffling when starting off with an empty playlist (thanks robho!)
	- [#918](https://github.com/LMS-Community/slimserver/pull/918) \- Fix browsing down to album favorites etc.
	- Add CPAN/auto/5.14 to lib search path for Windows builds to include Font::FreeType.
	- Fix another absolute path to a stylesheet in the Default skin.
	- Fix an issue where registering a pre-cache resolution would cause a subsequent LMS start to fail.

## Version 8.3.1 - 2023-02-17 (026019bb7)

- Server Changes:

	- Make log viewer template (log.html) skinnable by including skin.css.

- Platform Support:

	- Update Audio::Scan to 1.06 for certain platforms (thanks ralphy, robho, slartibartfast!)
	- [#826](https://github.com/LMS-Community/slimserver/issues/826) \- Add Perl 5.36 support for Linux x86\_64.
	- Add Perl 5.34 support for Linux aarch64.
	- Add signed version of our custom Perl build for macOS.

- Bug Fixes:

	- [#827](https://github.com/LMS-Community/slimserver/pull/827) \- Fix installation of plugin updates - honour user's choice (thanks mw9!)
	- Don't use our custom Perl build on macOS 10.x - these versions come with a still working Perl 5.18.
	- [#834](https://github.com/LMS-Community/slimserver/pull/834) \- Fix no-transcoding playback of m4a audio (thanks philippe44!)
	- [#835](https://github.com/LMS-Community/slimserver/pull/835) \- Improve Alarm reliability - prevent accidental/random alarm stops.
	- [#843](https://github.com/LMS-Community/slimserver/pull/843) \- HTTPSocks.pm - Binary OR used by mistake - Logical OR needed (thanks mw9!).
	- Remove support for "deflate" encoding type in SimpleHTTP requests: it must have been broken for over a decade!
	- [#852](https://github.com/LMS-Community/slimserver/pull/852) \- No result return while using Chinese Keyword in Fulltext Search.
	- [#857](https://github.com/LMS-Community/slimserver/pull/857) \- Fix changing MySB credentials using the "setsncredentials" command.

## Version 8.3.0 - 2022-11-04 (4e15dbdff)

- [Upstream fixes from Logitech Media Server 8.2.x](#version-821)

- New Features:

	- Add support for macOS 13 Ventura

- Server Changes:

	- Remove support for media types other than audio (video, pictures). Let's make "M" music again.
	- [#651](https://github.com/LMS-Community/slimserver/pull/651) \- Updated French translation - thanks Frank-Berry!
	- Added British English translations - thanks expectingtofly!
	- Updated Czech translation - thanks mipa87!
	- Updated Dutch translation - thanks blackfiction!
	- Add support for TIDAL replay gain.
	- Dramatically improve Fulltext Search indexing for large playlists (thousands of tracks).
	- Improve security of LMS <-> mysqueezebox.com communication: don't store credentials, but only a session token.
	- Clean up legacy JavaScript support: update PrototypeJS and Scriptaculous to their latest builds, remove some legacy code.
	- [#678](https://github.com/LMS-Community/slimserver/pull/678) \- Fix up character encoding issues in Web UI Scanner progress reporting and Web UI log display (thanks mw9!)
	- [#708](https://github.com/LMS-Community/slimserver/pull/708) \- Update to MP3, FLAC, Ogg and WMA Formats to use BPM tags - thanks kwarklabs!
	- [#751](https://github.com/LMS-Community/slimserver/pull/751) \- Shuffle tracks added with "playlist loadtracks" for a given year (thanks philchillbill!)
	- [#758](https://github.com/LMS-Community/slimserver/pull/758) \- Allow selection of regional language (eg. ZH\_CH or EN\_GB) through JSONRPC (thanks expectingtofly!)
	- [#785](https://github.com/LMS-Community/slimserver/issues/785) \- Improve adding albums as favorites: don't rely on the album title alone, but use the artist to identify the album, too.
	- [#817](https://github.com/LMS-Community/slimserver/issues/817) \- Fix JavaScript integration in settings pages for Classic/Light (and thus Material) skins.
	- Remove more legacy plugins: Amazon, MP3Tunes, Orange, YALP

- Platform Support:

	- [#673](https://github.com/LMS-Community/slimserver/pull/673) \- Add aarch64 Linux and 64-bit macOS binaries for Monkey's Audio (APE) files (thanks ralphy!)
	- [#684](https://github.com/LMS-Community/slimserver/pull/684) \- Updated Solaris Binaries for alac, flac, sox, faad, wvunpack, mac (thanks urknall!)
	- [#715](https://github.com/LMS-Community/slimserver/issues/715) \- Remove I18N::LangTags - it's outdated and has been part of core Perl since 5.12.
	- Added native support for Apple Silicon
	- Update Audio::Scan to 1.05 for certain platforms (thanks ralphy, slartibartfast!)
	- [#773](https://github.com/LMS-Community/slimserver/issues/773) \- Update flac to 1.3.4 (macOS, Linux i386, x86\_64, armhf, aarch64)
	- Added custom Perl 5.34 build for macOS 10.15+, in preparation for Apple's removal of Perl from macOS
	- Remove support for the embedded MySQL server. We've been using SQLite for about a decade.
	- Remove support for PowerPC and i386 on macOS.
	- [#810](https://github.com/LMS-Community/slimserver/issues/810) \- Remove the 'deprecate' pragma vom CGI::Util to improve compatibility with newer Perl versions.

- Bug Fixes:

	- Allow seeking in mp4 files with samplerates > 65535 (32 bits) on some platforms (thanks philippe44 & ralphy)
	- Improve Deezer metadata lookup when adding albums/playlists through the CLI.
	- [(Audio::Scan) #9](https://github.com/andygrundman/Audio-Scan/issues/9) \- For some WavPack DSD file the song\_length\_ms is incorrect (thanks aeeq & ralphy!)
	- [(Audio::Scan) #12](https://github.com/andygrundman/Audio-Scan/pulls/12) \- ID3: Fix v2.4 extended header handling (thanks mw9 & ralphy!)
	- [#406](https://github.com/LMS-Community/slimserver/issues/406) \- Crossfading fails with very short tracks
	- [#410](https://github.com/LMS-Community/slimserver/issues/410) \- Rescan button for individual music folders does not work in Classic (and hence Material) skin.
	- [#473](https://github.com/LMS-Community/slimserver/issues/473) \- Broken playback functionality in Album/More
	- [#535](https://github.com/LMS-Community/slimserver/issues/535) \- some CLI commands duplicate comment tag info
	- [#547](https://github.com/LMS-Community/slimserver/issues/547) \- duplicate albums after adding tracks while renaming album
	- [#668](https://github.com/LMS-Community/slimserver/pull/668) \- Podcasts: Pre-caching image and more-info data can bring the server to a crawl #668 (thanks mw9!)
	- Fix image transformation if a cover requested using /current/cover is pointing to a local file.
	- [#699](https://github.com/LMS-Community/slimserver/issues/699) \- Improve resume behaviour (thanks philippe44, maniac103 & mw9
	- [#700](https://github.com/LMS-Community/slimserver/issues/700)/ [#718](https://github.com/LMS-Community/slimserver/pull/718) \- High CPU load during playback of certain radio streams (thanks philippe44!)
	- [#704](https://github.com/LMS-Community/slimserver/issues/704) \- changed artist names remain in database after quick rescan
	- [#705](https://github.com/LMS-Community/slimserver/issues/705) \- changing upper and lower case in file name results in double entries
	- [#746](https://github.com/LMS-Community/slimserver/pull/746) \- Windows 11: PreventStandby doesn't prevent standby any more
	- [#749](https://github.com/LMS-Community/slimserver/pull/749) \- fix mp4 streams where audio offset comes from STCO (thanks philippe44 && bpa!)
	- [#754](https://github.com/LMS-Community/slimserver/pull/754) \- improve reliability of "what's new" podcast search (thanks philippe44!)
	- [#767](https://github.com/LMS-Community/slimserver/pull/767) \- fix compatibility with standards compliant cometd libraries (thanks lynniemagoo!)
	- [#95](https://github.com/LMS-Community/slimserver-vendor/issues/95) \- update faad helper binaries to fix a crash when the decoder call fails (thanks ralphy!)
	- [#777](https://github.com/LMS-Community/slimserver/pull/777) \- When syncing with disconnected player through CLI, random player is synced
	- [#802](https://github.com/LMS-Community/slimserver/issues/802) \- Log is flodded with callback warnings "Can't call method "display" on an undefined value"
	- Prevent a server crash while re-building the fulltext search index with huge collections.
	- Don't show online only artists when a virtual library view tells us to do so.
	- Fix IO::Socket::SSL initialization in the scanner's sync http lookup code.
	- [#797](https://github.com/LMS-Community/slimserver/pull/797) \- Fix Power off/Power on behaviour - Player would resume playback of stale track when reconnecting, although nothing to be resumed.

## Version 8.2.1

- Server Changes:

- Platform Support:

	- Added Perl 5.34 modules for Linux x86\_64

- Bug Fixes:

	- [#646](https://github.com/LMS-Community/slimserver/pull/646) \- Fix streaming compatibility with SliMP3 (thanks philippe44!).
	- [#647](https://github.com/LMS-Community/slimserver/issues/647) \- Fix podcast "Play from last position" and skip back trackinfo item (thanks mw9 and philippe44!).
	- [#656](https://github.com/LMS-Community/slimserver/pull/656) \- Correct start time for streams with range offset (thanks philippe44!).
	- Fix resizing images with a dash in the name.
	- Define $::cachedir in the scanner, too, as many parts of the code rely on it.
	- [#760](https://github.com/LMS-Community/slimserver/issues/760) \- Fix various XSS possibilities in settings pages etc.

## Version 8.2.0 - 2021-08-03 (1ec16032b)

- [Upstream fixes from Logitech Media Server 8.1.x](#version-812)

- New Features:

	- Try to group online artists with local artists by ignoring slightly different spelling (eg. "The Beatles" vs. "Beatles", "Amy Macdonald" vs. "Amy MacDonald").
	- [#510](https://github.com/LMS-Community/slimserver/issues/510) \- Add (optional) "balanced" track shuffling method, which is less random, but hopefully more pleasing to the listener.
	- [#537](https://github.com/LMS-Community/slimserver/pull/537) \- Add audio option to combine channels to build a mono signal (whether player is synchronized or not).
	- [#538](https://github.com/LMS-Community/slimserver/pull/538) \- Add Balance setting for players which support it (thanks philippe44!).
	- [#621](https://github.com/LMS-Community/slimserver/pull/621) \- Add Search feature to the Podcasts plugin (thanks philippe44!).
	- [#630](https://github.com/LMS-Community/slimserver/pull/630) \- Add parsing of remote OPML list.
	- [#627](https://github.com/LMS-Community/slimserver/pull/627) \- Allow explodePlaylist to return an OPML list, not just an array or urls.
	- Enable basic track statistics (play count, last played, ratings) for online tracks imported into the library.
	- [#581](https://github.com/LMS-Community/slimserver/pull/581), [#591](https://github.com/LMS-Community/slimserver/pull/591) \- Create new player protocol to buffer http streams to disk or re-establish dropped connections to improve reliability (thanks philippe44!).

- Server Changes:

	- When an online scan doesn't return any track, but previously had some, do not remove tracks from library. The empty new list is likely due to a scan failure.
	- Try to improve backwards compatibility with eg. Erland's plugins, which sometimes struggle with the remote tracks.
	- [#411](https://github.com/LMS-Community/slimserver/issues/411) \- Transcoder conversion rules: Support resampling for Ogg/Flac streams (thanks bpa/mw9!)
	- [#598](https://github.com/LMS-Community/slimserver/pull/598) \- Shuffle tracks added with "playlist loadtracks" and certain search filters (thanks philchillbill!)
	- Added hook for 3rd party plugins to tell DSTM not to kick in.

- Platform Support:

	- [#18](https://github.com/LMS-Community/slimserver-platforms/pull/18) \- Add a systemd service file for Debian based systems (thanks mw9 & tomscytale).
	- [#22](https://github.com/LMS-Community/slimserver-platforms/pull/22) \- Add systemd service configuration for RPM based systems (thanks JohanSaaw!)
	- [#25](https://github.com/LMS-Community/slimserver-platforms/pull/25) \- Add weak dependency on perl IO::Socket:SSL in RPM (thanks JohanSaaw!)
	- [#526](https://github.com/LMS-Community/slimserver/pull/526) \- Add Perl 5.32 and 5.30 support for Linux aarch64 platform. (thanks clivem!)
	- Remove Font::FreeType from Linux distributions. It's easy enough to install it using the system's package manager, and it would conflict on system where we don't provide the binary.

- Bug Fixes:

	- [#554](https://github.com/LMS-Community/slimserver/issues/554) \- Long current playlist disappears from UI during wipe and rescan.
	- [#601](https://github.com/LMS-Community/slimserver/issues/601) \- "icon" for URL="file://..." entries does not work in favorites.ompl.
	- [#629](https://github.com/LMS-Community/slimserver/issues/629) \- Set SO\_KEEPALIVE for cli socket so they auto-close when peer disappears.
	- [#632](https://github.com/LMS-Community/slimserver/issues/632) \- Keep shall in foreground when startTime is required and bitrate is missing.
	- [#617](https://github.com/LMS-Community/slimserver/issues/617) \- Handle volatile redirected url, retry from original one if failed after resume.
	- [#612](https://github.com/LMS-Community/slimserver/issues/612) \- Ask PH if \_currentHandler shall be rewritten (HTTP->HTTPS upgrade).

- Other:

	- [#528](https://github.com/LMS-Community/slimserver/issues/528) \- On Unix-like platforms, we now ensure that plugins are installed in such a way that none of their files are writable by users other than the user running LMS, even if theyʼre stored that way in the plugin ZIP file.
	- No longer include the firmware images for ip3k based players (Classic, Boom, Receiver, Transporter) with the installation packages. Logitech Media Server can download them when needed. But after about a decade without updates it's unlikely anybody would still have to update anyway.

## Version 8.1.2

- Server Changes:

	- [#522](https://github.com/LMS-Community/slimserver/pull/522) \- add new --advertiseaddr startup parameter to tell LMS what user facing IP address to use (in case of NATed setups, like with load balancers or Kubernetes etc.) - thanks fuero!
	- Don't sync favorites from mysqueezebox.com when prefs syncing is disabled.

- Bug Fixes:

	- Don't poll the Deezer library if the user doesn't have a premium subscription.
	- Open App Gallery item in new window/tab - fix some regexes where we'd only accept http instead of https.
	- Make sure we get the mysqueezebox.com based app menu even for players which are not registered there.
	- [#508](https://github.com/LMS-Community/slimserver/pull/508) \- Don't include the port when using default ports in host header for http requests.
	- [#521](https://github.com/LMS-Community/slimserver/pull/521) \- Fix http redirection on HTTPS protocol handlers (thanks philippe44!)
	- [#523](https://github.com/LMS-Community/slimserver/pull/523) \- Fix http redirection when redirect URL is missing the protocol (thanks philippe44!)
	- [#531](https://github.com/LMS-Community/slimserver/pull/531) \- Player's library view setting and Random Mix preference conflict with each other.
	- [#536](https://github.com/LMS-Community/slimserver/pull/536) \- When an album list is filtered by contributor role, the contributor's name sometimes isn't shown with the album.
	- [#545](https://github.com/LMS-Community/slimserver/pull/545) \- Under certain circumstances 3rd party plugins could be hidden on non-Squeezeplay based players.
	- [#559](https://github.com/LMS-Community/slimserver/pull/559) \- Deleting favourite via CLI using URL deletes others (thanks CDrummond!)
	- [#585](https://github.com/LMS-Community/slimserver/pull/585) \- mp4 parser for trailing header must keep original request fields (thanks philippe44!)
	- [#593](https://github.com/LMS-Community/slimserver/pull/593) \- Handle redirect with processors (eg. mp4 => aac) (thanks philippe44!)

## Version 8.1.1 - 2021-01-14 (dd356a423)

- Server Changes:

	- [#489](https://github.com/LMS-Community/slimserver/issues/489) \- Enable Deezer flac seeking for ip3k players.
	- [#490](https://github.com/LMS-Community/slimserver/issues/490) \- Enable "Defeat Touch To Play" for all players.

- Platform Support:

	- Restore Perl 5.18 support in the x86\_64 .deb file.

- Bug Fixes:

	- Fix Ogg Opus on Windows.
	- Fix advanced genre replacement in Online Music Library Integration plugin.
	- [#485](https://github.com/LMS-Community/slimserver/issues/485) \- HTTP range request is last byte not size.
	- [#486](https://github.com/LMS-Community/slimserver/issues/486) \- When using internal transcoding only, the container format must be set.
	- [#488](https://github.com/LMS-Community/slimserver/issues/488) \- When resampling FLAC, add targeted $RESAMPLE$,not only the source sample rate.
	- [#501](https://github.com/LMS-Community/slimserver/issues/501) \- Fix logging in Deezer and TIDAL importers.
	- [#506](https://github.com/LMS-Community/slimserver/issues/506) \- Fix Napster streaming.

## Version 8.1.0 - 2020-12-23 (effae8494)

- [Upstream fixes from Logitech Media Server 8.0.x](#version-801)

- New Features:

	- Deezer HiFI! Stream lossless music from Deezer if you have a Deezer HiFi subscription.
	- Add support for lyrics stored in the UNSYNCEDLYRICS tag in FLAC files.
	- Optionally allow installation of plugins which were targeted at Logitech Media Server 7.\*.

- Server Changes:

	- Improve transcoding framework to allow protocol handlers to force transcoding (eg. TIDAL)
	- Increase the default maximum playlist length for systems with more memory.

- Platform Support:

	- Improved compatibility with macOS 11 Big Sur and Apple Silicon (M1 CPU).
	- Remove (buggy) support for Perl 5.8 - we broke compatibility already a while back.
	- Remove support for ReadyNAS - we broke compatibility already a while back (using Perl 5.8).

- Bug Fixes:

	- [#475](https://github.com/LMS-Community/slimserver/issues/475) \- Socket leaks when pipeline is used.

## Version 8.0.1

- Bug Fixes:

	- [#437](https://github.com/LMS-Community/slimserver/issues/437) \- New Music doesn't respect the library\_id parameter.
	- [#459](https://github.com/LMS-Community/slimserver/issues/459) \- Library items like artists (db:contributor.name=...) favorites don't return the URL in the CLI.
	- [#460](https://github.com/LMS-Community/slimserver/issues/460) \- Retrieving a genre by ID using the CLI is not possible.
	- [PR #474](https://github.com/LMS-Community/slimserver/pull/474) \- Ignore non-compliant CUE sheets (thanks oleg-kuh!)
	- Make sure we only poll music services for changes in the library which we actually have configured.
	- Fix album separation of multi disc sets from online services when grouping is disabled.
	- Don't offer direct firmware download if players can't handle it lack of https support.

## Version 8.0.0 - 2020-11-20 (e0eee9c29)

- [Upstream fixes from Logitech Media Server 7.9.3](#version-793)

- New Features:

	- Online music library integration: list your collection of albums vetted in your favorite streaming service as part of your "My Music" collection.
	- Improved support for Audio Books: automatically create library views and browse modes dealing with Audio Books and Authors.
	- Paste TIDAL or Deezer weblinks in to the Tune In field to play albums/playlists/tracks (thanks [mavit](https://github.com/LMS-Community/slimserver/pull/360)!)
	- Keep track of recently played podcasts (thanks [philippe44](https://github.com/LMS-Community/slimserver/pull/384)!)

- Server Changes:

	- [PR #367](https://github.com/LMS-Community/slimserver/pull/367) \- Improved parsing of HTTP header allows for new features (eg. AAC transcoding) and fixes some issues with streaming remote files. Thanks a lot philippe44!
	- [PR #305](https://github.com/LMS-Community/slimserver/pull/305) \- use ORIGINALYEAR in FLAC files to override YEAR (thanks jcbodnar!)
	- [PR #267](https://github.com/LMS-Community/slimserver/pull/267) \- HTTPS certificates are now validated when LMS acts as a client. HTTPS connections to plugin repositories are no-longer retried over HTTP when they fail. The old insecure behaviour can optionally be re-enabled, although, instead, we recommend working out why HTTPS is broken in your environment and fixing that if possible.
	- [PR #308](https://github.com/LMS-Community/slimserver/pull/308) \- Update faad binaries to fix several CVE-2017 security issues (thanks ralphy!)
	- [PR #324](https://github.com/LMS-Community/slimserver/pull/324) \- Implement documented, but non-functional search in "favorites" query.
	- [PR #346](https://github.com/LMS-Community/slimserver/pull/346) \- Update Audio::Scan on Windows to 1.02 (thanks ralphy!)
	- [PR #355](https://github.com/LMS-Community/slimserver/pull/355) \- Improved metadata handling in the xPL plugin (thanks keynet!)
	- [PR #429](https://github.com/LMS-Community/slimserver/pull/429) \- Hide library folders from scanning with a sentinel file (thanks sciurius!)
	- [PR #434](https://github.com/LMS-Community/slimserver/pull/434) \- Support for multiple FILE commands in CUE sheets (thanks oleg-kuh!)
	- [PR #448](https://github.com/LMS-Community/slimserver/pull/448) \- Add support for TIDAL over HTTPS and seeking (thanks philippe44!)
	- Improved Dutch translation (thanks blackfiction!)
	- Read Conductor tag from m4a etc. files.
	- Persist some web browser side preferences like artwork mode, expanded menus etc. on the server. Safari would regularly "forget" them.
	- Improve cache purging to reduce startup time and the risk of locking up other initialization tasks.
	- Updated LWP module and dependencies to improve compatibility with newer Perl versions.
	- Support import of DSD in WavPack files (requires additional DSDPlay 3rd party plugin).
	- Add 'wav wav' rule which keeps headers.
	- Add 'aif pcm' rule and change 'aif aif' rule to keep header except for "legacy" SB.
	- Add 'H' tag in convert.conf to strip wav/aiff headers.

- Platform Support:

	- Logitech Media Server now is available as a Docker image [lmscommunity/logitechmediaserver](https://hub.docker.com/r/lmscommunity/logitechmediaserver) (thanks snoopy86, terual, pascalberger!).
	- Added Perl 5.32 modules for Linux x86\_64

- Bug Fixes:

	- [#277](https://github.com/LMS-Community/slimserver/issues/277) \- add new flac binaries to fix seeking within remote flac streams in some locales (thanks ralphy!).
	- [#313](https://github.com/LMS-Community/slimserver/issues/313) \- Advanced Search for albums returns emtpy "Song Info ()" link.
	- [#327](https://github.com/LMS-Community/slimserver/issues/327) \- "playlist loadalbum" command is case sensitive and otherwise fragile.
	- [#366](https://github.com/LMS-Community/slimserver/issues/366) \- Fix gapless PCM Playback on Squeezebox1 (thanks michaldie!).
	- [#388](https://github.com/LMS-Community/slimserver/issues/388) \- Fix sorting of index bar in the web UI.
	- Always strip BOM from M3U files, not only if the first line is a comment.
	- Support wav/aif remote streams (direct and proxied).
	- Check that destination (not source) codec is supported in direct streaming.
	- Pass all seed tracks, using one API call, to MusicIP mix when used for "Dont Stop The Music".
	- Re-build Fulltext Search Index for modified playlists after they've been saved.

- Other:

	- Updated translations: Swedish (thanks Johan!)

