---
layout: default
title: Using the command-line interface
---

# Using the command-line interface

The complete documentation of the CLI API can be found within your LMS installation (Help->Technical Information->Command Line Interface).

## Telnet

LMS provides a command-line interface to the players via TCP/IP. After starting the server, commands and queries may be sent by connecting to a specific TCP/IP port. The server will reply echoing the request (for commands) or by returning the requested data (for queries). By default, the server will listen for connections on TCP/IP port 9090. This format is designed for ease of integration into AMX, Crestron and other automation systems.

The end of line separator is line feed (<LF\> ASCII decimal 10, hexadecimal 0x0A). The server accepts LF, CR or 0x00 (or any combination thereof) as end of line, and replies with whatever was used for the command. For strings, Logitech Media Server uses the UTF-8 character-set encoding.

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

Mute player `00:04:20:ab:cd:ef`:

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
