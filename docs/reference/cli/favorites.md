---
layout: default
title: CLI - Favorites commands and queries
---

<link rel="stylesheet" href="../cli-doc.css">

# Favorites commands and queries

***
## favorites items
`favorites items <start> <itemsPerResponse> <taggedParameters>`

The `favorites items` query returns all server favorites.

**Accepted tagged parameters:**

| Tag | Description|
|---|---|
| `item_id`   |The id of a favorite to be returned. The id represents the hierarchical structure of the file using a dotted syntax similar to the one used in SNMP, like eg. 2.0.9.3 |
| `search`    |When a list of items is to be returned, it can be filtered by its name or title.|
| `want_url`  |If set to 1, urls are returned by the query, otherwise they aren't.|
| `feedMode`  |If set to 1, the entire nested hierarchy of favorites is returned. In this case, the type will be opml and the nested sub-items will be in each level's items array.|

**Returned tagged parameters:**

| Block | Tag | Description |
|---|---|---|
| First block: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `count` | The number of items available at the selected level. |
| For each element: {: colspan=3} |&#8288 {: style="padding:0"}|&#8288 {: style="padding:0"}|
|| `id` | An item's hierarchical id. Item delimiter. |
|| `name` |  An item's (favorite or folder) name. |
|| `hasitems` | Whether or not an item has sub-items. May indicate the number of sub-items. |
|| `url` | URL of the station or track (only returned if parameter `want_url` is set to 1). Although, the station can be played using the [playlist play](./playlist.md#playlist-play) command, an equivalent command that operates on the id is provided below. |

***
## favorites exists
`favorites exists <id | url>`

The `favorites exists` command is used to check whether a given track
ID or URL exists in favorites.

**Returned tagged parameters:**

| Tag      | Description                                                 |
|----------|-------------------------------------------------------------|
| `exists` | Returned with value 1 if the ID or URL exists in favorites. |
| `index`  | If exists is 1, the index of the ID or URL in favorites.    |

Example:
```
Request: "favorites exists file:///... <LF>"
Response: "favorites exists file:///... exists:1 index:5<LF>"
```

***
## favorites add
`favorites add <taggedParameters>`

The `favorites add` command adds a favorite.

**Accepted tagged parameters:**

| Tag       | Description                              |
|-----------|------------------------------------------|
| `item_id` | The id of a favorite to be inserted. The id represents the hierarchical structure of the file using a dotted syntax similar to the one used in SNMP, like eg. 2.0.9.3.<br>Room is made to accommodate the new favorite. If no item_id is provided, the favorite is added at position 0. | 
| `title`   | Favorite title (mandatory)               |
| `url`     | Favorite url (mandatory)                 |
| `icon`    | Optional URL to an icon to be used with this favorite. |

**Returned tagged parameters:**

| Tag     | Description                                                  |
|---------|--------------------------------------------------------------|
| `count` | Returned with value 1 if adding the favorite was successful. |

Example:
```
Request: "favorites add url:file:///... title:BestSong<LF>"
Response: "favorites add url:file:///... title:BestSong
count:1<LF>"
```

*** 
## favorites addlevel
`favorites addlevel <taggedParameters>`
The `favorites addlevel` command adds a favorite level (a folder).

**Accepted tagged parameters:**

| Tag     | Description                         |
|---------|-------------------------------------|
| item_id | The id of a level to be inserted. The id represents the hierarchical structure of the level using a dotted syntax similar to the one used in SNMP, like eg. 2.0.9.3.<br>Room is made to accommodate the new level. If no item_id is provided, the level is added at position 0. |
| title   | Level title (mandatory)             |

**Returned tagged parameters:**

| Tag   | Description                                               |
|-------|-----------------------------------------------------------|
| count | Returned with value 1 if adding the level was successful. |
       
Example:
```
 Request: "favorites addlevel title:Favourites<LF>"
 Response: "favorites addlevel title:Favourites count:1<LF>"
```

***
## favorites delete
`favorites delete <taggedParameters>`

The `favorites delete` command deletes a favorite or a level.

**Accepted tagged parameters:**

| Tag     | Description                         |
|---------|-------------------------------------|
| item_id | The id of a favorite or level to be deleted. The id represents the hierarchical structure of the file using a dotted syntax similar to the one used in SNMP, like eg. 2.0.9.3.<br>This parameter is mandatory. |

Example:
```
Request: "favorites delete item_id:1.2.3.4.5<LF>"
Response: "favorites delete item_id:1.2.3.4.5<LF>"
```

***
## favorites rename
`favorites rename <taggedParameters>`

The `favorites rename` command renames a favorite or a level.

**Accepted tagged parameters:**

| Tag     | Description                         |
|---------|-------------------------------------|
| item_id | The id of a favorite or level to be renamed. The id represents the hierarchical structure of the file using a dotted syntax similar to the one used in SNMP, like eg. 2.0.9.3.<br>This parameter is mandatory.  |
| title   | The new title to rename this item to. This parameter is mandatory. |

Example:
```
Request: "favorites rename item_id:1.2.3.4.5 title:NewTitle<LF>"
Response: "favorites rename item_id:1.2.3.4.5 title:NewTitle<LF>"
```

***
## favorites move
`favorites move <taggedParameters>`

The `favorites move` command moves a favorite or a level.

**Accepted tagged parameters:**

| Tag     | Description                         |
|---------|-------------------------------------|
| from_id | The id of a favorite or level to be moved. The id represents the hierarchical structure of the file using a dotted syntax similar to the one used in SNMP, like eg. 2.0.9.3.<br>This parameter is mandatory. |
| to_id   | The id to move the favorite or level to. The id represents the hierarchical structure of the file using a dotted syntax similar to the one used in SNMP, like eg. 2.0.9.3.<br>This parameter is mandatory. | 

Example:
```
Request: "favorites move from_id:1.2.3.4.5 to_id:5.4.3.2.1<LF>"
Response: "favorites move from_id:1.2.3.4.5 to_id:5.4.3.2.1<LF>"
```

***
## favorites playlist
`<playerid> favorites playlist <play|load|insert|add> <taggedParameters>`

This command adds or plays a favorite.
If item_id defines an item that can't be played, but contains playable
subitems, then these will be played instead. This allows to eg. play all
tracks of a genre.

**Accepted tagged parameters:**

| Tag     | Description                                                                         |
|---------|-------------------------------------------------------------------------------------|
| item_id | The id of an item to be played. The id represents the hierarchical structure of the file using a dotted syntax similar to the one used in SNMP, like eg. 2.0.9.3 |

Example:
```
Request: "6e:ef:54:e9:02:b0 favorites playlist play item_id:1.1<LF>"
Response: "6e:ef:54:e9:02:b0 favorites playlist play item_id:1.1<LF>"
```
