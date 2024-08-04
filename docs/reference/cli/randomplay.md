---
layout: default
title: CLI - RandomPlay commands and queries
---

<link rel="stylesheet" href="../cli-doc.css">

# Randomplay commands and queries
***
## randomplay
`<playerid> randomplay <tracks|albums|contributors|year|disable>`

The `randomplay` command starts a random mix of the given type. The
`disable` type would disable continuation of the currently playing
mix. It would cause the current playlist to play to the end and no new
tracks be added.

Example:
```
Request: "04:20:00:12:23:45 randomplay albums<LF>"
Response: "04:20:00:12:23:45 randomplay albums<LF>"
```

## randomplaygenrelist
`<playerid> randomplaygenrelist`

This returns a formatted list of genres which is for use on the Jive
platform.

Example:
```
Request: "04:20:00:12:23:45 randomplaygenrelist<LF>"
Response: "04:20:00:12:23:45 randomplaygenrelist count%3A103
offset%3A0 actions%3AHASH(0xb804350) checkbox%3A1 text%3A80s
actions%3AHASH(0xb8042a8) checkbox%3A1 text%3AAcid%20Jazz
actions%3AHASH(0xb80438c) checkbox%3A1 text%3AAcoustic
actions%3AHASH(0xb804494) checkbox%3A0 text%3AAdvertisement
actions%3AHASH(0xb8cdcc0) checkbox%3A1 text%3AAfropop
actions%3AHASH(0xb8cdf9c) checkbox%3A1 <LF>"
```

## randomplaychoosegenre
`<playerid> randomplaychoosegenre <0|1>`

Turn a particular genre on/off in random mix.

Example:
```
Request: "04:20:00:12:23:45 randomplaychoosegenre Afropop 1<LF>"
Response: "04:20:00:12:23:45 randomplaychoosegenre Afropop 1<LF>"
```

## randomplaygenreselectall
`<playerid> randomplaygenreselectall <0|1>`

Turn all genres on/off in random mix.

Example:
```
Request: "04:20:00:12:23:45 randomplaygenreselectall 1<LF>"
Response: "04:20:00:12:23:45 randomplaychoosegenre 1<LF>"
```

## randomplayisactive
`<playerid> randomplayisactive`

Get to know whether RandomPlay is active for a given player, and what
kind of mix it's playing.

Example:
```
Request: "04:20:00:12:23:45 randomplaygisactive"
Response: "04:20:00:12:23:45 randomplayisactive album"
```
