---
layout: default
title: Using the command-line interface
---

# Using the command-line interface

There are two ways to use the CLI commands: using a raw socket Telnet style connection, or using the JSON/RPC interface over the HTTP protocol.

## Telnet

LMS provides a command-line interface to the players via TCP/IP. After starting the server, commands and queries may be sent by connecting to a specific TCP/IP port. The server will reply echoing the request (for commands) or by returning the requested data (for queries). By default, the server will listen for connections on TCP/IP port 9090. This format is designed for ease of integration into AMX, Crestron and other automation systems.

The end of line separator is line feed (<LF\> ASCII decimal 10, hexadecimal 0x0A). The server accepts LF, CR or 0x00 (or any combination thereof) as end of line, and replies with whatever was used for the command. For strings, LMS uses the UTF-8 character-set encoding.

To use the command line interface interactively, use the telnet command from your system's command prompt: `telnet localhost 9090` and when it connects, you can start typing commands. Beware that the server expects parameters to be encoded using percent-style escaping (the same method as is used in URLs); `"` and `\\` are not supported as in shell-like environments.

For debugging purposes, CLI formatted commands can be sent using standard in and out. This support is only available on Unix platforms (MacOS X included), and must be enabled by launching the server with the `--stdio` command line option.

## jsonrpc.js

You can alternatively use a JSON-RPC 1.0 API over HTTP to interact with the CLI. This employs POST requests sent to `http://<server>:<port>/jsonrpc.js`, where port is the normal 9000 http port instead of the 9090 CLI port.

The Content-Type header should be "application/json" and the body of the request should include a JSON-encoded object which includes an array containing the extended query format parameters (see section Command format) as follows:

> **`{"id": 1, "method": "slim.request", "params": [ <playerid>, [<command>, <start>, <itemsPerResponse>, <p3>, ... <pN> ]]}`**

The response will be a JSON-encoded object which echoes the params/id/method parameters from the request, with the requested data present in the "result" object.

Example:

> **`curl -g -X POST -d '{"id":1,"method":"slim.request","params":["00:04:20:ab:cd:ef",["playlist","name","?"]]}' http://192.168.1.1:9000/jsonrpc.js`**

Response:

> **`{ "params":["00:04:20:ab:cd:ef",["playlist","name","?"]],"result":{"_name":"Daily Mix"},"id":"1","method":"slim.request"}`**

For commands that are global to the server and do not require a `<playerid>`, you can substitute 0. There is no error handling when malformed or invalid requests are attempted — there will either be an empty response {} or you'll observe an ECONNRESET error.

Note that percent-style encoding of parameters is not needed when using jsonrpc.js.

## Examples

### Mute a player

The `mixer muting` command mutes or unmutes the player. Use `0` to unmute, `1` to mute, `?` to query and no parameter (or `toggle`) to toggle the muting state of the player.

Mute player `00:04:20:ab:cd:ef`

=== "curl"

    ```sh
    curl -g -X POST -d '{"id":1,"method":"slim.request","params":["00:04:20:ab:cd:ef",["mixer","muting","1"]]}' http://192.168.1.1:9000/jsonrpc.js
    ```

=== "wget"

    ```sh
    wget -q -O- --post-data='{"id":1,"method":"slim.request","params":["00:04:20:ab:cd:ef",["mixer","muting","1"]]}' http://192.168.1.1:9000/jsonrpc.js
    ```

=== "nc / ncat"

    ```sh
    printf "00:04:20:ab:cd:ef mixer muting 1\n" | nc 192.168.1.1 9090
    ```

The response you will get looks like `{"id":1,"method":"slim.request","result":{"_muting":"1"},"params":["00:04:20:ab:cd:ef",["mixer","muting","?"]]}` in the case of curl or wget or `00:04:20:ab:cd:ef mixer muting 1` in the case of ncat.

### Skip to the next track

The `playlist index` command sets or queries the song that is currently playing by index. When setting, a zero-based value may be used to indicate which song to play. An explicitly positive or negative number may be used to jump to a song relative to the currently playing song.

Skip to the next track on player `00:04:20:ab:cd:ef`:

=== "curl"

    ```sh
    curl -g -X POST -d '{"id":1,"method":"slim.request","params":["00:04:20:ab:cd:ef",["playlist","index","+1"]]}' http://192.168.1.1:9000/jsonrpc.js
    ```

=== "wget"

    ```sh
    wget -q -O- --post-data='{"id":1,"method":"slim.request","params":["00:04:20:ab:cd:ef",["playlist","index","+1"]]}' http://192.168.1.1:9000/jsonrpc.js
    ```

=== "nc / ncat"

    ```sh
    printf "00:04:20:ab:cd:ef playlist index +1\n" | nc 192.168.1.1 9090
    ```

***
## Command format

General command and query format
The format of the commands, queries and server replies is as follows:

`[<playerid>] <p0> <p1> ... <pN> <LF>`

where:

>`<playerid>` is the unique identifier for the player, usually (but not guaranteed to be) the MAC address of the player. Some commands are global to the server and do not require a `<playerid>`. For commands requiring it, a random player will be selected by the server if the `<playerid>` is omitted, and returned in the server reply. `<playerid>` may be obtained by using the `player id` or `players` queries.

>`<p0>` through `<pN>` are positional parameters. Pass a `?` to obtain a value for that parameter in the server response (i.e. send a query). Details of the parameters vary for each command as described below.

Each parameter needs to be encoded using percent-style escaping, the same method as is used in URLs; for example, `The Clash?` would be encoded as `The%20Clash%3F`. This also applies to `<playerid>`. In the examples below, the escaping is not shown for readability (except `%20` for space).

## Extended query format

A few extended queries are defined, to regroup multiple queries and allow browsing the server database. These queries return multiple items. Overall however, their format is compliant with the general command format above:

`[<playerid>] <command> <start> <itemsPerResponse> <p3> ... <pN> <LF>`

where:

>`<playerid>` is the unique identifier for the player, as above.

>`<command>` is the query name.

>`<start>` and `<itemsPerResponse>` are positional parameters that control the response chunking. `<start>` is a zero-based index of the first item to return, and `<itemsPerResponse>` is the number of items to return, if possible.

>`<p3>` through `<pN>` are tagged parameters. Tags consist of a name followed by `:`. For example, `artist:Abba`. The tag and the `:` are URL escaped with the field value. Tag names cannot contain `:` but the data can.

to which the server replies:

`[<playerid>] <command> <start> <itemsPerResponse> <p3> ... <pN> <pN+1> ... <pM> <LF>`

where:

>The entire query is repeated.

>`<pN+1>` through `<pM>` is the tagged returned data. A special tag value is defined in each command to separate the multiple returned items. Data is only returned when applicable, that is, all possible tags are not always returned.

If the `<itemsPerResponse>` positional parameter and all tagged parameters are omitted then all possible items are returned.

Example:

The `players` command returns data on all players known by the server. It is a shortcut call compared to the general CLI API `player count ?` followed by a number of calls to get the players name, ID, etc. The command must be called with the chunking parameters. For example, the following returns information on the first 2 players known by the server (if so many exist), starting from the first one:

```
Request: "players 0 2<LF>"
Response: "players 0 2 count:2 playerindex:0 playerid:a5:41:d2:cd:cd:05 ip:127.0.0.1:60488 name:127.0.0.1 model:softsqueeze displaytype:graphic-280x16 connected:1 playerindex:1 playerid:00:04:20:02:00:c8 ip:192.168.1.22:3483 name:Movy model:slimp3 displaytype:noritake-katakana connected:1<LF>"
```

***
## Extended command format

Extended commands are commands that reuse the general principle of tagged parameters as introduced by extended queries:

`[<playerid>] <command> <p1> ... <pN> <LF>`

where:

>`<playerid>` is the unique identifier for the player, as above.

>`<command>` is the command name.

>`<p1>` through `<pN>` are tagged parameters as defined above.

The server performs the command and returns:

`[<playerid>] <command> <p1> ... <pN> <pN+1> ... <pM> <LF>`

where:

>The entire query is repeated.

>`<pN+1>` through `<pM>` is the tagged returned data. See the command description for definitions. In general commands do return some information about the command performed.


***
## Notes

### Security Settings
The Security settings of the server preferences apply to CLI connections when they are established. A change in security settings does not affect established connections. The connection is only accepted from allowed hosts. If password protection is enabled, the `login` command must be the first command sent after the connection. Any error in the user and/or password, or using any other command as the first one, results in the server disconnecting.

### LMS Preferences apply to CLI

All LMS preferences apply to the CLI data. For examples, the preference about composers appearing in the artists list applies to the data returned by the `artists` query.

### Reative Paths for Songs or Playlists

Commands that use paths to songs or playlists (<item> parameters below) can use relative paths from the root of the Music Library folder to specify songs. For example, if the Music Library is specified as `D:\mymusic` and you'd like to refer to a song in that folder named `foo.mp3` you can specify just `foo.mp3` in the command parameter. Likewise, to refer to items in the Saved Playlist folder, you can use a prefix of `__playlists/` before the path. For example, to refer to the saved playlist `bar.m3u` in the Saved Playlists folder, you can specify a path of `__playlists/bar.m3u`.

### Cover Art

The HTTP server can return cover art for songs using the track ID as returned by the CLI functions. If no cover art exists for the given song, the server returns a special "no artwork" image. Please refer to the Artwork Setup documentation for more details on artwork management in LMS.

Use the following URL:
`http://<server>:<port>/music/<track_id>/cover.jpg`

where:

>`<server>` is the ip address or name of the server.

>`<port>` is the HTTP port of the server (not the same as the CLI port).

>`<track_id>` is the track ID as returned by the CLI functions.

In addition, there is a shortcut URL to return the artwork of the currently playing song for a player:

`http://<server>:<port>/music/current/cover.jpg?player=<playerid>`

where:

>`<server>` is the ip address or name of the server.

>`<port>` is the HTTP port of the server (not the same as the CLI port).

>`<playerid>` is the unique identifier for the player, as above. If omitted, the server will use a random player.

### Positional Parameters

For commands using positional parameters, any extra parameters (after all required ones) will be returned. For commands using tagged parameters, parameters using unknown tags will be returned as well. This allows the client to add to commands and queries some context information.

For example:
```
Request: "04:20:00:12:23:45 mixer bass ? context<LF>"
Response: "04:20:00:12:23:45 mixer bass 98 context<LF>"

Request: "players 0 2 context:1<LF>"
Response: "players 0 2 context:1 count:2 id:00:04:20:02:00:c8 ...(same as above)"
```

### Returned URLs, escaping

All paths returned as URLs, for example the ones returned by the query [`songinfo`](database.md/#songinfo) are double URL escaped. To get a useable path (that you can use with your file system), you will need to unescape the field twice. Also note the URLs are not translated or re-encoded: they use the encoding of the underlying filesystem API, typically (but not necessarily) the current locale.

### Transporter Digital Inputs

Transporter Digital Inputs are handled as remote streams, with a URL starting with source: followed by `aes-ebu`, `bnc-spdif`, `toslink` or `rca-spdif`.

To set Transporter to the TOSLINK input, use `<playerid> playlist play source:toslink<LF>`.

When set to a digital input, Transporter reports the URL scheme above to the various path, url or status queries.