---
layout: default
title: CLI - Players commands
---

<style>
    td code {
        word-break: normal !important;
    }
</style>

# Player commands and queries

***

## `player`

Various subcommands which return information about players. Different commands are used to set player attributes.

### `player count`

`player count ?`

The `player count ?` query returns the number of players connected to the server.

Example:
```
Request: "player count ?<LF>"
Response: "player count 2<LF>"
```

### `player id`

`player id <playerindex> ?`

The `player id ?` query returns the unique identifier of a player, (<playerid> parameter of many CLI commands). For physical players this is generally the MAC address. The IP address is used for remote streams.

Example:
```
Request: "player id 0 ?<LF>" (or) "0 player id ?"
Response: "player id 0 04:20:00:12:23:45<LF>"
```

### `player uuid`

`<playerindex> player uuid ?`

The `player uuid ?` query returns the player uuid.

Example:
```
Request: "player uuid 0 ?<LF>" (or) "0 player uuid ?"
Response: "player uuid 0 012345678901234567890123456789012<LF>"
```

### `player name`

`player name <playerindex|playerid> ?`

The `player name ?` query returns the human-readable name for the specified player. If the name has not been specified by the user in the Player Settings, then a default name will be used, usually the IP address.

Example:
```
Request: "player name 0 ?<LF>" or "0 player name ?"
Response: "player name 0 Living Room<LF>"
```

### `player ip`

`player ip <playerindex|playerid> ?`


The `player ip ?` query returns the IP address (along with port number) of the specified player.

Example:
```
Request: "player ip 0 ?<LF>" or "0 player ip ?"
Response: "player ip 0 192.168.1.22:3483<LF>"
```

### `player model`

`player model <playerindex|playerid> ?`

The `player model ?` query returns the model of the player, currently one of `transporter`, `squeezebox2`, `squeezebox`, `slimp3`, `softsqueeze`, or `http` (for remote streaming connections).

Example:
```
Request: "player model 0 ?<LF>" or "0 player model ?"
Response: "player model squeezebox<LF>"
```

### `player isplayer`

`player isplayer <playerindex|playerid> ?`

Whether a player is a known player model. Currently know models are `transporter`, `squeezebox2`, `squeezebox`, `slimp3`, `softsqueeze`, or `http` (for remote streaming connections). Will return `0` for streaming connections.

Example:
```
Request: "player isplayer 0 ?<LF>" or "0 player isplayer ?"
Response: "player isplayer 1<LF>"
```

### `player displaytype`

`player displaytype <playerindex|playerid> ?`

The `player displaytype ?` query returns the display model of the player. Graphical display types start with `graphic-`, non-graphical display type with `noritake-`.

Example:
```
Request: "player displaytype 0 ?<LF>" or "0 player displaytype ?"
Response: "player displaytype 0 noritake-katakana<LF>"
```

### `player canpowerpoff`

`player canpoweroff <playerindex|playerid> ?`

Returns whether a player can be powered off or not. Current hardware players and SoftSqueeze would return `1`, web clients `0`.

Examples:
```
Request: "player canpoweroff 04:20:00:12:23:45 ?<LF>"
Response: "player canpoweroff 04:20:00:12:23:45 1<LF>"

Request: "player canpoweroff 192.168.0.39 ?<LF>"
Response: "player canpoweroff 192.168.0.39 0<LF>"
```

***
## `signalstrength`

`<playerid> signalstrength ?`

Returns the wireless signal strength for the player, range is `1` to `100`. Returns `0` if not connected wirelessly.

Example:
```
Request: "04:20:00:12:23:45 signalstrength ?<LF>"
Response: "04:20:00:12:23:45 signalstrength 76<LF>"
```

***
## `name`

`<playerid> name <newname|?>`

Sets the name of the player. You may query the player name by passing in `?` (equivalent to `player name ?`.)

Example:
```
Request: "04:20:00:12:23:45 name ?<LF>"
Response: "04:20:00:12:23:45 name Lightyears<LF>"

Request: "04:20:00:12:23:45 name Buzz<LF>"
Response: "04:20:00:12:23:45 name Buzz<LF>"
```

***
## `connected`

`<playerid> connected ?`

Returns the connected state of the player, `1` or `0` depending on the state of the TCP connection to the player. SLIMP3 players, since they use UDP, always return `1`.

Examples:
```
Request: "04:20:00:12:23:45 connected ?<LF>"
Response: "04:20:00:12:23:45 connected 1<LF>"
```

***
## `sleep`

`<playerid> sleep <number|?>`

The `sleep` command specifies a number of seconds to continue playing before powering off the player. You may query the amount of time until the player sleeps by passing in `?`.

Examples:
```
Request: "04:20:00:12:23:45 sleep ?<LF>"
Response: "04:20:00:12:23:45 sleep 105.3<LF>"

Request: "04:20:00:12:23:45 sleep 300<LF>"
Response: "04:20:00:12:23:45 sleep 300<LF>"
```

***
## `sync`

`<playerid> sync <playerindex|playerid|-|?>`

The `sync` command specifies the player to synchronise with the given playerid. The command accepts only one playerindex or playerid. To unsync the player, use the `-` parameter.

Note that in both cases the first `<playerid>` is the player which is already a member of a sync group. When adding a player to a sync group, the second specified player will be added to the group which includes the first player, if necessary first removing the second player from its existing sync-group.

You may query which players are already synced with this player by passing in a `?` parameter. Multiple playerids are separated by a comma. If the player is not synced, `-` is returned.

Examples:
```
Request: "04:20:00:12:23:45 sync 1<LF>"
Response: "04:20:00:12:23:45 sync 1<LF>"

Request: "04:20:00:12:23:45 sync ?<LF>"
Response: "04:20:00:12:23:45 sync 04:20:00:12:23:21<LF>"

Request: "04:20:00:12:23:45 sync -<LF>"
Response: "04:20:00:12:23:45 sync -<LF>"
```

***
## `syncgroups`

`syncgroups ?`

The `syncgroups` query returns a comma separated list of sync groups members (IDs and names).

Examples:
```
Request: "syncgroups ?<LF>"
Response: "syncgroups sync_members:04:20:00:12:23:45,04:20:00:12:34:56 sync_member_names:Living%20Room,Kitchen<LF>"
```

***
## `power`

`<playerid> power <0|1|?|>`

The `power` command turns the player on or off. Use `0` to turn off, `1` to turn on, `?` to query and no parameter to toggle the power state of the player.
For remote streaming connections, the command does nothing and the query always returns `1`.

Examples:
```
Request: "04:20:00:12:23:45 power 1<LF>"
Response: "04:20:00:12:23:45 power 1<LF>"

Request: "04:20:00:12:23:45 power ?<LF>"
Response: "04:20:00:12:23:45 power 1<LF>"
```

***
## `mixer`

Various subcommands which return or set mixer settings.

### `mixer volume`

`<playerid> mixer volume <0 .. 100|-100 .. +100|?>`

The `mixer volume` command returns or sets the current volume setting for the player. The scale is `0` to `100`, in real numbers (i.e. `34.5` is valid). If the player is muted, the volume is returned as a negative value. Note that players display a `0` to `40` scale, that is, the `0..100` volume divided by `2,5` (two and a half). Likewise, using the `button` command with `volume_up` or `volume_down` parameters increases or decreases the volume by 2,5 (two and a half).

Examples:
```
Request: "04:20:00:12:23:45 mixer volume ?<LF>"
Response: "04:20:00:12:23:45 mixer volume 98<LF>"

Request: "04:20:00:12:23:45 mixer volume 25<LF>"
Response: "04:20:00:12:23:45 mixer volume 25<LF>"

Request: "04:20:00:12:23:45 mixer volume +10<LF>"
Response: "04:20:00:12:23:45 mixer volume +10<LF>"
```

### `mixer muting`

`<playerid> mixer muting <0|1|toggle|?|>`

The `mixer muting` command mutes or unmutes the player. Use `0` to unmute, `1` to mute, `?` to query and no parameter (or 'toggle') to toggle the muting state of the player. Note also the `mixer volume` command returns a negative value if the player is muted.

Example:
```
Request: "04:20:00:12:23:45 mixer muting<LF>"
Response: "04:20:00:12:23:45 mixer muting<LF>"
```

### `mixer bass`

`<playerid> mixer bass <0 .. 100|-100 .. +100|?>`

The `mixer bass` command returns or sets the current bass setting for the player. This is only supported by SliMP3 and SqueezeBox (SB1) players. For more information on the `0 to 100` scale, please [refer to the `mixer volume` command](#mixer-volume).

Example:
```
Request: "04:20:00:12:23:45 mixer bass ?<LF>"
Response: "04:20:00:12:23:45 mixer bass 98<LF>"

Request: "04:20:00:12:23:45 mixer bass 25<LF>"
Response: "04:20:00:12:23:45 mixer bass 25<LF>"

Request: "04:20:00:12:23:45 mixer bass +10<LF>"
Response: "04:20:00:12:23:45 mixer bass +10<LF>"
```

### `mixer treble`

`<playerid> mixer treble <0 .. 100|-100 .. +100|?>`

The `mixer treble` command returns or sets the current treble setting for the player. This is only supported by SliMP3 and SqueezeBox (SB1) players. For more information on the `0 to 100` scale, please [refer to the `mixer volume` command](#mixer-volume).

Example:
```
Request: "04:20:00:12:23:45 mixer treble ?<LF>"
Response: "04:20:00:12:23:45 mixer treble 98<LF>"

Request: "04:20:00:12:23:45 mixer treble 25<LF>"
Response: "04:20:00:12:23:45 mixer treble 25<LF>"

Request: "04:20:00:12:23:45 mixer treble +10<LF>"
Response: "04:20:00:12:23:45 mixer treble +10<LF>"
```

### `mixer pitch`

`<playerid> mixer pitch <80 .. 120|-40 .. +40|?>`

The `mixer pitch` command returns or sets the current pitch setting for the player (only supported by SqueezeBox (SB1) players).

Example:
```
Request: "04:20:00:12:23:45 mixer pitch ?<LF>"
Response: "04:20:00:12:23:45 mixer pitch 98<LF>"

Request: "04:20:00:12:23:45 mixer pitch 80<LF>"
Response: "04:20:00:12:23:45 mixer pitch 80<LF>"

Request: "04:20:00:12:23:45 mixer pitch +10<LF>"
Response: "04:20:00:12:23:45 mixer pitch +10<LF>"
```

***
## `show`

`<playerid> show <taggedParameters>`

The `show` command displays a message on the player display for a given duration. Various options are provided to customize the appearance of the message (font size, centering). If the mesage is too long to fit on the display, it scrolls.

This command is designed to display the message, and by default temporarily cancels any screensaver and increases the brightness to the maximum value.

This command is only echoed once the message display is done.

Please note the CLI expects parameters to be encoded using percent-style escaping (see above): space is represented by `%20`. See the examples.

**Accepted tagged parameters:**

| Tag | Description |
|---|---|
| `line1` | First line of the display. |
| `line2` | Second line of the display. This is the line used for single line display mode (font = huge). |
| `duration` | Time in seconds to display the message; this time does not take into account any scrolling time necessary, which will be performed to its completion. The default is `3` seconds. |
| `brightness` | Brightness to use to display the message, either 'powerOn', 'powerOff', 'idle' or a value from `0` to `4`. The default value is `4`. The display brightness is reset to its configured value after the message. |
| `font` | Use value `huge` to have `line2` displayed in a large font using the entire display. The actual font used depends on the player model. Otherwise the command uses the standard, `2` lines display font. |
| `centered` | Use value `1` to center the lines on the display. There is no scrolling in centered mode. |
| `screen` | Screen to display text on. Use to display on transporter second screen, i.e. screen:2 |


Examples:
```
Request: "04:20:00:12:23:45 show line1:Hello%20World line2:Second%20line duration:1 centered:1<LF>"
Response: "04:20:00:12:23:45 show line1:Hello%20World line2:Second%20line duration:1 centered:1<LF>"
```

***
## `display`

`<playerid> display <line1> <line2> <duration>`

The `display` command specifies some text to be displayed on the player screen for a specified amount of time (in seconds). Please note the CLI expects parameters to be encoded using percent-style escaping (see above): space is represented by `%20`. See the examples.

Examples:
```
Request: "04:20:00:12:23:45 display Hello World 5<LF>"
Response: "04:20:00:12:23:45 display Hello World 5<LF>"

Request: "04:20:00:12:23:45 display Hello%20World Second%20Line 5<LF>"
Response: "04:20:00:12:23:45 display Hello%20World Second%20Line 5<LF>"
```

***
## `linesperscreen`

`<playerid> linesperscreen ?`

The `linesperscreen` command returns how many lines of text can fit in the display, depending on its current setting or font.

Examples:
```
Request: "04:20:00:12:23:45 linesperscreen ?<LF>"
Response: "04:20:00:12:23:45 linesperscreen 1<LF>"
```

***
## `display`

`<playerid> display ? ?`

The `display ? ?` command may be used to obtain the text that is currently displayed on the screen.

Examples:
```
Request: "04:20:00:12:23:45 display ? ?<LF>"
Response: "04:20:00:12:23:45 display Hello World<LF>"
```

***
## `displaynow`

`<playerid> displaynow ? ?`

The `displaynow` command provides access to the data currently on the display. This differs from the `display ? ?` command in that it returns the latest data sent to the display, including any animation, double-size fonts, etc...

Examples:
```
Request: "04:20:00:12:23:45 displaynow ? ?<LF>"
Response: "04:20:00:12:23:45 display Hello World<LF>"
```

***
## `playerpref`

`<playerid> playerpref <prefname|namespace:prefname> <prefvalue|?>`

The `playerpref` command allows the caller to set and query the server's internal player-specific preferences values.

If you want to query/set a preference from a namespace other than `server` (eg. a plugin), you'll have to prepend the desired namespace to the prefname.

Examples:
```
Request: "04:20:00:12:23:45 playerpref doublesize ?"
Response: "04:20:00:12:23:45 playerpref doublesize 1"

Request: "04:20:00:12:23:45 playerpref doublesize 0"
Response: "04:20:00:12:23:45 playerpref doublesize 0"
```

`<playerid> playerpref validate <prefname|namespace:prefname> <prefvalue>`

The `playerpref validate` command allows the caller to validate a server's internal player-specific preference value without setting it.

If you want to validate a preference from a namespace other than `server` (eg. a plugin), you'll have to prepend the desired namespace to the prefname.

Examples:
```
Request: "04:20:00:12:23:45 playerpref validate scrollPause 3"
Response: "04:20:00:12:23:45 playerpref validate scrollPause valid:1"

Request: "04:20:00:12:23:45 playerpref validate scrollRate fast"
Response: "04:20:00:12:23:45 playerpref validate scrollRate valid:0"
```

***
## `button`

`<playerid> button <buttoncode>`

The `button` command simulates a button press. Valid button codes correspond to the functions defined in the Default.map file.

Example:
```
Request: "04:20:00:12:23:45 button stop<LF>"
Response: "04:20:00:12:23:45 button stop<LF>"
```

***
## `ir`

`<playerid> ir <ircode> <time>`

The `ir` command simulates an IR code. Valid IR codes are defined in the Default.map file.

Example:
```
Request: "bd:a5:a9:9b:9d:df ir 768910ef 11073.575<LF>"
Response: "bd:a5:a9:9b:9d:df ir 768910ef 11073.575<LF>"
```

***
## `irenable`

`<playerid> irenable <0|1|?|>`

The `irenable` command enables or disables IR processing for the player on or off. Use `0` to disable, `1` to enable, `?` to query and no parameter to toggle IR processing of the player.
For remote streaming connections, the command does nothing and the query always returns `1`.

Examples:
```
Request: "04:20:00:12:23:45 irenable 1<LF>"
Response: "04:20:00:12:23:45 irenable 1<LF>"

Request: "04:20:00:12:23:45 irenable ?<LF>"
Response: "04:20:00:12:23:45 irenable 1<LF>"
```
***
## `connect`

`<playerid> connect <ip>`

The `connect` command tells a Squeezebox 2 or newer player to connect to a different server address.

Supported values are:

>ip - A dotted IP address to connect to.

If the player is currently a member of a sync-group, then all players in the sync-group will be instructed to switch to the new server and re-establish the sync-group.

Example:
```
Request: "bd:a5:a9:9b:9d:df connect 192.168.1.10<LF>"
Response: "bd:a5:a9:9b:9d:df connect 192.168.1.10<LF>"
```

***
## `client forget`

`<playerid> client forget`

The `client forget` command deletes the client/player from the server database.

Example:
```
Request: "bd:a5:a9:9b:9d:df client forget<LF>"
Response: "bd:a5:a9:9b:9d:df client forget<LF>"
```

***
## `disconnect`

`disconnect <playerid> <ip>`

The `disconnect` command tells a Squeezebox 2 or newer player on another server instance to disconnect from its server and connect to us. This is the opposite of `connect`, where we tell a player connected to us to connect to a different server.

Supported values are:

>ip - A dotted IP address to connect to.

Example:
```
Request: "disconnect bd:a5:a9:9b:9d:df 192.168.1.10<LF>"
Response: "disconnect bd:a5:a9:9b:9d:df 192.168.1.10<LF>"
```

***
## `players`

`players <start> <itemsPerResponse>`

The `players` query returns information about all `players` (physical players as well as streaming clients) known by the server.

* `players 0` will return info about all players.
* `players 3 2` will return information about two players starting with playerindex 3
* `players 2 1` will return info about the player with playerindex 2


**Accepted tagged parameters:**

| Tag | Description |
|:---|:---|
| playerprefs | Comma separated list of preference values to return (for each player). |


**Returned tagged parameters:**

Results returned as two blocks.

* First a block containing just the count of players
* Secondly a standard set of data for each player
    * Info for each player can in addition include values as per the list of preferences included in the optional playerprefs parameter.

| Block | Tag | Description |
|---|---|---|
| First block: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| count | Number of players known by the server. Equivalent to `player count ?`. |
| For each player: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| playerindex | Player index. Values 0, 1, 2 etc |
|| playerid | Player unique identifier. Equivalent to `player id <playerindex> ?`. |
|| uuid | Player uuid. Equivalent to `player uuid <playerindex> ?`. |
|| ip | Player IP and port. Equivalent to `player ip <playerindex|playerid> ?`. |
|| name | Player name. Equivalent to `player name <playerindex|playerid> ?`. |
|| seq_no | *Not clear what this is.* |
|| model | Player model. Values like `squeezebox3`, `baby`, `squeezelite`. Equivalent to `player model <playerindex|playerid> ?`. |
|| modelname | Model name, values like `Squeezebox Classic`, `Squeeezebox Radio`, `Squeezelite-X`. |
|| power | Indicatess if player is powered on. Returns 1 for True, 0 for False. Equivalent to `<playerid> power ?`. |
|| isplaying | Indicates if player currently playing. Returns 1 for True, 0 for False. |
|| displaytype | Player display type. Not returned for streaming connections. Equivalent to `player displaytype <playerindex|playerid> ?`. |
|| isplayer | Whether a player is a known player model. Will return 0 for streaming connections. Equivalent to `player isplayer <playerindex|playerid> ?`. |
|| canpoweroff | Whether the player can be powered off. This value is false for streaming connections. Equivalent to `player canpoweroff <playerindex|playerid> ?` |
|| connected | Connected state. Equivalent to `<playerid> connected ?`. |
|| firmware | Firmware version |
| For each defined pref requested: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| prefName | Preference value. Only if the value is defined. Equivalent to `<playerid> playerpref <prefname|namespace:prefname> <prefvalue|?>`. |


Examples:
```
Request: "players"
Response: "players  count:3"

Request: "players 0 2 playerprefs:doublesize,idleBrightness<LF>"
Response: "players 0 2 count:2
playerindex:0 playerid:a5:41:d2:cd:cd:05 ip:127.0.0.1:60488 name:127.0.0.1 model:softsqueeze displaytype:graphic-280x16 connected:1 doublesize:0 idleBrightness:2
playerindex:1 playerid:00:04:20:02:00:c8 ip:192.168.1.22:3483 name:Movy model:slimp3 displaytype:noritake-katakana connected:1 doublesize:1 idleBrightness:1
<LF>"

Request: "players 0 4"
Response: "players 0 4 count:4
playerindex:0 playerid:a0:ce:c8:ce:a1:3b uuid: ip:192.168.5.20:50591 name:Squeezelite-X seq_no:0 model:squeezelite modelname:Squeezelite-X power:1 isplaying:1 displaytype:none isplayer:1 canpoweroff:1 connected:1 firmware:v1.9.9-1419
playerindex:1 playerid:00:04:20:28:c7:f1 uuid:ca1c8fbf2d48cbb1c859b5ea7ce4ecf9 ip:192.168.5.102:41372 name:Stalking Horse seq_no:41 model:baby modelname:Squeezebox Radio power:1 isplaying:1 displaytype:none isplayer:1 canpoweroff:1 connected:1 firmware:8.0.1-r16924
playerindex:2 playerid:00:04:20:2a:e0:74 uuid:7147ee259b66f5c9c39c0eb14cfefb5c ip:192.168.5.101:40890 name:Runcible Red seq_no:2 model:baby modelname:Squeezebox Radio power:1 isplaying:0 displaytype:none isplayer:1 canpoweroff:1 connected:1 firmware:8.0.1-r16924
playerindex:3 playerid:00:04:20:12:ae:f5 uuid: ip:192.168.5.103:28931 name:Dittography seq_no:0 model:squeezebox3 modelname:Squeezebox Classic power:1 isplaying:1 displaytype:graphic-320x32 isplayer:1 canpoweroff:1 connected:1 firmware:137<LF>"
```
