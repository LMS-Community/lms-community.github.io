---
layout: default
title: CLI - Database commands
---

<link rel="stylesheet" href="../cli-doc.css">

# Database commands and queries

***
## rescan
`rescan <|playlists|onlinelibrary|external|full singlefolder|?>`

The `rescan` command causes the server to rescan the entire music library, reloading the music file information.

* If `playlists` is indicated (`rescan playlists`), only the playlist directory is rescanned.
* If `onlinelibrary` is indicated (`rescan onlinelibrary`), only the import from online music services is run.
* If `external` is requested, the rescan will be performed using the external scanner process instead of the in-process scanner.
* If `full file://some/path` is defined, then only this path will be scanned. Issued with a `?`, `rescan ?` returns if the server is currently scanning.

Scanning occurs when the server starts and following `rescan` and `wipecache` commands.

Examples:
```
Request: "rescan<LF>"
Response: "rescan<LF>"

Request: "rescan ?<LF>"
Response: "rescan 1<LF>"
```

***
## rescanprogress
`rescanprogress`

The `rescanprogress` query returns details on the scanning progress. This query does not take any parameters.

**Returned tagged parameters:**

| Tag | Description |
|---|---|
| `rescan` | Returned with value 1 if the server is still scanning the database, otherwise returned with value 0 and the fields below are not returned. |
| `totaltime` | Total elapsed time since the start of the scan, format `hh:mm:ss`. |
| `importer` | A completion percentage for each importer. Importers include:-<br> `directory` (Music folder), <br>`playlist`(Playlist folder), <br>`iTunes` (iTunes), <br>`musicip` (MusicIP), <br><br> as well as more technical ones such as <br> `mergeva` (Various Artists merging) and <br> `dboptimize` (Database optimization).<BR><BR> The type, quantity and order of importers is determined dynamically as rescan progresses. |
| `info` | Additional information about the current scanning step, like eg. the currently scanned file name. |
| `steps` | Scanning steps in the order they've been executed. |
| `lastscanfailed` | Information about a possible failure in case a scan has not finished in an attended manner. |

Example:
```
Request: "rescanprogress<LF>"
Response: "rescanprogress rescan:1 totaltime:00:00:07 directory:100 playlist:100 itunes:15 <LF>"

Request: "rescanprogress<LF>"
Response: "rescanprogress rescan:1 totaltime:00:01:04 directory:100 playlist:100 itunes:100 itunes_playlists:100 mergeva:100 cleanup1:100 cleanup2:100 dboptimize:47 <LF>"
```
***
## abortscan
`abortscan`

The `abortscan` command causes the server to cancel a running scan. Please note that after stopping a scan this way you'll have to fully rescan your music collection to get consistent data.

Examples:
```
Request: "abortscan<LF>"
Response: "abortscan<LF>"
```

***
## wipecache
`wipecache`

The `wipecache` command allows the caller to have the server rescan its music library, reloading the music file information. This differs from the `rescan` command in that it first clears the tag database. During a rescan triggered by `wipecache`, `rescan ?` returns true.

Examples:
```
Request: "wipecache<LF>"
Response: "wipecache<LF>"
```

***
## libraries
`libraries`

The `libraries` query returns a list of known library views with their ID to the caller.

Examples:
```
Request: "libraries<LF>"
Response: "libraries id:8c7ee510 name:FLAC%20files%20only<LF>"
```
***
## libraries getid
`<playerid> libraries getid`

The `libraries getid` query returns the ID and the name of library set to be used by the given player. Returns id:0 and no name if no library is active.

Examples:
```
Request: "04:20:00:12:23:45 libraries getid<LF>"
Request: "04:20:00:12:23:45 libraries getid id:8c7ee510 name:FLAC%20files%20only<LF>"
```

***
## info total genres
`info total genres ?`

The `info total genres ?` query returns the number of unique genres in the server music database.

Examples:
```
Request: "info total genres ?<LF>"
Response: "info total genres 18<LF>"
```

***
## info total artists
`info total artists ?`

The `info total artists ?` query returns the number of unique artists in the server music database. The `Composer, band and orchestra in artists` preference (Server Settings, Behavior) determines which contributors are considered artists.

Examples:
```
Request: "info total artists ?<LF>"
Response: "info total artists 18<LF>"
```
***
## info total albums
`info total albums ?`

The `info total albums ?` query returns the number of unique albums in the server music database.

Examples:
```
Request: "info total albums ?<LF>"
Response: "info total albums 18<LF>"
```

***
## info total songs
`info total songs ?`

The `info total songs ?` query returns the number of unique songs in the server music database.

Examples:
```
Request: "info total songs ?<LF>"
Response: "info total songs 18<LF>"
```

***
## info total duration
`info total duration ?`

The `info total duration ?` query returns the number of seconds playtime in the server music database.

Examples:
```
Request: "info total duration ?<LF>"
Response: "info total duration 66109<LF>"
```

***
## genres
`genres <start> <itemsPerResponse> <taggedParameters>`

The `genres` query returns all genres known by the server.

Note that the server supports multiple genres per track, depending on the `Multiple items in tags` preference (Server Settings, Behavior).

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `search` | Search string. The search is case insensitive and obeys the `Search Within Words` server parameter. |
| `artist_id` | Limit results to those genres proposed by the artist identified by `artist_id`. |
| `album_id` | Limit results to those genres available on the album identified by `album_id`. |
| `track_id` | Limit results to the genres of the track identified by `track_id`. If present, other filters are ignored. |
| `genre_id` | Limit results to the genre identified by `genre_id`. The genre_id may be a list of comma separated IDs. If present, other filters are ignored. |
| `library_id` | Virtual library ID, to restrict the results to a virtual library view. |
| `year` | Limit results to the genres of the tracks of the given `year`. |
| `tags` | Determines which tags are returned. Each returned tag is identified by a letter (see below). The default value is empty. |

**Returned tagged parameters:**

| Block | Tag | Description |
|---|---|---|
| First block: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `rescan` | Returned with value 1 if the server is still scanning the database. The results may therefore be incomplete. Not returned if no scan is in progress. |
|| `count` | Number of results returned by the query. If no filter parameter is present, this is the same value as returned by `info total genres ?`. |
|| `CC` `count`  | - Only return the number of results, but not the results themselves. |
|| `Z` `indexList` | An array of arrays indicating how many items start with each key letter. |
| For each genre: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
||`id` | Genre ID. Item delimiter. |
||`genre` | Genre name. |
|| `s` | textkey |

The genre's `textkey` is the first letter of the sorting key.

Example:
```
Request: "genres 0 5<LF>"
Response: "genres 0 5 rescan:1 count:6 id:3 genre:Acid%20Jazz id:4 genre:Alternative%20&%20Punk id:5 genre:French id:6 genre:No%20Genre id:7 genre:Pop <LF>"

Request: "genres 0 5 search:unk<LF>"
Response: "genres 0 5 search:unk count:1 id:4 genre:Alternative%20&%20Punk<LF>"
```

***
## artists

`artists <start> <itemsPerResponse> <taggedParameters>`

The `artists` query returns all artists known by the server. The results of this query depend in part on the `Compilations` preference (Server Settings, Behavior). The `Various Artists` pseudo-artist appears if the server groups compilations.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `search` | Search substring. The search is case insensitive and obeys the `Search Within Words` server parameter. |
| `genre_id` | Genre ID, to restrict the results to those artists with songs of that genre. The genre_id may be a list of comma separated IDs. |
| `album_id` | Album ID, to restrict the results to those artists with songs of that album. |
| `track_id` | Track ID, to restrict the results to the artist of `track_id`. If specified, all other filters are ignored. |
| `artist_id` | Artist ID, to restrict the results to a single artist. If specified, all other filters are ignored. |
| `role_id` | Contributor role ID, to restrict the results to the artist of `role_id`. This parameter must be a comma separated list of role IDs, or a comma separated list of role tokens (eg. ALBUMARTIST, ARTIST) |
| `library_id` | Virtual library ID, to restrict the results to a virtual library view. |
| `include_online_only_artists` | Include external artists from music services, even if they don't have any track or album in the current collection. This allows callers to browse those artists on the external service. <br><br> Please note that this parmeter would be ignored if some kind of filtering argument was given which didn't apply to artists without related tracks (eg. genre_id, album_id etc.). |
| `tags` | Determines which tags are returned. Each returned tag is identified by a letter (see below). The default value is empty. |

**Returned tagged parameters:**

| Block | Tag | Description |
|---|---|---|
| First block: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `rescan` | Returned with value 1 if the server is still scanning the database. The results may therefore be incomplete. Not returned if no scan is in progress. |
|| `count` | Number of results returned by the query. If no search string is present, this is the same value as returned by `info total artists ?` |
|| `CC`  `count`  | Only return the number of results, but not the results themselves. |
|| `Z`  `indexList` | An array of arrays indicating how many items start with each key letter. |
| For each artist: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `id` | Artist ID. Item delimiter. |
|| `artist` | Artist name. |
|| `s` `textkey` | The artist's `textkey` is the first letter of the sorting key. CLARIFICATION-NEEDED |
|| `E` `extid` | The contributor's external ID, if it is eg. from an online music service. CLARIFICATION-NEEDED |
|| `4` `portraitid` | The contributor's portrait ID |

Example:
```
Request: "artists 0 5<LF>"
Response: "artists 0 5 count:7 id:2 artist:Anastacia id:3 artist:Calogero id:4 artist:Evanescence id:5 artist:Leftfield%20%26%20Lydon id:18 artist:Llorca <LF>"

Request: "artists 0 5 genre_id:7<LF>"
Response: "artists 0 5 genre_id:7 count:2 id:2 artist:Anastacia id:19 artist:Sarah%20Connor <LF>"
```

***
## roles
`roles <start> <itemsPerResponse> <taggedParameters>`

The `roles` query returns all roles known by the server for a given track, or releases.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `track_id` | Track ID, to restrict the results to the album of `track_id`. If specified, all other filters are ignored. |
| `artist_id` | Artist ID, to restrict the results to those albums by `artist_id`. |
| `album_id` | Album ID, to restrict the results to a single album. Or a comma sparated list of album IDs, to restrict the results to a specific list of albums. If specified, all other filters are ignored. |
| `year` | Year, to restrict the results to those albums of that year. |
| `work_id` | Limit results to an individual `work`. |
| `library_id` | Virtual library ID, to restrict the results to a virtual library view. |
| `tags` | Determines which tags are returned. Each returned tag is identified by a letter. The only valid values currently are `t` (textual representation of the contributor type), and `CC` (only return count of results, but no other data). |

**Returned tagged parameters:**

| Block | Tag | Description |
|---|---|---|
| First block: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `rescan` | Returned with value 1 if the server is still scanning the database. The results may therefore be incomplete. Not returned if no scan is in progress. |
| For each role: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
||  `role_id` | The role ID. |
||  `role_name` | The contributor role name (only if requested with `tag:t`) |

Example:
```
Request: "roles 0 1 tags:t<LF>"
Response: "roles 0 1 rescan:1 count:6 role_id:1 role_name:ARTIST <LF>"
```

***
## albums
`albums <start> <itemsPerResponse> <taggedParameters>`

The `albums` query returns all albums known by the server. The results of this query depend in part on the `Group discs` preference (Server Settings, Behavior).

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `search` | Search substring. The search is case insensitive and obeys the `Search Within Words` server parameter. |
| `genre_id` | Genre ID, to restrict the results to those albums with songs of that genre. The genre_id may be a list of comma separated IDs. |
| `artist_id` | Artist ID, to restrict the results to those albums by `artist_id`. |
| `track_id` | Track ID, to restrict the results to the album of `track_id`. If specified, all other filters are ignored. |
| `album_id` | Album ID, to restrict the results to a single album. Or a comma sparated list of album IDs, to restrict the results to a specific list of albums. If specified, all other filters are ignored. |
| `role_id` | Contributor role ID, to restrict the results to those albums by artist of role `role_id`. This parameter must be a comma separated list of role IDs, or a comma separated list of role tokens (eg. ALBUMARTIST, ARTIST) |
| `library_id` | Virtual library ID, to restrict the results to a virtual library view. |
| `year` | Year, to restrict the results to those albums of that year. |
| `compilation` | Compilation, to restrict the results to those albums that are (1) or aren't (0) compilations. |
| `sort` | Sort order of the returned list of albums. One of: <br>`album`, (the default), <br>`new` (sort by the date the item was added to the library, in descending order), <br>`changed` (sort by change date in descending order), <br>`artflow` which sorts by artist, year, album for use with artwork-centric interfaces, <br>`artistalbum`, <br>`yearalbum`, <br>`yearartistalbum`, <br>`random`. |
| `tags` | Determines which tags are returned. Each returned tag is identified by a letter (see below). The default value is `l`. |

**Returned tagged parameters:**

| Block | Tag | Description |
|---|---|---|
| First block: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `rescan` | Returned with value 1 if the server is still scanning the database. The results may therefore be incomplete. Not returned if no scan is in progress. |
|| `count` | Number of results returned by the query. If no filter is present, this is the same value as returned by `info total albums ?` |
|| `CC`  `count` | Only return the number of results, but not the results themselves. CLARIFICATION-NEEDED|
|| `Z` `indexList` | An array of arrays indicating how many items start with each key letter (or year for a year-dominated sort order). CLARIFICATION-NEEDED |
| For each album: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
||   `id` | Album ID. Item delimiter. |
|| `l` `album` | Album name, including the server's added `(N of M)` if the server is set to group multi disc albums together. See tag `title` for the unmodified value. CLARIFICATION-NEEDED |
|| `y` `year` | Album year. This is determined by the server based on the album tracks. |
|| `j` `artwork_track_id` | Identifier of one of the album tracks, used by the server to display the album's artwork. |
|| `t` `title` | `Raw` album title as found in the album tracks ID3 tags, as opposed to `album`. Note that `title` and `album` are identical if the server is set to group discs together. |
|| `i` `disc` | Disc number of this album. Only if the server is not set to group multi-disc albums together. |
|| `q` `disccount` | Number of discs for this album. Only if known. |
|| `w` `compilation` | 1 if this album is a compilation. |
|| `W` `release_type` | The release type of an album, eg. `album`, `ep`, etc. |
|| `a` `artist` | The album artist (depends on server configuration). |
|| `aa` `artists` | A comma separated list of album artists (depends on server configuration). |
|| `S` `artist_id` | The album artist id (depends on server configuration). |
|| `SS` `artist_ids` | A comma separated list of album artist ids (depends on server configuration). |
|| `s` `textkey` | The album's `textkey` is the first letter of the sorting key. |
|| `E` `extid` | The album's external ID, if it is eg. from an online music service. |
|| `R` `role_ids` | A comma separated list of role ids for the album. |
|| `X` `album_replay_gain` | The album's replay-gain. |
|| `2` `group_count & contiguous_groups` | Returns a count of distinct works/groupings/performances on the album and a flag indicating whether the groups are contiguous, to assist UI formatting of the album results. |
|| `4` `portraitid` | The contributor's portrait ID |

Examples:
```
Request: "albums 0 4<LF>"
Response: "albums 0 4 count:14 id:1 album:Amadeus%20(Disc%201%20of%202) id:4 album:Anastacia id:5 album:Bounce%20[Single] id:6 album:Fallen<LF>"

Request: "albums 0 5 genre_id:7<LF>"
Response: "albums 0 5 genre_id:7 count:2 id:4 album:Anastacia id:5 album:Bounce%20[Single]<LF>"

Request: "albums 0 5 artist_id:19<LF>"
Response: "albums 0 5 artist_id:19 count:1 id:5 album:Bounce%20[Single]<LF>"
```

***
## works
`works <start> <itemsPerResponse> <taggedParameters>`

The `works` query returns all works known by the server.

A Work is a (usually classical) piece of music made up of one or more movements, acts, scenes etc, each of which is usually a separate track.

A Work is defined by its name and its composer.

An Album can contain many Works, and an instance of a Work can exist on many Albums. There is therefore a many-to-many relationship between Works and Albums.
This many-to-many relationship is resolved in the Tracks table which contains the album id and the work id.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `search` | Search string. The search is case insensitive and obeys the `Search Within Words` server parameter. |
| `artist_id` | Limit results to those works on which the artist identified by `artist_id` performs. |
| `genre_id` | Limit results to the genre(s) identified by `genre_id`. The genre_id may be a list of comma separated IDs. |
| `library_id` | Virtual library ID, to restrict the results to a virtual library view. |
| `work_id` | Limit results to an individual `work`. |
| `role_id` | Limit results to the role(s) identified by `role_id`. The role_id may be a list of comma separated IDs. |

**Returned parameters:**

| Block | Tag | Description |
|---|---|---|
| First block: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
| count | `count` | Number of results returned by the query.  |
| For each work: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `single_composer` | only returned if the results contain works from a single composer who is also the searched-for contributor |
|| `composer` | the name of the composer of the work |
|| `work` | the name of the work |
|| `composer_id` | the id of the composer of the work |
|| `artwork_track_id` | the id of the artwork for the first album found containing the work |
|| `artwork_track_ids` | a list of all artwork ids of albums containing the work |
|| `album_id` | a list of the ids of all albums containing the work |
|| `textkey` | if `single_composer` (see above), the first letter of the work name, otherwise, the first letter of the composer name |
|| `favorites_url` | the URL for favoriting the work |
|| `favorites_title` | the text to be used for the favorite |

***
## years
`years <start> <itemsPerResponse> <taggedParameters>`

The `years` query returns all years known by the server.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `year` | Return only the specified year. |
| `hasAlbums:1` | Return only years which are valid for albums. |

**Returned tagged parameters:**

| Block | Tag | Description |
|---|---|---|
| First block: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `rescan` | Returned with value 1 if the server is still scanning the database. The results may therefore be incomplete. Not returned if no scan is in progress. |
| For each year: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
||  `year` | Year. Item delimiter.|

Example:
```
Request: "years 0 5<LF>"
Response: "years 0 5 rescan:1 count:6 year:1985 year:1987 year:1988 year:2002 year:2003 year:2004 <LF>"
```

***
## musicfolder

`musicfolder <start> <itemsPerResponse> <taggedParameters>`

The `musicfolder` query returns the content of a given music folder, starting from the top level directory configured in the server.

`mediafolder` is an alias to `musicfolder`.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `folder_id` | Browses the folder identified by `folder_id`. |
| `return_top` | If set to 1, and `folder_id` is provided, will return the data about the listed folder instead of the child folders. |
| `url` | Browses the folder identified by `url`. If the content of `url` did not happen to be in the server database, it is added to it.<br><br> `url` has precedence over `folder_id` if both are provided. |
| `type` | One of `audio`, or `list`. Select the media type you want to browse in the given folder. |
| `tags` | Determines which tags are returned. Each returned tag is identified by a letter (see below). The default value is empty. |
| `recursive` | If set to 1, the query will return information about the requested folder and its sub-folders, and all files in there. |

**Returned tagged parameters:**

| Block | Tag | Description |
|---|---|---|
| First block: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `rescan` | Returned with value 1 if the server is still scanning the database. The results may therefore be incomplete. Not returned if no scan is in progress. |
|| `count` | Number of results returned by the query. |
| For each item in the folder: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `id` | Track, playlist or folder ID. Item delimiter. |
|| `type` | One of `track`, `folder`, `playlist`, or `unknown`. |
|| `c` `coverid` | coverid to use when constructing an artwork URL, such as /music/$coverid/cover.jpg |
|| `d`  `duration` | Song duration in seconds. |
|| `s` `textkey` | The item's `textkey` is the first letter of the sorting key. |
|| `u`  `url` | The item's full URL. |

Example:
```
Request: "musicfolder 0 10<LF>"
Response: "musicfolder 0 10 count:26 id:1 title:03%20Barbie%20Girl.mp3 type:audio id:2 title:12%20-%20If%20I%20Had%20You.mp3 type:audio id:313 title:A-Ha type:dir id:50 title:Test.m3u type:playlist<LF>"

Request: "musicfolder 0 10 folder_id:313<LF>"
Response: "musicfolder 0 10 folder_id:313 count:2 id:335 title:Lifelines type:dir id:336 title:Minor%20Earth%20Major%20Sky type:dir<LF>"
```
### mediafolder

`mediafolder` is an alias of [`musicfolder`](#musicfolder)

***
## playlists
`playlists <start> <itemsPerResponse> <taggedParameters>`

The `playlists` query returns all playlists known by the server.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `search` | Search substring. The search is case insensitive and obeys the `Search Within Words` server parameter. |
| `tags` | Determines which tags are returned. Each returned tag is identified by a letter (see below). The default value is empty. |

**Returned tagged parameters:**

| Block | Tag | Description |
|---|---|---|
| First block: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `rescan` | Returned with value 1 if the server is still scanning the database. The results may therefore be incomplete. Not returned if no scan is in progress. |
|| `count` | Number of results returned by the query. |
| For each playlist: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `id` | Playlist ID. Item delimiter. |
|| `playlist` | Playlist name |
|| `s` `textkey` | The playlist's `textkey` is the first letter of the sorting key. |
|| `u`  `url` | The playlist's url. |
|| `E`  `extid` | The playlist's external ID, if it is eg. from an online music service. |
|| `x`  `remote` | If 1, this is a remote playlist. |

Example:
```
Request: "playlists 0 2<LF>"
Response: "playlists 0 2 count:5 id:37 name:Funky%20Beats id:57 name:SUPER<LF>"

Request: "playlists 0 2 search:SUPER tags:u<LF>"
Response: "playlists 0 2 search:SUPER tags:u count:1 id:57 name:SUPER url:playlist:///Volume/path/file.m3u<LF>"
```

***
## playlists tracks

`playlists tracks <start> <itemsPerResponse> <taggedParameters>`

The `playlists tracks` query returns the tracks of a given playlist.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `playlist_id` | Playlist ID as returned by the `playlists` query. This is a mandatory parameter. |
| `tags` | Determines which tags are returned. Each returned tag is identified by a letter (see command [`songinfo`](#songinfo) for a list of possible fields and their identifying letter). The default tags value for this command is `gald`. |

**Returned tagged parameters:**

| Block | Tag | Description |
|---|---|---|
| First block: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `rescan` | Returned with value 1 if the server is still scanning the database. The results may therefore be incomplete. Not returned if no scan is in progress. |
|| `count` | Number of tracks in the playlist. |
| For each track: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `playlist index` | Index (first item is 0) of the track in the playlist. The first returned instance of this field is equal to start. Item seperator. |
|| `Tags` | Same tags as defined in command [`songinfo`](#songinfo). |

***
## playlists rename
`playlists rename <taggedParameters>`

This command renames a saved playlist.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `playlist_id` | The id of the playlist to rename. |
| `newname` | The new name of the playlist (without .m3u). |
| `dry_run` | Used to check if the new name is already used by another playlist. The command performs the name check but does not overwrite the existing playlist. If a name conflict occurs, the command will return a `overwritten_playlist_id` parameter. |

**Returned tagged parameters:**

| Tag | Description |
|---|---|
| `overwritten_playlist_id` | This returns the playlist id of the playlist overwritten (if `dry_run` is 0 or not present) by renaming the playlist. Only present if a playlist is overwritten. |

Examples:
```
Request: "playlists rename playlist_id:22 newname:Hello<LF>"
Response: "playlists rename playlist_id:22 newname:Hello<LF>"
```

***
## playlists new
`playlists new <taggedParameters>`

This command creates an empty saved playlist, to be further manipulated by other commands.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `name` | The name of the playlist (without .m3u). |

**Returned tagged parameters:**

| Tag | Description |
|---|---|
| `playlist_id` | This returns the playlist id of the created playlist. |
| `overwritten_playlist_id` | This returns the playlist id of an existing playlist with the same name. The new playlist is not created. |

Examples:
```
Request: "playlists new name:Hello<LF>"
Response: "playlists new name:Hello playlist_id:345<LF>"
```

***
## playlists delete
`playlists delete <taggedParameters>`

This command deletes a saved playlist.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `playlist_id` | The id of the playlist to delete. |

Examples:
```
Request: "playlists delete playlist_id:22<LF>"
Response: "playlists delete playlist_id:22<LF>"
```
***
## playlists edit
`playlists edit <taggedParameters>`

This command manipulates the track content of a saved playlist.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `playlist_id` | The id of the playlist to manipulate. |
| `cmd` | One of `up`, `down`, `move`, `delete` or `add`, in order to move up, down, delete or add a track. |
| `index` | For `cmd:up`, `cmd:down`, `cmd:move` and `cmd:delete` the index of the track to edit. |
| `toindex` | For `cmd:move` the new index of the track to be moved. |
| `title` | For `cmd:add`, the title of the track to add. |
| `url` | For `cmd:add`, the url of the track to add. |

Examples:
```
Request: "playlists edit cmd:up playlist_id:22 index:3<LF>"
Response: "playlists edit cmd:up playlist_id:22 index:3<LF>"

Request: "playlists edit cmd:add playlist_id:22 title:Song url:file://...<LF>"
Response: "playlists edit cmd:add playlist_id:22 title:Song url:file://...<LF>"
```

***
## songinfo
`songinfo <start> <itemsPerResponse> <taggedParameters>`

The `songinfo` command returns all the information on a song known by the server. Please note that the <start> and <itemsPerResponse> parameters apply to the individual data fields below and not, as they do in other extended CLI queries, to the number of songs (or artists, genres, etc.) returned; the `songinfo` only ever returns information about a single song.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `url` | Song path as returned by other CLI commands. This is a mandatory parameter, except if `track_id` is provided. |
| `track_id` | Track ID as returned by other CLI commands. This is a mandatory parameter, except if `url` is provided. |
| `tags` | Determines which tags are returned. Each returned tag is identified by a letter (see below). The default value is all info except the url (`u`) and the multi-valued tags for genre(s) (`G` & `P`) and artists (`A` & `S`) |

**Returned tagged parameters:**

| Tag | Description | |
|---|---|---|
| `rescan` | Returned with value 1 if the server is still scanning the database. The results may therefore be incomplete. Not returned if no scan is in progress. |
| `count` | Number of results returned by the query, that is, total number of elements to return for this song. |
| `id` | Track ID. |
| `title` | Song title |
| `a`  `artist` | Artist name. |
| `A`  `<role>` | For every artist role (one of `artist`, `composer`, `conductor`, `band`, `albumartist` or `trackartist`), a comma and space (', ') separated list of names. |
| `AA`  `<role>` | This is like `A`, but without the space after the comma. This should simplify parsing/splitting when required. |
| `B`  `buttons` | A hash with button definitions. Only available for certain plugins such as Pandora. |
| `c`  `coverid` | coverid to use when constructing an artwork URL, such as /music/$coverid/cover.jpg |
| `C`  `compilation` | 1 if the album this track belongs to is a compilation |
| `K`  `artwork_url` | A full URL to remote artwork. Only available for certain online music services. |
| `W`  `release_type` | The release type of the track's album, eg. `album`, `ep`, etc. |
| `d`  `duration` | Song duration in seconds. |
| `e`  `album_id` | Album ID. Only if known. |
| `f`  `filesize` | Song file length in bytes. Only if known. |
| `g`  `genre` | Genre name. Only if known. |
| `G`  `genres` | Genre names, separated by commas (only useful if the server is set to handle multiple items in tags). |
| `i`  `disc` | Disc number. Only if known. |
| `I`  `samplesize` | Song sample size (in bits) |
| `j`  `coverart` | 1 if coverart is available for this song. Not listed otherwise. |
| `J`  `artwork_track_id` | Identifier of the album track used by the server to display the album's artwork. Not listed if artwork is not available for this album. |
| `k`  `comment` | Song comments, if any. |
| `K`  artwork_url | A full URL to remote artwork. Only available for certain online music services. |
| `l`  `album` | Album name. Only if known. |
| `L`  `info_link` | A custom link to use for trackinfo. Only available for certain online music services. |
| `m`  `bpm` | Beats per minute. Only if known. |
| `M`  `musicmagic_mixable` | 1 if track is mixable, otherwise 0. |
| `n`  `modificationTime` | Date and time song file was last changed on disk. |
| `N`  `remote_title` | Title of the internet radio station. |
| `o`  `type` | Content type. Only if known. |
| `Q` `lossless` | 1 if track is lossless, otherwise 0. |
| `p`  `genre_id` | Genre ID. Only if known. |
| `P`  `genre_ids` | Genre IDs, separated by commas (only useful if the server is set to handle multiple items in tags). |
| `D`  `addedTime` | Date and time song file was first added to the database. |
| `U`  `lastUpdated` | Date and time song file was last updated in the database. |
| `q`  `disccount` | Number of discs. Only if known. |
| `r`  `bitrate` | Song bitrate. Only if known. |
| `R`  `rating` | Song rating, if known and greater than 0. |
| `O`  `playcount` | Song play count. |
| `s`  `artist_id` | Artist ID. |
| `S`  `<role>_ids` | For each role as defined above, the list of ids (comma separated). |
| `t`  `tracknum` | Track number. Only if known. |
| `T`  `samplerate` | Song sample rate (in KHz) |
| `u`  `url` | Song file url. |
| `v`  `tagversion` | Version of tag information in song file. Only if known. |
| `w`  `lyrics` | Lyrics. Only if known. |
| `x`  `remote` | If 1, this is a remote track. |
| `E`  `extid` | Some tracks have an external identifier (eg. from an online music service). |
| `X`  `album_replay_gain` | Replay gain of the album (in dB), if any |
| `y`  `year` | Song year. Only if known. |
| `Y`  `replay_gain` | Replay gain (in dB), if any |
| `V`  `live_edge` | The Live edge of a remote stream. -1 is not live, 0 is live at the edge, >0 is number of seconds from the live edge. |
| `4`  `portraitid` | The contributor's portrait ID |

Example:
```
Request: "songinfo 0 100 track_id:2<LF>"
Response: "songinfo 0 100 track_id:2 count:26 id:2 title:If%20I%20Had%20You artist:Diana%20Krall duration:297.117 album_id:2 filesize:5952369 genre:Vocal comment:Pianist%2Fvocalist%20Diana%20Krall%20pays%20tribute%20to%20the%20Nat%20King%20Cole%20Trio.... album:All%20for%20You modificationTime:Thursday%2C%20March%201%2C%202007%2C%209:21:58%20PM type:mp3 genre_id:2 bitrate:160kbps%20VBR artist_id:3 tracknum:12 tagversion:ID3v2.3.0 year:1995 samplerate:44100 url:file:%2F%2F%2FUsers%2Ffred%2FPrograms%2FLyrion Music Server%2FMusic%2F12%2520-%2520If%2520I%2520Had%2520You.mp3 <LF>"
```
***
## titles|songs|tracks

`titles|songs|tracks <start> <itemsPerResponse> <taggedParameters>`

The `titles` command returns all titles known by the server.

`songs` and `tracks` are aliases for `titles`

**Accepted tagged parameters:**

| Tag | Description | |
|---|---|---|
| `genre_id` | Genre ID, to restrict the results to the titles of that genre. |
| `artist_id` | Artist ID, to restrict the results to the titles of that artist. |
| `album_id` | Album ID, to restrict the results to the titles of that album. |
| `track_id` | Track ID, to restrict the results to a single track. |
| `role_id` | Contributor role ID, to restrict the results to the artist of role `role_id`. This parameter must be a comma separated list of role IDs, or a comma separated list of role tokens (eg. ALBUMARTIST, ARTIST) |
| `release_type` | The release type of the track's album, eg. `album`, `ep`, etc. |
| `library_id` | Virtual library ID, to restrict the results to a virtual library view. |
| `year` | Year, to restrict the results to the titles of that year. |
| `search` | Search substring. The search is case insensitive and obeys the `Search Within Words` server parameter. |
| `tags` | Determines which tags are returned. Each returned tag is identified by a letter (see command [`songinfo`](#songinfo) for a list of possible fields and their identifying letter). The default tags value for this command is `gald`. |
| `CC` | Only return the number of results, but not the results themselves. |
| `sort` | Sorting, one of:-<br>`title` (the default), <br>`tracknum` (in which case the track field (`t`) is added automatically to the response) or <br>`albumtrack` (in which case the track and album-title fields (`l` and `t`) are added automatically to the response). <br><br>Sorting by tracks is possible only if tracks are defined and for a single album. |

**Returned tagged parameters:**

| Block | Tag | Description |
|---|---|---|
| First block: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `rescan` | Returned with value 1 if the server is still scanning the database. The results may therefore be incomplete. Not returned if no scan is in progress. |
|| `count` | Number of results returned by the query. If no search string or album/artist/genre filter is present, this is the same value as returned by `info total songs ?`. |
| For each title: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `Tags` | Same tags as defined in command [`songinfo`](#songinfo).|

Example:
```
Request: "titles 0 2<LF>"
Response: "titles 0 2 count:100 id:55 title:Ancestral%20Aid genre:Soundtrack artist:Various%20Artists album:The%20Hunt%20For%20Red%20October duration:136.93387755102 disc:1 track:5 year:1990 url:file://Disk | he%20Hunt%20For%20Red%20October/Ancestral%20Aid.mp3 id:1 title:Any%20How genre:Acid%20Jazz artist:Llorca album:New%20Comer duration:340.297142857143 track:5 year:2001 url:...<LF>"

Request: "titles 0 12 album:Anastacia tags:p<LF>"
Response: "titles 0 12 album:Anastacia tags:p count:12 id:4 title:Heavy%20On%20My%20Heart url:... id:1 title:I%20Do url:... id:2 title:Left%20Outside%20Alone url:...<LF>"
```

***
## tags
`tags <url|track_id>`

Return the tracks found in the file referenced by the `url` or `track_id`.

Please note that returned data depends on the file format, tagging software used, etc.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `url` | The `file://` or `tmp://` URL to the audio file. |
| `track_id` | The track's ID |

Example:
```
Request: "tags track_id:454<LF>"
Response: tags track_id%3A454 ALBUM%3A0 ARTIST%3ALow%20Roar COMMENT%3A%40JW DATE%3A2014 GENRE%3AAlternative REPLAYGAIN_ALBUM_GAIN%3A-9.18%20dB REPLAYGAIN_ALBUM_PEAK%3A1.00000000 REPLAYGAIN_REFERENCE_LOUDNESS%3A89.0%20dB REPLAYGAIN_TRACK_GAIN%3A-3.16%20dB REPLAYGAIN_TRACK_PEAK%3A0.96447754 TITLE%3AIn%20the%20Morning TRACKNUMBER%3A8 VENDOR%3Areference%20libFLAC%201.2.1%2020070917
```


***
## search
`search <start> <itemsPerResponse> <taggedParameters>`

The `search` command returns artists, albums and tracks matching a search string.

Please note that `start` and `itemsPerResponse` are calculated per category. If you eg. have genres and tracks with the search term in them, you'll get `itemsPerResponse` number of each of them. The total number of items returned therefore can be a multiple of `itemsPerResponse`.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `term` | Search string |

**Returned tagged parameters:**

| Block | Tag | Description |
|---|---|---|
| First block: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `rescan` | Returned with value 1 if the server is still scanning the database. The results may therefore be incomplete. Not returned if no scan is in progress. |
|| `count` | Total number of results returned by the query. This is the sum of `artists_count`, `albums_count` and `tracks_count`. |
|| `artists_count` | Total number of artists found. |
|| `albums_count` | Total number of albums found. |
|| `genres_count` | Total number of genres found. |
|| `tracks_count` | Total number of tracks found. |
| For each artist: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `artist_id` | Artist ID. |
|| `artist` | Artist name. |
| For each album: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `album_id` | Album ID. |
|| `albu` | Album title |
| For each genre: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `genre_id` | Genre ID. |
|| `genre` | Genre title. |
| For each track: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `track_id` | Track ID. |
|| `track` | Track title. |

Example:
```
Request: "search 0 20 term:al<LF>"
Response: "search 0 20 term:al count:9 artists_count:2 albums_count:1 tracks_count:6 artist_id:2 artist:Alanis%20Morissette artist_id:37 artist:Alphaville album_id:10 album:All%20Time%20Greatest%20Hits%20%5BBarry%20White%5D%20MMM track_id:11 track:All%20I%20Really%20Want track_id:68 track:The%20Sun%20Always%20Shines%20On%20TV track_id:185 track:All%20Around%20The%20World track_id:189 track:Give%20Me%20All%20Your%20Love%20%5BSingle%20Cut%5D track_id:245 track:Better%20All%20The%20Time
```

***
## pragma
`pragma <pragma string>`

The `pragma` command executes the given pragma string against the SQLite database engine. If using MySQL, this command has no effect. For a list of available pragmas, see sqlite.org. Warning: Do not use this function unless you know what you are doing!

Example:
```
pragma locking_mode = NORMAL
```
