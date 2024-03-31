---
layout: default
title: CLI - Alarms commands
---

# Alarm commands and queries

Two main commands:- `alarm` and `alarms`

See also 

* [`alarm` under Notifications](notifications.md#alarm).
* [`playerpref` under Players](players.md#playerpref)

***

## alarm

`<playerid> alarm <add|update|delete|enableall|disableall|defaultvolume> <taggedParameters>`

The `alarm` command allows to manipulate player alarms.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `id` | The id of an existing alarm. This value is mandatory unless you `add` a new alarm. |
| `dow` | Day Of Week. 0 is Sunday, 1 is Monday, etc. up to 6 being Saturday. You can define a group of days by concatenating them with `,` as separator. Default: 0-6. |
| `dowAdd` | Add a single day of the week to the alarm list This takes precendence over anything sent in the dow tag. |
| `dowDel` | Removes a single day (0-6) of the week from the alarm list This takes precendence over anything sent in the dow tag. |
| `enabled` | 1 if the alarm is enabled. Default: 0. |
| `repeat` | 1 if the alarm repeats. Default: 1. |
| `time` | Time of the alarm, in seconds from midnight. Mandatory when add command is issued. |
| `volume` | Mixer volume of the alarm.<br>Default: use the default volume for alarms. Mandatory when defaultvolume command is issued. |
| `url` (or `playlisturl`) | URL of the alarm playlist.<br> Default: the current playlist.<br>`url` should be a valid LMS audio url.<br>The special value 0 means the current playlist.<br>You can also use these URLs which trigger various flavours of random play:-<br>`randomplay:track`<br>`randomplay:contributor`<br>`randomplay:album`<br>`randomplay:year` |

See also "favorites items". CLARIFICATION-NEEDED

**Returned tagged parameters:**

| Tag | Description |
|---|---|
| `id` | The id of the newly created or edited alarm. |

Examples:

Defining a new alarm
```
Request: "bd:a5:a9:9b:9d:df alarm add dow:1 enabled:1 playlist:file://some/playlist.m3u time:9000<LF>"
Response: "bd:a5:a9:9b:9d:df alarm add dow:1 enabled:1 playlist:file://some/playlist.m3u time:9000 id:eaf39<LF>"
```

Deleting an alarm
```
Request: "bd:a5:a9:9b:9d:df alarm delete id:eaf39<LF>"
Response: "bd:a5:a9:9b:9d:df alarm delete id:eaf39<LF>"
```

Enabling a previously defined alarm for Mo-Fr
```
Request: "bd:a5:a9:9b:9d:df alarm update id:eaf39 dow:1,2,3,4,5 enabled:1<LF>"
Response: "bd:a5:a9:9b:9d:df alarm update id:eaf39 dow:1,2,3,4,5 enabled:1 count:1 <LF>"
```

***

## alarm playlists

`alarm playlists`

The `alarm playlists` returns all the playlists, sounds, favorites etc. available to alarms.

**Returned tagged parameters:**

| Block | Tag | Description |
|---|---|---|
|First block ||
|| Count | The number of items available |
| For each playlist: | 
|| `title` | The item's name or title
|| `category` | The category under which the item is grouped (eg. Favorites, Natural Sounds etc.)
|| `url` | The item's URL, or the empty value as a placeholder for the current playlist.
|| `singleton` | 1 if the item is the only one in its category, or 0 if there's more than one item.

Example:
```
Request: "alarm playlists 0 3<LF>"
Response: "alarm playlists 0 100 category:The current playlist 
title:Use Current Playlist url: singleton:1 category:Favorites 
title:Random%20Artists url:randomplay://contributor singleton:0 category:Favorites 
title:Random%20Tracks url:randomplay://track singleton:0 count:29 <LF>"
```

***

## alarms

`<playerid> alarms <start> <itemsPerResponse> <taggedParameters>`

The `alarms` query returns information about player alarms. `<start>` is the indexid of the first player to be reported on (eg 0, 1, 2), while `<itemsPerResponse>` is the numbers of players whose information will be returned.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `dow` | If present, the query returns information about this Day Of Week only. Note this takes precedence over any `filter` parameter. 0 is Sunday, 1 is Monday, etc. up to 6 being Saturday. |
| `filter` | Two possible values:<br> `all` returns all alarms,<br>`enabled` returns just those alarms which are enabled. |

**Returned tagged parameters:**

| Block | Preference | Description |
|---|---|---|
| First block 
|| `fade` | 1 if the alarms fade in. |
|| `count` | Number of alarms returned, based on the filters above. |
| For each alarm: | 
|| `dow` | Days Of Week of this alarm. |
|| `enabled` | 1 if the alarm is enabled. |
|| `volume` | Mixer volume of the alarm. |
|| either:`url`| URL of track to be played |
|| or:`playlist` | URL of playlist to be played |

Example:
```
Request: "bd:a5:a9:9b:9d:df alarms 0 3<LF>"
Response: "bd:a5:a9:9b:9d:df alarms 0 3 count:2 fade:0
dow:1 enabled:1 time:3600 volume:50 url:randomplay://track 
dow:5 enabled:1 time:81000 volume:77 playlist url:file:///Volumes/Smurf/playlists/Playlists/AAA.m3u <LF>"
```

## Alarm related Player Preferences

Additionally, the following player preferences control the operation of the alarm and can be set/queried using the `playerpref` command.

This command is described more fully in the Players page. [Jump to `playerpref` under Players](players.md#playerpref)


| Preference | Description |
|---|---|
| `alarmfadeseconds`<br> _(note the case!)_ | Whether alarms should fade in on this player. Despite the name, this preference is only a boolean and does not control the number of seconds over which alarms fade in. Set to 0 to disable fading; 1 to enable it.|
| `alarmTimeoutSeconds` | The number of seconds that an alarm will play for before being automatically stopped. Set to 0 to disable the automatic timeout. |
| `alarmSnoozeSeconds` | The number of seconds that a snooze will last for. |
| `alarmsEnabled` | Whether any alarm can sound on this player. Set to 0 to prevent any alarm from sounding; 1 to allow them to sound. |
| `alarmDefaultVolume` | The volume level (0-100) at which alarms will sound unless they have their own volume specifically set (see `alarm volume`). |


