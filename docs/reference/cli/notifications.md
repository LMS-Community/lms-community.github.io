---
layout: default
title: CLI - Notifications
---

# Notifications

All commands listed in this document are notifications as well as being commands and can be received when using `listen 1` (if they do not originate from the command-line connection that issued them; no command is echoed twice). 

Note that queries (for example, `display ? ?`) are not notified. 

Other available notifications are listed below with their meaning. 

Please note that other notifications or commands may exist, but internal to the server and therefore not documented in this CLI document. Likewise, commands originating from the server may have more parameters than those described in this document, or parameters consisting of internal Perl data structures with strange text representations.

***

## client

`<playerid> client <new|disconnect|reconnect>`

A new client is notified using `client new`. `client disconnect` is sent when a client disconnects. Unless it reconnects (as signaled by `client reconnect`) before a number of minutes, the client will be automatically forgotten by the server (as indicated by command/notification `client forget`.)

***
## rescan done

`rescan done`

This signals the end of a `rescan` or `wipecache`.

***

## library changed

`library changed <0|1>`

This signals the presence or absence of a library has changed.

***

## unknownir

`<playerid> unknownir <ircode> <time>`

This signals an IR code unknown by the server. The syntax is the same than the one used by `ir`- see [Info on `ir` command in Players](players.md#ir).

Note: This is only available on SB Classic, SB Boom and Transporter. SB Touch and SB Radio handle IR codes locally and do not report them to the server anymore.

***
## playlist

Various Notifications related to Playlists

### playlist newsong 

`<playerid> playlist newsong [<current_title>] [<playlist index>]`

This signals the start of a new song, along with its `current_title ` and `playlist index`. For radio stations, only the `current_title` information is provided.

### playlist stop

`<playerid> playlist stop`

### playlist pause

`<playerid> playlist pause <0|1>`

These signal a change in playing status.

***

## prefset

`<playerid> prefset [<namespace>] [<prefname>] [<value>]`

This signals a preference change.

***

## favorites changed

`favorites changed`

Sent everytime the favorite database is changed, for any reason, by any process (so the favorites command below will result in this notification being sent).

***

## alarm

`<playerid> alarm <sound|end|snooze|snooze_end> <id>`

* `alarm sound` is sent when an alarm sounds;
* `alarm end` when an alarm ends;
* `alarm snooze` when an alarm is snoozed;
* `alarm snooze_end` when a snooze ends (and the alarm resumes).
* `id` gives the id of the alarm.

***

## getexternalvolumeinfo

`<playerid> getexternalvolumeinfo <taggedParameters>`

This notification notifies a client that a plugin supports volume change capability for a player. This capability will override (from a user's point of view) the `digitalVolumeControl` flag that indicates whether a player's output is fixed to a certain volume (typically 100%). This will be used by plugins providing external volume control, e.g. for an amplifier (IRBlaster being an example). In this scenario, the volume output of the player is typically fixed but there is still a volume control capability and the plugin controls the amp's volume instead. The purpose of this notification is to let a client know that there is a volume control capability associated with a player.

Sending a `getexternalvolumeinfo` command triggers all plugins supporting the feature to return a notification about their capabilities for each player for which they provide these capabilities. The command may be sent to a specific player but typically a plugin will ignore this and respond to any getexternalvolumeinfo command for each player.

Please note that this notification is only supported by some 3rd party plugins. It's not part of the core server functionality.

Returned tagged parameters:

| Tag | Description |
|---|---|
| `relative` | A boolean value stating that a plugin is able to provide relative volume change capability for this player as in `mixer volume +5` |
| `precise` | A boolean value stating that a plugin is able to provide precise volume change capability for this player as in `mixer volume 75` |
| `plugin` | is an optional string naming the plugin providing the capability |

Example:

```
Request: "getexternalvolumeinfo<LF>"
Response 1: "a5:41:d2:cd:cd:05 getexternalvolumeinfo relative:1 plugin:IRBlaster"
Response 2: "a5:41:d2:cd:cd:05 getexternalvolumeinfo precise:1 plugin:DenonSerial"
```