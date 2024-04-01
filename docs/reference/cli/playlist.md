---
layout: default
title: CLI - Playlists commands and queries
---

<style>
    td code {
        word-break: normal !important;
    }
</style>

# Playlist commands and queries

***
## play

`<playerid> play <fadeInSecs>`

The `play` command allows to start playing the current playlist. The `fadeInSecs` parameter may be passed to specify a fade-in period.

Example:
```
Request: "04:20:00:12:23:45 play<LF>"
Response: "04:20:00:12:23:45 play<LF>"
```
***
## stop

`<playerid> stop`

The `stop` command allows to stop playing the current playlist.

Example:
```
Request: "04:20:00:12:23:45 stop<LF>"
Response: "04:20:00:12:23:45 stop<LF>"
```
***
## pause

`<playerid> pause <0|1|> <fadeInSecs> <suppressShowBriefly>`

You may use `pause 1` to force the player to pause, `pause 0` to force the player to unpause and `pause` to toggle the pause state. The `fadeInSecs` parameter may be passed to specify a fade-in period when unpausing.

The `suppressShowBriefly` parameter may be passed to specify **not** to show a pause icon on squeezeplay-based devices (as is the case with hitting 'power off' on the SBController, which pauses play but should not display an icon, see bug 13521). The popup on squeezeplay-based devices which shows the pause icon is referred  to as the `showBriefly` popup.

Example
```
Request: "04:20:00:12:23:45 pause<LF>"
Response: "04:20:00:12:23:45 pause<LF>"
```

***
## mode

`<playerid> mode ?`

The `mode` command allows to query the player state and returns one of `play`, `stop` or `pause`.

If the player is off, `mode ?` returned value is undefined.

Example:
```
Request: "04:20:00:12:23:45 mode ?<LF>"
Response: "04:20:00:12:23:45 mode stop<LF>"
```
***
## time

`<playerid> time <number|-number|+number|?>`

The `time` command allows you to query the current number of seconds that the current song has been playing by passing in a `?`. You may jump to a particular position in a song by specifying a number of seconds to seek to. You may also jump to a relative position within a song by putting an explicit `-` or `+` character before a number of seconds you would like to seek.

Examples:
```
Request: "04:20:00:12:23:45 time ?<LF>"
Response: "04:20:00:12:23:45 time 12.55<LF>"

Request: "04:20:00:12:23:45 time 5<LF>"
Response: "04:20:00:12:23:45 time 5<LF>"

Request: "04:20:00:12:23:45 time -5<LF>"
Response: "04:20:00:12:23:45 time -5<LF>"
```

***
## Querying the Song Playing

The `remote`, `current_title`, `genre`, `artist`, `album`, `title` `duration`, and `path` commands allow for querying information about the song currently playing.

See also a similar set of queries for a Song on a given playlist at [Querying a Song on a Playlist](#querying-a-song-on-a-playlist) (tho that set of queries does not have a `current_title` query).

### current_title
`<playerid> current_title ?`

`current_title` returns the current title for remote streams or the song title as formatted for the player.

```
Request: "04:20:00:12:23:45 current_title ?<LF>"
Response: "04:20:00:12:23:45 current_title 1-Voulez%20vous%20(ABBA)<LF>"
```

### remote
`<playerid> remote ?'

The `remote` command allows for querying information about the song currently playing.
Command `remote` returns `1` if the current song is a remote stream.

```
Request: "04:20:00:12:23:45 remote ?<LF>"
Response: "04:20:00:12:23:45 remote 0<LF>"
```

### genre
`<playerid> genre ?`

Example
```
Request: "04:20:00:12:23:45 genre ?<LF>"
Response: "04:20:00:12:23:45 genre Rock<LF>"
```
### artist
`<playerid> artist ?`

Example
```
Request: "04:20:00:12:23:45 artist ?<LF>"
Response: "04:20:00:12:23:45 artist Abba<LF>"
```
### album
`<playerid> album ?`

Example
```
Request: "04:20:00:12:23:45 album ?<LF>"
Response: "04:20:00:12:23:45 album Greatest%20Hits<LF>"
```
### title
`<playerid> title ?`

Example
```
Request: "04:20:00:12:23:45 title ?<LF>"
Response: "04:20:00:12:23:45 title Voulez%20vous<LF>"

```
### duration
`<playerid> duration ?`

Example
```
Request: "04:20:00:12:23:45 duration ?<LF>"
Response: "04:20:00:12:23:45 duration 103.2<LF>"

```
### path
`<playerid> path ?`

Example
```
Request: "04:20:00:12:23:45 path ?<LF>"
Response: "04:20:00:12:23:45 path pathtofile<LF>"
```

***
## playlist play

`<playerid> playlist play <item> <title> <fadeInSecs>`

The `playlist play` command puts the specified song URL, playlist or directory contents into the current playlist and plays starting at the first item. Any songs previously in the playlist are discarded. An optional title value may be passed to set a title. This can be useful for remote URLs. The `fadeInSecs` parameter may be passed to specify a fade-in period.

Examples:
```
Request: "04:20:00:12:23:45 playlist play /music/abba/01_Voulez_Vous.mp3<LF>"
Response: "04:20:00:12:23:45 playlist play /music/abba/01_Voulez_Vous.mp3<LF>"

Request: "04:20:00:12:23:45 playlist play http://someserver/02_Sledgehammer.flac Peter%20Gabriel%20-%20Sledgehammer<LF>"
Response: "04:20:00:12:23:45 playlist play http://someserver/02_Sledgehammer.flac Peter%20Gabriel%20-%20Sledgehammer<LF>"
```
***
## playlist add
`<playerid> playlist add <item> <title>`

The `playlist add` command adds the specified song URL, playlist or directory contents to the end of the current playlist. Songs currently playing or already on the playlist are not affected. An optional title value may be passed to set a title. This can be useful for remote URLs.

Examples:
```
Request: "04:20:00:12:23:45 playlist add /music/abba/01_Voulez_Vous.mp3<LF>"
Response: "04:20:00:12:23:45 playlist add /music/abba/01_Voulez_Vous.mp3<LF>"

Request: "04:20:00:12:23:45 playlist add /playlists/abba.m3u<LF>"
Response: "04:20:00:12:23:45 playlist add /playlists/abba.m3u<LF>"
```

***
## playlist insert
`<playerid> playlist insert <item> <title>`

The `playlist insert` command inserts the specified song URL, playlist or directory contents to be played immediately after the current song in the current playlist. Any songs currently playing or already on the playlist are not affected. An optional title value may be passed to set a title. This can be useful for remote URLs.

Examples:
```
Request: "04:20:00:12:23:45 playlist insert /music/abba/01_Voulez_Vous.mp3<LF>"
Response: "04:20:00:12:23:45 playlist insert /music/abba/01_Voulez_Vous.mp3<LF>"

Request: "04:20:00:12:23:45 playlist insert /playlists/abba.m3u<LF>"
Response: "04:20:00:12:23:45 playlist insert /playlists/abba.m3u<LF>"
```

***
## playlist deleteitem

`<playerid> playlist deleteitem <item>`

The `playlist deleteitem` command removes the specified song URL, playlist or directory contents from the current playlist.

Examples:
```
Request: "04:20:00:12:23:45 playlist deleteitem /music/abba/01_Voulez_Vous.mp3<LF>"
Response: "04:20:00:12:23:45 playlist deleteitem /music/abba/01_Voulez_Vous.mp3<LF>"
```

***
## playlist move
`<playerid> playlist move <fromindex> <toindex>`

The `playlist move` command moves the song at the specified index to a new index in the playlist. An offset of zero is the first song in the playlist.

Examples:
```
Request: "04:20:00:12:23:45 playlist move 0 5<LF>"
Response: "04:20:00:12:23:45 playlist move 0 5<LF>"
```

***
## playlist delete

`<playerid> playlist delete <songindex>`

The `playlist delete` command deletes the song at the specified index from the current playlist.

Examples:
```
Request: "04:20:00:12:23:45 playlist delete 5<LF>"
Response: "04:20:00:12:23:45 playlist delete 5<LF>"
```

***
## playlist preview
`<playerid> playlist preview <taggedParameters>`

When called **without** a cmd param of `stop`, replace the current playlist with the playlist specified by url, but save the current playlist to tempplaylist_<playerid>.m3u for later retrieval.

When called **with** the cmd param of `stop`, stops the currently playing playlist and loads (if possible) the previous playlist. Restored playlist jumps to beginning of CURTRACK when present in m3u file, and does not autoplay restored playlist.

Examples:
```
Request: "04:20:00:12:23:45 playlist preview url:db:album.titlesearch=A%20FEAST%20OF%20WIRE title:A%20Feast%20Of%20Wire<LF>"
Response: "04:20:00:12:23:45 playlist preview url:db:album.titlesearch=A%20FEAST%20OF%20WIRE title:A%20Feast%20Of%20Wire<LF>"

Request: "04:20:00:12:23:45 playlist preview cmd:stop<LF>"
Response: "04:20:00:12:23:45 playlist preview cmd:stop<LF>"
```

***
## playlist resume
`<playerid> playlist resume <playlist> <taggedParameters>`

Replace the current playlist with the playlist specified by `<playlist>` (p2), starting at the song that was playing when the file was saved. (Resuming works only with M3U files saved with the `playlist save` command below.)

Shortcut: use a bare playlist name (without leading directories or trailing .m3u suffix) to load a playlist in the saved playlists folder.

**Optional tagged parameters:** `noplay` which when non-zero will not auto-start the track, and `wipePlaylist`, which will destroy the saved playlist from both the filesystem and from the DB (these tagged params are typically used for resuming a temporarily cached playlist, e.g. after exiting alarm sound preview on squeezeplay devices).

Examples:
```
Request: "04:20:00:12:23:45 playlist resume abba<LF>"
Response: "04:20:00:12:23:45 playlist resume abba<LF>"
```

***
## playlist save
`<playerid> playlist save <filename> <taggedParameters>`

Saves a playlist file in the saved playlists directory. Accepts a playlist filename (without .m3u suffix) and saves in the top level of the playlists directory.

**Optional tagged parameter:**
 `silent` When non-zero, suppresses any `showBriefly` displayed.

Examples:
```
Request: "04:20:00:12:23:45 playlist save abba<LF>"
Response: "04:20:00:12:23:45 playlist save abba<LF>"
```

***
## playlist loadalbum

`<playerid> playlist loadalbum <genre> <artist> <album>`

The `playlist loadalbum` command puts songs matching the specified genre artist and album criteria on the playlist. Songs previously in the playlist are discarded.

Examples:
```
Request: "04:20:00:12:23:45 playlist loadalbum Rock Abba *<LF>"
Response: "04:20:00:12:23:45 playlist loadalbum Rock Abba *<LF>"
```

***
## playlist addalbum
`<playerid> playlist addalbum <genre> <artist> <album>`

The `playlist addalbum` command appends all songs matching the specified criteria onto the end of the playlist. Songs currently playing or already on the playlist are not affected.

Examples:
```
Request: "04:20:00:12:23:45 playlist addalbum Rock Abba *<LF>"
Response: "04:20:00:12:23:45 playlist addalbum Rock Abba *<LF>"
```

***
## playlist loadtracks
`<playerid> playlist loadtracks <searchparam>`

The `playlist loadtracks` command puts tracks matching the specified query on the playlist. Songs previously in the playlist are discarded. Note: you must provide a particular form to the searchparam (see examples)

Examples:
```
Request: "04:20:00:12:23:45 playlist loadtracks track.titlesearch=purple <LF>"
Response: "04:20:00:12:23:45 playlist loadtracks track.titleseach=purple <LF>"

Request: "04:20:00:12:23:45 playlist loadtracks album.titlesearch=3121 <LF>"
Response: "04:20:00:12:23:45 playlist loadtracks album.titlesearch=3121 <LF>"

Request: "04:20:00:12:23:45 playlist loadtracks contributor.namesearch=prince <LF>"
Response: "04:20:00:12:23:45 playlist loadtracks contributor.namesearch=prince <LF>"
```

***
## playlist addtracks

`<playerid> playlist addtracks <searchparam>`

The `playlist addtracks` command appends all songs matching the specified criteria onto the end of the playlist. Songs currently playing or already on the playlist are not affected.

Note: you must provide a particular form to the searchparam (see examples)

Examples:
```
Request: "04:20:00:12:23:45 playlist addtracks track.titlesearch=purple <LF>"
Response: "04:20:00:12:23:45 playlist addtracks track.titleseach=purple <LF>"

Request: "04:20:00:12:23:45 playlist addtracks album.titlesearch=3121 <LF>"
Response: "04:20:00:12:23:45 playlist addtracks album.titlesearch=3121 <LF>"

Request: "04:20:00:12:23:45 playlist addtracks contributor.namesearch=prince <LF>"
Response: "04:20:00:12:23:45 playlist addtracks contributor.namesearch=prince <LF>"
```

***
## playlist insertalbum

`<playerid> playlist insertalbum <genre> <artist> <album>`

The `playlist insertalbum` command inserts all songs matching the specified criteria at the top of the playlist. Songs already on the playlist are not affected.

Examples:
```
Request: "04:20:00:12:23:45 playlist addalbum Rock Abba *<LF>"
Response: "04:20:00:12:23:45 playlist addalbum Rock Abba *<LF>"
```

***
## playlist deletealbum

`<playerid> playlist deletealbum <genre> <artist> <album>`

The `playlist deletealbum` command removes songs matching the specified genre artist and album criteria from the playlist.

Examples:
```
Request: "04:20:00:12:23:45 playlist deletealbum Rock Abba *<LF>"
Response: "04:20:00:12:23:45 playlist deletealbum Rock Abba *<LF>"
```

***
## playlist clear

`<playerid> playlist clear`

The `playlist clear` command removes any song that is on the playlist. The player is stopped.

Examples:
```
Request: "04:20:00:12:23:45 playlist clear<LF>"
Response: "04:20:00:12:23:45 playlist clear<LF>"
```

***
## playlist zap

`<playerid> playlist zap <songindex>`

The `playlist zap` command adds the song at index songindex into the zapped song playlist.

Examples:
```
Request: "04:20:00:12:23:45 playlist zap 3<LF>"
Response: "04:20:00:12:23:45 playlist zap 3<LF>"
```

***
## playlist name

`<playerid> playlist name ?`

The `playlist name` command returns the name of the saved playlist last loaded into the Now Playing playlist, if any.

Examples:
```
Request: "04:20:00:12:23:45 playlist name ?<LF>"
Response: "04:20:00:12:23:45 playlist name Jazz%20Favorites <LF>"
```

***
## playlist url

`<playerid> playlist url ?`

The `playlist url` command returns the URL of the saved playlist last loaded into the Now Playing playlist, if any.

Examples:
```
Request: "04:20:00:12:23:45 playlist url ?<LF>"
Response: "04:20:00:12:23:45 playlist url file:///Users/dean/Music/testmusic/Zapped%20Songs.m3u<LF>"
```

***
## playlist modified

`<playerid> playlist modified ?`

The `playlist modified` returns the modification state of the saved playlist last loaded into the Now Playing playlist, if any. If `1`, the playlist has been modified since it was loaded.

Examples:
```
Request: "04:20:00:12:23:45 playlist modified ?<LF>"
Response: "04:20:00:12:23:45 playlist modified 0<LF>"
```

***
## playlist playslistsinfo

`<playerid> playlist playlistsinfo <taggedParameters>`

The `playlist playlistsinfo` query returns information on the saved playlist last loaded into the Now Playing playlist, if any.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `id` | Playlist id. |
| `name` | Playlist name. Equivalent to `playlist name ?`. |
| `modified` | Modification state of the saved playlist. Equivalent to `playlist modified ?`. |
| `url` | Playlist url. Equivalent to `playlist url ?`. |

**Returned tagged parameters:**

| Tag | Description |
|---|---|
| `id` | Playlist id. |
| `name` | Playlist name. Equivalent to `playlist name ?`. |
| `modified` | Modification state of the saved playlist. Equivalent to `playlist modified ?`. |
| `url` | Playlist url. Equivalent to `playlist url ?`. |

Example:
```
Request: "a5:41:d2:cd:cd:05 playlist playlistsinfo <LF>"
Response: "a5:41:d2:cd:cd:05 playlist playlistsinfo id:267 name:A98 modified:0 url:file://Volumes/... <LF>"
```

***
## playlist index

`<playerid> playlist index <index|+index|-index|?> <fadeInSecs>`

The `playlist index` command sets or queries the song that is currently playing by index. When setting, a zero-based value may be used to indicate which song to play.

An explicitly positive or negative number may be used to jump to a song relative to the currently playing song. The index can only be set if the playlist is not empty.

If an index parameter is set then `fadeInSecs` may be passed to specify a fade-in period. The value of the current song index may be obtained by passing in `?` as a parameter.

Examples:
```
Request: "04:20:00:12:23:45 playlist index +1<LF>"
Response: "04:20:00:12:23:45 playlist index +1<LF>"

Request: "04:20:00:12:23:45 playlist index 5<LF>"
Response: "04:20:00:12:23:45 playlist index 5<LF>"

Request: "04:20:00:12:23:45 playlist index ?<LF>"
Response: "04:20:00:12:23:45 playlist index 5<LF>"
```

***
## Querying a Song on a Playlist

The `playlist genre`, `playlist artist`, `playlist album`, `playlist title`, `playlist path`, `playlist remote` and `playlist duration` queries return the requested information for a given song at an index position in the current playlist.

See also the commands under [Querying the Song Playing](#querying-the-song-playing) which provided similar information for the song currently playing (plus an additional query, `current_title`)

### playlist remote
<playerid> playlist remote <index> ?
`playlist remote` returns 1 if the `song` is a remote stream.

Example
```
Request: "04:20:00:12:23:45 playlist remote 3 ?<LF>"
Response: "04:20:00:12:23:45 playlist remote 3 0<LF>"
```

### playlist genre
`<playerid> playlist genre <index> ?`

Example
```
Request: "04:20:00:12:23:45 playlist genre 3 ?<LF>"
Response: "04:20:00:12:23:45 playlist genre 3 Rock<LF>"
```

### playlist artist
`<playerid> playlist artist <index> ?`

Example
```
Request: "04:20:00:12:23:45 playlist artist 3 ?<LF>"
Response: "04:20:00:12:23:45 playlist artist 3 Abba<LF>"
```

### playlist album
`<playerid> playlist album <index> ?`

Example
```
Request: "04:20:00:12:23:45 playlist album 3 ?<LF>"
Response: "04:20:00:12:23:45 playlist album 3 Greatest Hits<LF>"
```

### playlist title
`<playerid> playlist title <index> ?`

Example
```
Request: "04:20:00:12:23:45 playlist title 3 ?<LF>"
Response: "04:20:00:12:23:45 playlist title 3 Voulez Vous<LF>"
```

### playlist path
`<playerid> playlist path <index> ?`

Example
```
Request: "04:20:00:12:23:45 playlist path 3 ?<LF>"
Response: "04:20:00:12:23:45 playlist path 3 file:///Volumes/Music/ABBA/...<LF>"
```

### playlist duration
`<playerid> playlist duration <index> ?`

Example
```
Request: "04:20:00:12:23:45 playlist duration 3 ?<LF>"
Response: "04:20:00:12:23:45 playlist duration 3 103.2<LF>"
```

***
## playlist tracks
`<playerid> playlist tracks ?1`

The `playlist tracks` command returns the the total number of tracks in the current playlist

Example:
```
Request: "04:20:00:12:23:45 playlist tracks ?<LF>"
Response: "04:20:00:12:23:45 playlist tracks 7<LF>"
```

***
## playlist shuffle
`<playerid> playlist shuffle <0|1|2|?|>`

The `playlist shuffle` command is used to shuffle, unshuffle or query the shuffle state for the current playlist.

Meaning of the `shuffle` parameters:-

* `0` indicates that the playlist is not shuffled,
* `1` indicates that the playlist is shuffled by song,
* `2` indicates that the playlist is shuffled by album.
* Used with no parameter, the command toggles the shuffling state.

Example:
```
Request: "04:20:00:12:23:45 playlist shuffle ?<LF>"
Response: "04:20:00:12:23:45 playlist shuffle 1<LF>"

Request: "04:20:00:12:23:45 playlist shuffle 0<LF>"
Response: "04:20:00:12:23:45 playlist shuffle 0<LF>"
```

***
## playlist repeat

`<playerid> playlist repeat <0|1|2|?|>`

The `playlist repeat` command is used to indicate or query if the player will stop playing at the end of the playlist, repeat the current song indefinitely, or repeat the current playlist indefinitely.

Meaning of the `repeat` parameters

* `0` indicates that the player will stop at the end of the playlist,
* `1` indicates that the player will repeat the current song indefinitely
* `2` indicates that the player will repeat the entire playlist indefinitely.
* Used with no parameter, the command toggles the repeat state.

Example:
```
Request: "04:20:00:12:23:45 playlist repeat ?<LF>"
Response: "04:20:00:12:23:45 playlist repeat 2<LF>"

Request: "04:20:00:12:23:45 playlist repeat 0<LF>"
Response: "04:20:00:12:23:45 playlist repeat 0<LF>"
```

***
## playlistcontrol
`<playerid> playlistcontrol <taggedParameters>`

The`playlistcontrol` command enables playlist operations using IDs as returned by extended CLI queries (titles, artists, playlists, etc).

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `cmd` | Command to perform on the playlist, one of `load`, `add`, `insert` or `delete`. This parameter is mandatory. If no additional parameter is provided, the entire DB is loaded/added/inserted/deleted. |
| `genre_id` | Genre ID, to restrict the results to the titles of that genre. |
| `artist_id` | Artist ID, to restrict the results to the titles of that artist. |
| `album_id` | Album ID, to restrict the results to the titles of that album. |
| `track_id` | Comma-separated list of track IDs, to restrict the results to these track_ids. If this parameter is provided, then any `genre_id`, `artist_id` and/or `album_id` parameter is ignored. The tracks are added to the playlist in the given order. |
| `year` | Year, to restrict the results to the given year. _The form `year_id` is accepted for backwards compatibility but is deprecated._ |
| `playlist_id` | Playlist ID, to restrict the results to this playlist_id. If this parameter is provided, then any `genre_id`, `artist_id`, `album_id` and/or `track_id` parameter is ignored. |
| `folder_id` | Folder ID, to restrict the results to files in this folder_id. If this parameter is provided, then all the others are ignored. _Note that `cmd:delete` is not supported for folders._ |
| `playlist_name` | Playlist name, to restrict the results to this playlist_name. If this parameter is provided, then any `genre_id`, `artist_id`, `album_id`, `track_id` and/or `playlist_id` parameter is ignored. |
| `play_index` | If this parameter is provided along with `cmd:load` then playback will start with the indicated track. |
| `sort` | Album sort order. One of<br>`album`, (the default), <br>`new` (sort by change date in descending order), <br>`artflow` which sorts by artist, year, album for use with artwork-centric interfaces, <br>`artistalbum`, <br>`yearalbum`, <br>`yearartistalbum`, <br>`random`<br>Only of relevance if `genre_id`, `artist_id`, `year` or `year_id` is supplied. |

**Returned tagged parameters:**

| Tag | Description |
|---|---|
| `rescan` | Returned with value 1 if the server is still scanning the database. The command may therefore have missed items. Not returned if no scan is in progress. |
| `count` | Number of elements loaded/added/inserted or max number of elements deleted. For folders, only 1 is returned. |

Example:
```
Request: "a5:41:d2:cd:cd:05 playlistcontrol cmd:add genre_id:9<LF>"
Response: "a5:41:d2:cd:cd:05 playlistcontrol cmd:add genre_id:9 count:33<LF>"

Request: "a5:41:d2:cd:cd:05 playlistcontrol cmd:load album_id:22<LF>"
Response: "a5:41:d2:cd:cd:05 playlistcontrol cmd:load album_id:22 count:12<LF>"
```
