---
layout: default
title: CLI - Compound Queries commands
---

# Compound queries

These queries were set up in order to get most of the information about the server or a player in one convenient query, that can be updated by the server automatically.


***
## serverstatus

`serverstatus <start> <itemsPerResponse> <taggedParameters>`

The `serverstatus` query returns a complete status about the server, including its players.

Clients can subscribe to `serverstatus` queries, so that the query results are automatically returned asynchronously whenever a change occurs to the server. Please note this mechanism is completely distinct from the `listen` and `subscribe` commands described elsewhere in this document.

**Accepted tagged parameters:**

| Tag | Description |
| --- | --- |
| `prefs` | Comma separated list of server preference values to return. |
| `playerprefs` | Comma separated list of player preference values to return (for each player). |
| `subscribe` | This optional parameter controls the subscription to the server status. Only one status subscription is possible per connection. |

Subscription is enabled by using this parameter with a positive integer. It is disabled by using `-`. When the subscription is enabled, normal `serverstatus` queries (i.e. not using the `subscribe` parameter) can be performed and will have no effect on the subscription in place.

When enabled, the `serverstatus` query is automatically re-generated on server change (and sent asynchronously to the CLI client). The number indicates the time interval in seconds between automatic generations in case nothing happened to the server info in the interval. Use `0` to disable this last feature and only be notified on changes. Please see the example.

Some situations will lead to multiple status queries generated very close to another. This is a limitation of the change detection "algorithm".

Please note this mechanism is completely distinct from the `listen` and `subscribe` commands described above.


**Returned tagged parameters:**

| Block | Tag | Description |
| --- | --- | --- |
| First block ||
 || `rescan` | Returned with value `1` if the server is still scanning the database. The results may therefore be incomplete. Not returned if no scan is in progress. |
 || `lastscan` | Returned with the timestamp when the last scan finished. Not returned if no scan has been run yet. |
 || `progressname` | Returned with the name for the current scan phase. Not returned if no scan is in progress. |
 || `progressdone` | Returned with the current value of items completed for current scan phase. Not returned if no scan is in progress. |
 || `progresstotal` | Returned with the total value of items found for current scan phase. Not returned if no scan is in progress. |
 || `lastscanfailed` | Information about a possible failure in case a scan has not finished in an attended manner. |
|| `version` | LMS version. Equivalent to `version ?` |
 || `mac` | The MAC address of the computer on which the server software is running. |
 || `ip` | The IP address of the computer on which the server software is running. |
|| `httpport` | The port on which the server software is listening. |
 || `uuid` | The server's unique identifier string. |
 || `info total albums` | Number of albums known to the server. Equivalent to `info total albums ?` |
 || `info total artists` | Number of artists known to the server. Equivalent to `info total artists ?` |
 || `info total genres` | Number of genres known to the server. Equivalent to `info total genres ?` |
 || `info total songs` | Number of songs known to the server. Equivalent to `info total songs ?` |
| For each defined pref requested: ||
 || `prefName` | Preference value. Only if the value is defined. Equivalent to `pref prefName ?`. |
|| `player count` | Number of players known by the server. Equivalent to `player count ?`. |
| For each player:  Essentially, this list is equivalent to the one returned by `players`. |
|| `playerid` | Player unique identifier. Item delimiter. Equivalent to `player id ?`. |
|| `uuid` | Player unique identifier. Equivalent to `player uuid ?`. |
|| `ip` | Player IP and port. Equivalent to `player ip ?`. |
||  `name` | Player name. Equivalent to `player name ?`. |
||  `model` | Whether the player is powered on or off. |
||  `power` | Player model. Equivalent to `player model ?`. |
||  `isplayer` | Whether a player is a known player model. Will return 0 for streaming connections. Equivalent to `player isplayer ?`. |
||  `displaytype` | Player display type. Not returned for streaming connections. Equivalent to `player displaytype <playerindex> ?`.  |
||   `canpoweroff` | Whether the player can be powered off. This value is false for streaming connections. |
||  `connected` | Connected state. Equivalent to `<playerid> connected ?`. |
||  `player_needs_upgrade` | Connected player needs a firmware upgrade. |
||  `player_is_upgrading` | Connected player is in the process of performing a firmware update. |
|| `other player count` | Number of players connected to other discovered servers in the local network. |
| For each player connected to some other server in the local network:||
||  `playerid` | Player unique identifier (MAC address). |
||  `name` | Player name. |
||  `server` | The server to which the player is connected
||  `model` | Player model. Please note that only Squeezebox2 and later can be remotely disconnected. |
| For each defined player pref requested: ||
||  `prefName` | Preference value. Only if the value is defined. Equivalent to `playerpref prefName ?`. |


Example:
```
***Add some examples here CLARIFICATION-NEEDED***
```

***
## status

`<playerid> status <start> <itemsPerResponse> <taggedParameters>`

The `status` query returns the complete status about a given player, including the current playlist. Set the <start> parameter to `-` to get the playlist data starting from the current song.

In this `current` mode and if repeat is on, the server will attempt to return `<itemsPerResponse>` elements, by repeating the playlist at most once, unless shuffling is on and the server is configured to re-shuffle the playlist at each loop (in which case it is impossible to predict the song following the last one in the playlist until this last song has finished playing).

Similarly, in the `current` mode, if repeat is one, only the current song is returned, regardless of the value of `<itemsPerResponse>`.

Clients can subscribe to `status` queries, so that the query results are automatically returned asynchronously whenever a change occurs to a player. Please note this mechanism is completely distinct from the `listen` and `subscribe` commands described elsewhere in this document.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `tags` | Determines which tags are returned. Each returned tag is identified by a letter (see command `songinfo` for a list of possible fields and their identifying letter). The default tags value for this query is `gald`. In addition to the tags supported by `songinfo` there's the special `DD` tag, which would return no track information, but the total duration of the current playlist only. |
| `alarmData` | If set to a truthy value will return information about the next upcoming alarm. |
| `subscribe` | This optional parameter controls the subscription to the player status. Only one status subscription is possible per player and connection. |

Subscription is enabled by using this parameter with a positive integer. It is disabled by using `-`. When the subscription is enabled, normal `status` queries (i.e. not using the `subscribe` parameter) can be performed and will have no effect on the subscription in place.

When enabled, the `status` request is automatically re-generated on player change (and sent asynchronously to the CLI client). The number indicates the time interval in seconds between automatic generations in case nothing happened to the player in the interval. Use `0` to disable this last feature and only be notified on player or playlist changes. Please see the example.

Some situations will lead to multiple status queries generated very close to another. This is a limitation of the change detection "algorithm".

If the player is manually (through the web page) or automatically deleted from the server, the status query returns the `error` tag with value `invalid player` and the subscription is terminated.

Please note this mechanism is completely distinct from the `listen` and `subscribe` commands described above.


**Returned tagged parameters:**

| Tag | Description |
|---|---|
| `rescan` | Returned with value 1 if the server is still scanning the database. The results may therefore be incomplete. Not returned if no scan is in progress. |
| `error` | Returned with value `invalid player` if the player this subscription query referred to no longer exists. |

In non subscription mode, the query simply echoes itself (i.e. produces no result) if <playerid> is wrong.

| Tag | Description |
|---|---|
| `player_name` | Name of the player. |
| `player_connected` | Connected state of the player. |
| `player_needs_upgrade` | Connected player needs a firmware upgrade. |
| `player_is_upgrading` | Connected player is in the process of performing a firmware update. |
| `power` | Power state of the player. Not returned for remote streaming connections. |
| `signalstrength` | Signal strength (only for Squeezeboxen and Transporters). | 
| `waitingToPlay` | A flag telling whether the player isn't actually playing, but still waiting for data or something. |
| `alarm_state`| One of 'active' (means alarm currently going off), 'set' (alarm set to go off in next 24h on this player), 'none' (no alarm set to go off in next 24h on this player), 'snooze' (alarm is active but currently snoozing). |
| `alarm_next` | Epochtime seconds when the next alarm within the next 24h is due. |
| `alarm_days` | A list of 0 or 1, for the days on which the alarm is set (0=Sunday). |
| `alarm_snooze_seconds` | The snooze duration for the upcoming alarm. |
| `alarm_timeout_seconds` | The alarm timeout for the upcoming alarm. |
| If player is on: |  |
| `mode` | Player mode. |
| `remote` | Returns 1 if a remote stream is currently playing. |
| `current_title` | Returns the current title for remote streams. Only if remote stream is playing. |
| `time` | Elapsed time into the current song. Decimal seconds. Only if current song. |
| `rate` | Player rate. Only if there is a current song. |
| `duration` | Duration of the current song. Decimal seconds. Only if current song and if the duration is known (it is not for remote streams). |
| `sleep` | If set to sleep, the amount (in seconds) it was set to. |
| `will_sleep_in` | Seconds left until sleeping. Only if set to sleep. |
| `sync_master` | ID of the master player in the sync group this player belongs to. Only if synced. |
| `sync_slaves` | Comma-separated list of player IDs, slaves to sync_master in the sync group this player belongs to. Only if synced. |
| `mixer volume` | Not returned for remote streaming connections. |
| `mixer treble` | Only for SliMP3 and Squeezebox1 players. |
| `mixer bass` | Only for SliMP3 and Squeezebox1 players. |
| `mixer pitch` | Only for Squeezebox1 players. |
| `playlist duration` | Duration of the full playlist. Decimal seconds. Only if tag `DD` was requested and for the duration of tracks where it is known (it is not for eg. radio streams). |
| `playlist repeat` | 0 no repeat, 1 repeat song, 2 repeat playlist. |
| `playlist shuffle` | 0 no shuffle, 1 shuffle songs, 2 shuffle albums. |
| `playlist_id` | Playlist id, if the current playlist is a stored playlist. |
| `playlist_name` | Playlist name, if the current playlist is a stored playlist. Equivalent to `playlist name ?`. |
| `playlist_modified` | Modification state of the saved playlist (if the current playlist is one). Equivalent to `playlist modified ?`. |
| `playlist_timestamp` | Timestamp of the current playlist, in seconds. Changes to the playlist (insertion/removal/shuffling) result in an increase of this value. This can be used to detect the entire playlist has to be reacquired. |
| `playlist_tracks` | Number of tracks in the current playlist. Only if there is a playlist. |
|If playlist information exist/requested, for each song in the playlist: |
| `playlist index` | Index (first item is 0) of the playlist entry in the player playlist. Unless <start> is `-`, the first returned instance of this field is equal to start. If <start> is `-`, the first returned instance of this field contains the index of the currently playing song in the player playlist. Item separator. |
| `Tags` | Same tags as defined in command `songinfo`. |


Examples:

Simple example
```
Request: "a5:41:d2:cd:cd:05 status 0 2 tags:<LF>"
Response: "a5:41:d2:cd:cd:05 status 0 2 tags: player_name:127.0.0.1 player_connected:1 power:1 mode:play rate:1 time:13.7129358076728 duration:252.630204081633 mixer%20volume:50 mixer%20treble:50 mixer%20bass:50 mixer%20pitch:100 playlist%20repeat:2 playlist%20shuffle:0 playlist_cur_index:1 playlist_tracks:3 playlist%20index:0 title:Left%20Outside%20Alone playlist%20index:1 title:Bounce%20[Original%20Version]<LF>"
```

Current mode example
```
Request: "a5:41:d2:cd:cd:05 status - 2 tags:<LF>"
Response: "a5:41:d2:cd:cd:05 status - 2 tags: player_name:127.0.0.1 player_connected:1 power:1 mode:play rate:1 time:18.721127818274 duration:252.630204081633 mixer%20volume:50 mixer%20treble:50 mixer%20bass:50 mixer%20pitch:100 playlist%20repeat:2 playlist%20shuffle:0 playlist_cur_index:1 playlist_tracks:3 playlist%20index:1 title:Bounce%20[Original%20Version] playlist%20index:2 title:Open%20Up%20[Radio%20Edit]<LF>"
```

Subscribe mode example
```
Request: "a5:41:d2:cd:cd:05 status - 2 subscribe:30<LF>"
Response: "a5:41:d2:cd:cd:05 status - 2 subscribe:30 player_name:127.0.0.1 ... (same as above)

10 seconds later, player is turned off, CLI generates and sends:
"a5:41:d2:cd:cd:05 status - 2 subscribe:30 player_name:127.0.0.1 player_connected:1 power:0<LF>"

30 seconds (the subscribe value) elapse, no changes to the player, the CLI generates and sends:
"a5:41:d2:cd:cd:05 status - 2 subscribe:30 player_name:127.0.0.1 player_connected:1 power:0<LF>"
```

***
## displaystatus

`displaystatus <taggedParameters>`

The `displaystatus` query allows subscription to display update events for a player. Details of the latest display change are automatically returned whenever the relevant display update event occurs on that player.

Clients may subscribe to only receive status and warning (`showbriefly`) messages, receive normal display updates (`update`), or receive all display updates including menu transitions ('all').

Clients may also subscribe to receive the bitmap which comprises each display update ('bits'). For SB2 and later players, this forwards the display bitmap to the client encoded in base64. Clients may request a reduced width display by setting the width parameter in the status subscription. Note this reduces the width of the display shown on the live player screen as well as for the display forwarded to the cli client.

**Accepted tagged parameters:**

| Tag | Description
|---|---|
| `subscribe` | 'showbriefly', 'update', 'all' or 'bits' to subscribe and nothing to unsubscribe |
| `width` | Reduced width for the display, only used with a subscription for 'bits' |

***
## readdirectory

`readdirectory <start> <itemsPerResponse> <taggedParameters>`

The `readdirectory` query allows to browse filesystems from the server's point of view. This can be used to eg. select music folders. Local filesystems are supported, as are UNC paths on Windows systems (eg. \\server\musicshare).

Please note that on Windows systems the back slashes must either be escaped or replaced by normal slashes. The above path would better be written `//server/musicshare.`

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `folder` | the path to the folder to be displayed, eg. c:/music, /Users/mh/Music, //server/share etc. |
| `filter` | Filter the output according to one of the following keywords (regular expressions can be used): |
| `filter:foldersonly` | list folders only | 
| `filter:filesonly` | list files only| 
| `filter:musicfiles` | list all files  considered music files by the server; this is the same filter as is used when scanning the disk for music |
| `filter:filetype:xyz` | list file type .xyz only |
| `filter:xyz` | any expression filter path/filenames |


**Returned tagged parameters:**

| Tag | Description |
|---|---| 
| `item` | The folder's item: folder, files etc. |
| `isfolder` | A flag whether an item is a folder or not. |

Example:
```
Request: "readdirectory 0 10 folder://media/mp3"
Response: "readdirectory 0 10 folder%3A%2F%2Fmedia%2Fmp3 count%3A251 item%3A%5C%5Cmedia%5Cmp3%5CAerosmith isfolder%3A1 item%3A%5C%5Cmedia%5Cmp3%5CAir isfolder%3A1 item%3A%5C%5Cmedia%5Cmp3%5CAlanis%20Morissette isfolder%3A1 item%3A%5C%5Cmedia%5Cmp3%5CAldo%20Romano%2C%20Michel%20Benita%2C%20Glenn%20Ferris%2C%20Paolo%20Fresu isfolder%3A1 item%3A%5C%5Cmedia%5Cmp3%5CAli%20Farka%20Toure isfolder%3A1 item%3A%5C%5Cmedia%5Cmp3%5CAll%20Saints isfolder%3A1 item%3A%5C%5Cmedia%5Cmp3%5CManu%20Katche isfolder%3A1 item%3A%5C%5Cmedia%5Cmp3%5CSinead%20O'Connor isfolder%3A1 item%3A%5C%5Cmedia%5Cmp3%5CShakira isfolder%3A1 item%3A%5C%5Cmedia%5Cmp3%5CAnastacia isfolder%3A1"
```