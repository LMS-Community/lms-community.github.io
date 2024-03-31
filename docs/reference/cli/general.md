---
layout: default
title: CLI - General commands
---

# General commands

***

## login
`login <user> <password>`

The `login` command allows the caller to authenticate itself on the server, as defined in the Security pane of the server preferences. Like any other command, the user and password must be escaped. If successful, the server replaces the password with 6 star characters. If unsuccessful, the server returns the same, then disconnects. If security is off this command is always successful.

Examples:

```
Request: "login user correctpassword<LF>"
Response: "login user ******<LF>"

Request: "login user wrongpassword<LF>"
Response: "login user ******<LF>" (Connection terminated)
```
***

## can 
`can <request terms> ?`

The `can` query allows the caller to determine if the command or query indicated by <request terms> is available.

Examples:

```
Request: "can info total genres ?<LF>"
Response: "can info total genres 1<LF>"

Request: "can smurf ?<LF>"
Response: "can smurf 0<LF>"
```
***

## version
`version ?`

The `version` query returns version number of the server.

Examples:

```
Request: "version ?<LF>"
Response: "version 6.5<LF>"
```
***

## listen
`listen <0|1|?>`

The `listen` command enables to receive asynchronously internal server commands (notifications) on the CLI connection. Notifications concern all activity in the server, not just the activity triggered by the command-line. Use `0` to clear, `1` to set, `?` to query, and no parameter to toggle the listen state of the command-line connection.

If only certain notifications are of interrest, consider using the `subscribe` command below. The `listen` command shares some of its internal plumbing with `subscribe` so using `subscribe xxx` changes the list of echoed notifications from nothing or everything to only xxx.

Please consult section [Notifications](notifications.md) for a list of possible notifications.

Examples:

```
Request: "listen 1<LF>"
Response: "listen 1<LF>"
"04:20:00:12:23:45 mixer volume 25<LF>"
"04:20:00:12:23:45 pause<LF>"
```
***

## subscribe
`subscribe <comma_separated_notification_list>`

The `subscribe` command is similar to `listen` but echoes only a subset of the notifications, indicated by a comma separated list. If no list is provided, the notifications are turned off. This command shares some of its internal plumbing with `listen` so using `listen 0` or `listen 1` changes the list of echoed notifications (to nothing and everything, respectively).

Please consult section [Notifications](notifications.md) for a list of possible notifications.

Examples:

```
Request: "subscribe mixer,pause<LF>"
Response: "subscribe mixer,pause<LF>"
"04:20:00:12:23:45 mixer volume 25<LF>"
"04:20:00:12:23:45 pause<LF>"
```
***

## pref
`pref <prefname|namespace:prefname> <prefvalue|?>`

The `pref` command allows the caller to set and query the server's internal preference values. The following affect the behaviour of CLI queries and commands:

* `authorize`: Security enabled or not. If enabled, usage of the `login` command is required.
* `groupdiscs`: handling of multiple disc sets. Affects the `albums` query.
* `variousArtistAutoIdentification`: compilation artists are listed as `Various Artists`. Affects the `artists` query.
* `splitList`: delimiter for multiple items in tags. Affects all the queries returning genres, mainly `genres`.
* `composerInArtists`, `conductorInArtists`, `bandInArtists`: determines which contributors are considered artists. Affects the `info total artists ?` query.

If you want to query/set a preference from a namespace other than `server` (eg. a plugin), you'll have to prepend the desired namespace to the prefname.

Examples:

```
Request: "pref audiodir ?<LF>"
Response: "pref audiodir %2fUsers%2fdean%2fDesktop%2ftest%20music<LF>"

Request: "pref plugin.rescan:time ?<LF>"
Response: "pref plugin.rescan:time 32400<LF>"

Request: "pref playlistdir %2fUsers%2fdean%2fplaylists<LF>"
Response: "pref playlistdir %2fUsers%2fdean%2fplaylists<LF>"
```
***

## pref validate
`pref validate <prefname|namespace:prefname> <prefvalue>`

The `pref validate` command allows the caller to validate a server's internal preference value without setting it.

If you want to validate a preference from a namespace other than `server` (eg. a plugin), you'll have to prepend the desired namespace to the prefname.

Examples:
```
Request: "pref validate bufferSecs 10"
Response: "pref validate bufferSecs valid:1"

Request: "pref validate audiodir %2fsome%2fincorrect%2ffilepath"
Response: "pref validate audiodir valid:0"
```
***

## artworkspec
`artworkspec add <specification> <name>`

The `artworkspec` command allows the caller to set custom artwork resizing specifications. These are used during a media scan to pre-cache artwork in the given size and format. The name is optional, but allows to recognize, which client would have registered a specification.

Example:

```
artworkspec add 300x300_p My%20Favorite%20Controller%20App
```
***

## logging
`logging <group:logging group> [<persist:1>]`

The `logging` command allows setting some logging levels. Today you can only set one of the following logging groups: server, radio, transcoding, scanner. The optional persist parameter defines whether the change should be persistent or not.

Examples:

```
Request: "logging group:scanner<LF>"
Response: "logging group:scanner<LF>"
```
***

## getstring
`getstring <STRINGTOKEN1[,STRINGTOKEN2...]>`

The `getstring` command allows the caller to query one or several localized strings. String tokens can be passed as a single, concatenated value.

Examples:

```
Request: "getstring HOME <LF>"
Response: "getstring HOME:Startseite <LF>"

Request: "getstring SETTINGS,SCREENSAVERS,HOME <LF>"
Response: "getstring SETTINGS:Einstellungen SCREENSAVERS:Bildschirmschoner HOME:Startseite <LF>"
```
***

## debug
`debug <debug category> <OFF|FATAL|ERROR|WARN|INFO|DEBUG|?|>`

The `debug` command allows the caller to query or set the server's internal debugging categories. 

* Use 'OFF' to silence,
* 'FATAL' for only seeing fatal errors,
* 'ERROR' for non-fatal errors, etc.
* Finally, using ? will query the current level for the category. 

Valid categories can be found under Settings/Advanced/Logging.

Examples:

```
Request: "debug d_files ?<LF>"
Response: "debug d_files 0<LF>"

Request: "debug d_itunes 0<LF>"
Response: "debug d_itunes 0<LF>"

Request: "debug d_stream 1<LF>"
Response: "debug d_stream 1<LF>"

Request: "debug d_stream<LF>"
Response: "debug d_stream 0<LF>"
```
***

## exit
`exit`

The `exit` command closes the TCP connection with the server and terminates the Command Line Interface session.

Example:

```
Request: "exit<LF>"
Response: "exit<LF>"
(Connection terminated)
```

## stopserver
`stopserver`

The `stopserver` command shuts down the server.

Example:
```
Request: "stopserver<LF>"
Response: "stopserver<LF>"
(Connection terminated)
```

## retartserver
`restartserver`

The `restartserver` command restarts the server. Please note that restarting the server using this command is not available on all platforms.

Example:
```
Request: "restartserver<LF>"
Response: "restartserver<LF>"
(Connection terminates and server is being restarted)
```