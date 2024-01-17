---
layout: default
title: Database structure
---

# Database structure

Logitech Media Server stores its data in a SQLite databases, though it is possible to also use MySQL/MariaDB. 

## Databases

- artwork.db - Artwork Database
- library.db - Database Library
- persist.db - Persistant Database Library, ie holds data which will survives a full clear and database rescan.

## Main tables library.db

### albums

The albums table contains all real albums. Besides this it also contains a "No Album" entry which represents tracks that don't belong to any album. The name of the "No Album" entry will differ depending on the selected language in LMS. The tracks that doesn't belong to any real albums will be related to the "No Album" entry.

### contributors

The contributors table contains all composers, conductors, artists, album artists, bands and track artists that have contributed to the music on any track in your library.

The contributors table also contains a special entry named "Various Artists" that represents all the artists that exist on a compilation album. Note that all the individual artists on compilation albums also exist as separate entries in the contributors table. There is no relation in the database between the "Various Artists" entry and the tracks and albums tables.

### tracks 

The tracks table contains all tracks in your music library. These have the "audio" column set to 1 and the "remote" column set to 0. The tracks table also contains an entry for all Internet radio stations you have listened to since the last rescan. The Internet radio station entries have the "remote" column set to 1.

The tracks table also contains some entries that aren't really separate songs. There will be one entry for each directory in your library; these entries will have "audio" set to 0 and "content_type" set to "dir". There will be one entry for each playlist, which will also have "audio" set to 0 and content_type set to the type of playlist. Note that the current playlist is also represented this way even though it doesn't exist as a physical m3u file on the disk. The current playlist has "content_type" set to "cpl".

* Some interesting columns in tracks table (these are not all columns, just the most interesting ones)
  * title - The track title
  * titlesort - The version of the track title that's used for sorting
  * url - The url to the track
    * Typically something like: file:///mnt/music/First%20Album/01%20First%20Song.flac
    * Is url encoded, can be unencoded to a path with http://urldecode.org
  * audio - Indicates if the entry represents a music file
    * 1 - music file
    * null - not music file
  * content_type - The type of entry, see above, it typically either indicates file format or playlist format
  * tracknum - The track number on an album
  * timestamp - The last modification time of the music file
  * filesize - The size of the file in bytes
  * year - Relation to years table
  * secs - The length of the track in number of seconds
  * bitrate - The bit rate of the track, for example 457489 for a 457kbs track
  * samplerate - The sample rate of the track, for example 44100
  * samplesize - The sample size of the track, for example 16
  * channels - Number of audio channels used by the track
  * bpm - The bpm of the track, not filled unless you have tagged your music with BPM tags
  * disc - The disc number this track is available on
  * remote - 1 if this isn't a local track but a remote stream, for example an internet radio station
  * lossless - 1 if this is a lossless compressed track, else 0
  * lyrics - The lyrics of the track, not filled unless you have tagged your music with lyrics information
  * album - Relation to albums table

### tracks_persistent 

The tracks_persistent table contains additional statistics information about a track, such as play count, rating and last played time. This table will survive a full rescan as long as you have musicbrainz tags or haven't moved or renamed a music file. During scanning the entries in the tracks table will be re-connected to the saved entries in the tracks_persistent table.

The tracks_persistent table was added in SqueezeCenter 7.1.
 

### genres 

The genres table contains all the genres in your music library.

### years 

The years table contains an entry for each year specified in a track tag.

### comments 

The comments table contains all the comment tags in the tracks in your library. There will be one entry for each comment tag. If you have specified several comment tags in a single track, there will be a separate entry for each comment.

## Many to many associations 

### contributor_track 

The contributor_track table contains the relation between a track and a contributor. Each entry also has a role attribute indicating the role the contributor had. Some examples of existing roles are:

* Artist -> 1
* Composer -> 2
* Conductor -> 3
* Band -> 4
* Album artist -> 5
* Track artist -> 6

Contributors and tracks are joined with:

`
contributor_track.contributor = contributors.id and contributor_track.track = tracks.id`

### contributor_album 

The contributor_album table contains the relation between an album and a contributor. Like the contributor_track table, the contributor_album table also contains a role attribute indicating the role the contributor had on one or several tracks on an album.

The contributor_album table is just a shortcut table to get better performance when browsing from artists to albums. All the information already exists in the contributor_track table but is compiled together to a summary view in the contributor_album table.

Contributors and albums are joined with:

`
contributor_album.album = albums.id and 
 contributor_album.contributor = contributors.id`

### genre_track 

The genre_track table contains the relation between genres and tracks. This is the table to use if you need to know which genres a track belongs to, or which tracks exist within a specific genre.

Genres and tracks are joined with:

`
genre_track.genre = genres.id and 
 genre_track.track = tracks.id`

### playlist_track 

The playlist_track table contains the relation between playlists and tracks. This table is used if you need to know the tracks in a specific playlist.

Playlists and tracks these are joined with:

`
playlist_track.playlist = tracks.id and 
 playlist_track.track = tracks.url`

## Many to one associations 

### Relation between track and album 

There is no separate relation table for the relation between albums and tracks; instead this relation is represented with the "album" column in the tracks table.

Albums and tracks are joined with:

`
tracks.album = albums.id`

### Relation between album and year 

There is no separate relation table for the relation between years and albums; instead this relation is represented with the "year" column in the albums table.

Years and albums are joined with:

`
albums.year = years.id`

### Relation between track and year 

There is no separate relation table for the relation between years and tracks; instead this relation is represented with the "year" column in the tracks table.

Years and tracks are joined with:

`
tracks.year = years.id`

### Relation between track and comment 

There is no separate relation table for the relation between tracks and comments; instead this relation is represented with the "track" column in the comments table.

Tracks and comments are joined with:

`comments.track = tracks.id`

### Relation between album and main artist 

There is a special relation between albums and main artists. Note that this relation can be a bit random on compilation albums.

Albums and main artists are joined with:

`
albums.contributor = contributors.id`

## Extra tables 

There are a number of extra table in the database that contain some different kinds of state information. These tables follow below and they do not contain any music library information; they are just needed to make LMS work.

### metainformation 

Contains some different meta information about the database, for example the last time a rescan was performed, and an indication whether scanning is currently in progress.

### dbix_migration 

Contains the current database structure version. This is used to determine whether the database structure needs to be updated when upgrading to a new LMS version.

### progress 

New in LMS 7.0 (i.e. SqueezeCenter). Contains the progress of the currently active scanning process. This is used for the progress bar during the scanning operation.

## Database creation 

The LMS database is created automatically at first LMS startup. The database is created with the schema_*_up.sql scripts in the SQL/SQLite or SQL/mysql directory below the LMS installation directory. The scripts will run in sequence, starting with the script with a number greater than the current database structure version.

As an example: if the current database version is 3, the schema_4_up.sql and schema_5_up.sql scripts will be executed. If the database doesn't exist it will execute all the \*_up.sql scripts.

## Sample queries 

The following sections lists a number of different sample SQL statements that retrieve different kinds of information from the database. Please note that the corresponding statements used directly by LMS might be different than the statements shown below; these are just samples.

### Get artists in the database 

The simple way to retrieve all contributors independent of roles in the database is a query like this

```
select * from contributors
     order by namesort
```

However, you should be aware of that if you have removed, re-tagged or renamed some track in your library and used the rescanning option "New and changed files", there could be artists in the result that no longer have any tracks in the LMS database. The above query will also return the special "Various Artists" entry that doesn't correspond to a single artist.

A query like this will solve this problem:

```
select contributors.* from contributors, contributor_album
     where
         contributors.id = contributor_album.contributor
     group by contributors.id
     order by contributors.namesort
```

If you only wanted the contributors that have the role "artist", "album artist" or "track artist", you would instead use a query like:

```
select contributors.* from contributors, contributor_album
     where
         contributors.id = contributor_album.contributor and
         contributor_album.role in (1, 5, 6)
     group by contributors.id
     order by contributors.namesort
```

In the same way you can get all the composers with a query like:

```
select contributors.* from contributors, contributor_album
     where
         contributors.id = contributor_album.contributor and
         contributor_album.role = 2
     group by contributors.id
     order by contributors.namesort
```

If you want to ignore artists that only exist on compilation albums, you would use something like:

```
select contributors.* from contributors, contributor_album, albums
     where
         contributors.id = contributor_album.contributor and
         contributor_album.role in (1,5,6) and
         contributor_album.album = albums.id and
         albums.compilation is null
     group by contributors.id
     order by contributors.namesort
```

If you only want to list only those artists that exist on compilation albums, you would use something like:

```
select contributors.* from contributors, contributor_album, albums
     where
         contributors.id = contributor_album.contributor and
         contributor_album.role in (1,5,6) and
         contributor_album.album = albums.id and
         albums.compilation = 1
     group by contributors.id
     order by contributors.namesort
```

### Get albums in the database 

The easiest way to get all albums in the database is with a query like this:

```
select * from albums
     order by titlesort
```

However, you should be aware that if you have removed, re-tagged or renamed some track in your library and used the rescanning option "New and changed files", there could be albums in the result that no longer have any tracks in the LMS database. The query will also return the special "No Artist" entry that doesn't correspond to a single artist.

The following query only returns the albums that really have tracks in the database:

```
select albums.* from albums, tracks
     where
         tracks.album = albums.id and
         tracks.audio = 1
     group by albums.id
     order by albums.titlesort
```

If you want to ignore the compilation albums, you would instead use something like this:

```
select albums.* from albums, tracks
     where
         tracks.album = albums.id and
         tracks.audio = 1 and
         albums.compilation is null
     group by albums.id
     order by albums.titlesort
```

Or if you only want the compilation albums:

```
select albums.* from albums, tracks
     where
         tracks.album = albums.id and
         tracks.audio = 1 and
         albums.compilation = 1
     group by albums.id
     order by albums.titlesort
```

To retrieve all albums within the genres 'Pop' or 'Rock' you would use a query like this:

```
select albums.* from albums, tracks, genre_track, genres
     where
         tracks.album = albums.id and
         tracks.id = genre_track.track and
         genre_track.genre = genres.id and
         genres.name in ('Pop','Rock') and
         tracks.audio = 1
     group by albums.id
     order by albums.titlesort
```

To retrieve all albums from year 2000 and forward you would use a query like:

```
select * from albums
     where
         year >= 2000
     order by titlesort
```

### Ordering albums retreived from the database 

For queries that return albums it also gets interesting to order the result in various ways.

All albums ordered by the album title sort tag and then disc number:

```
select * from albums
     order by titlesort, disc
```

All albums ordered by the year in descending order:

```
select * from albums
     order by year desc, titlesort, disc
```

All albums ordered by main artist and then year in descending order:

```
select albums.* from albums
     left join contributors on
         albums.contributor = contributors.id
     group by albums.id
     order by contributors.namesort, albums.year desc, albums.disc
```

The reason we need to use the "left join" syntax in the above statement is that there can be albums without a main artist.

### Get tracks in the database 

To get all locally stored tracks in the database you can use a query like this:

```
select * from tracks
     where
         audio = 1
     order by titlesort
```

The above query returns the tracks ordered by the titlesort field; you would probably also want the tracks ordered by album. To accomplish this you would instead use something like:

```
select tracks.* from tracks, albums
     where
         tracks.album = albums.id and
         tracks.audio = 1
     group by tracks.id
     order by albums.titlesort, tracks.disc, tracks.tracknum
```

Or maybe even order the albums by the main artist with something like:

```
select tracks.* from tracks
     join albums on
         tracks.album = albums.id
     left join contributors on
         albums.contributor = contributors.id
     where
         tracks.audio = 1
     group by tracks.id
     order by contributors.namesort, albums.titlesort, tracks.disc, tracks.tracknum
```
