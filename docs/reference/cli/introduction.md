---
layout: default
title: CLI - Introduction
---

# Introduction

The Lyrion Music Server provides a command-line interface to the players via TCP/IP. After starting the server, commands and queries may be sent by connecting to a specific TCP/IP port. The server will reply echoing the request (for commands) or by returning the requested data (for queries). By default, the server will listen for connections on TCP/IP port 9090. This format is designed for ease of integration into AMX, Crestron and other automation systems.

See [Using the command-line interface](using-the-cli.md) for details.


## Supported Commands

The available commands and queries are listed below, grouped by their scope:

* [General](general.md): general management of the Command Line Interface and of the server.
* [Players](players.md): management of players.
* [Database](database.md): mangement of the music database.
* [Playlist](playlist.md): management of the playlist of each player.
* [Coumpound Queries](compoundqueries.md): queries to get most of the information about the server or a player in one convenient query, that can be updated by the server automatically.
* [Notifications](notifications.md): internal server commands echoed to the CLI by using the "listen" or "subscribe" commands.
* [Alarms](alarms.md): management of alarms.

## Changelog

### Migration of the CLI documentation (April 2024)

* The CLI documentation was previously included as part of the embedded help in the LMS server distribution, accessible as a single (big) HTML page on a url like `LMS-SERVER:LMS-PORT/html/docs/cli-api.html`. 
* The documentation here is based on `cli-api.html` from LMS Server v8.5. It is essentially unchanged, beyond dividing it into separate pages, formatting, plus a few corrections.
* Original sections "Deprecated", and "Plugins" have not been migrated.
* Future LMS server distributions (from v9 onwards) will no longer have the CLI documentation in the embedded help.

### Changes starting from Squeezebox Server 8.5

* Removed all calls and code related to MySqueezebox.com related systems.
* Added "alarmData" parameter to the "status" query to report information about the upcoming alarm.

### Changes starting from Squeezebox Server 8.4

* Added support for release types and roles to albums, and titles queries.
* Added support for a list of album IDs while fetching albums.

### Changes starting from Squeezebox Server 8.2

* Added query to figure out whether fulltext search is enabled or not (fulltextsearch).

### Changes starting from Squeezebox Server 8.0

* Added support for external IDs: when libraries from online music services are imported, artists, albums, and titles store the external, service specific ID in the 'extid' field. Artists can have multiple, comma separated values, as one artist can be found on multiple services.

### Changes starting from Squeezebox Server 7.9

* Added support for virtual library views. artists, albums, genres, titles etc. queries now accept a library_id parameter to filter the results by virtual libraries. libraries returns a list of libraries with their name and IDs.
* Added support for new "random" sort order for the albums query.
* Added support for these queries to filter by the contributor's role (role_id).

### Changes starting from Squeezebox Server 7.7

* Extended "rescan" with optional singledir parameter.
* Added "info total duration ?" query to return the total number of seconds for the library.
* Added DD parameter to the "status" query to report total playtime of the current queue.

### Changes starting from Squeezebox Server 7.6

* Added tag 'M' for songinfo to return track musicmagic_mixable value.
* Added tag 'c' for songinfo to return the track's coverid value, used for artwork URLs. If you were using the track's ID directly in artwork URLs, you should switch to using the coverid value.
* Added "pragma" command for changing SQLite behavior.
* Added artist_id tagged parameter to artists.
* Added album_id tagged parameter to albums.
* Added sort order 'albumtrack' for titles to return the tracks in the order album-title, track-number.
* Added tag 'X' for albums to return the album's replay-gain value.
* Added tag 'S' for albums to return the album's artist_id.
* Added 'play_index' tagged parameter to playlistcontrol.
* In extended queries, return all possible items if the <itemsPerResponse> parameter is omitted.
* Add the 'u' tag to the "musicfolder" query
* Added track_id tagged parameter to titles.
* Added genre_id tagged parameter to genres.
* Added year and hasAlbums tagged parameters to years.
* Added return_top tagged parameter to musicfolder.
* Removed the charset tagged parameter from all commands that supported it.
* Added the 'Z' tag to albums, artists and genres queries. It generates a indexList array or arrays in the result.

### Changes starting from Squeezebox Server 7.5.1

* Added "playlist preview" command.
* Extended "playlist resume" with optional noplay and wipePlaylist tagged params.
* Extended "playlist save" with optional silent tagged param, which will suppress any showBriefly popup on squeezeplay players.

### Changes starting from Squeezebox Server 7.4

* The music_services command is now apps.
* Added "pause" & "stop" subtypes to "playlist" notifications.
* Added "setsncredentials" command.
* Added "logging" command.

### Changes starting from Squeezebox Server 7.3

* Added 'icon' tag to radios and music_services response.
* Added "syncgroups" query to get a list of sync groups and their members.
* Added "favorites exists" query to check whether an item exists in favorites.

### Changes starting from Squeezebox Server 7.2

The following syntax changes apply to the CLI in Squeezebox Server 7.2. These changes may impact CLI clients.

* The "alarm" and "alarms" command and query have been modified to match the improved alarm functionality. Most important change is the switch back to Sun=0 to Sat=6 days, instead of 0-7, where 0 meant "everyday" and Sun=7.
* The following changes or new commands & queries are available starting with Squeezebox Server 7.2. These changes should not have any impact on existing clients:

* New notification mechanism for alarms: "alarm <sound|end|snooze|snooze_end> <id>".
* New query to get localized strings: "getstring <STRINGTOKEN1[,STRINGTOKEN2...]>".

### Changes starting from Squeezebox Server 7.0

The following syntax changes apply to the CLI in Squeezebox Server 7.0. These changes may impact CLI clients.

* Completely modified the Favorites plugin support. It is now based on XMLBrowser, like most of the internet radios, and documented in the Plugins section of this document.
* Completely modified live365 support. It is now based on XMLBrowser, like all internet radios.
* Deprecated the tag "year_id" in favour of "year" in the "playlistcontrol" command.
* Changed how the "status" query behaves if the player one is subscribed to disappears.
* Updated the "status" query to return the time stamp of the last change to the current player playlist.
* Updated the "playlist newsong" notification to return the song title and playlist index.
* Updated the "pref" and "playerpref" commands to support the namespaces for preferences.
* Changed tags in queries "status", "titles", "playlists tracks" and "songinfo" for artist(s)/contributor(s) (band, composer, conductor, trackartist, etc) and genre(s). Multiple items may now be returned.
* New notification mechanism for preference changes: "prefset".
* The following changes or new commands & queries are available starting with Squeezebox Server 7.0. These changes should not have any impact on existing clients:

* Added the "years" query, to enable Browse by Year functionality.
* Added the "musicfolder" query, to enable Browse Music Folder functionality.
* Added the "readdirectory" query, to browse file systems from the server's point of view (local & network shares)
* Added the "rescanprogress" query, to report details on scanning progress.
* Added the "abortscan" command, to stop a running scan.
* Added the "serverstatus" query, to return compound server status in a single query.
* Added the "playlists new" command to create a stored playlist.
* Added the "prefs" tag to the "players" query, to enable returning the given preference values along with each player.
* Added the "canpoweroff", "isplayer" and "uuid" tags to the "players", "player" and "serverstatus" queries. to enable returning the given preference values along with each player.
* Added the "pref validate" and "playerpref validate" queries to validate preferences without setting them.
* Added a tag to return the artist from the "albums" query.
* Added a tag to return if the item is audio from the "XML based" queries.
* Added a tag to allow sorting the results of the "radios" query.
* Added the "name" query/command to get/change the player name.
* Added the "irenable" query/command to enable/disable IR processing for a player.
* Added the "displaystatus" query which allows subscription to display update messages.
* Updated queries "status", "titles", "playlists tracks" and "songinfo" to support a new tag J to return the artwork_track_id (as returned by the "albums"). This enables clients to cache one image for all songs of the same album.
* Updated queries "status", "titles", "playlists tracks" and "songinfo" to support new tags for previously missing information like sample rate/size, rating, etc.
* Order of tracks passed to "playlistcontrol" command is maintained.
* Command "playlistcontrol" now accepts also a folder_id as returned by the new "musicfolder" query.
* Slightly reorganised this document to introduce a "Compound queries" section to document queries "serverstatus" and "status".