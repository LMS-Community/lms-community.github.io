---
layout: default
title: Getting the most out of metadata in Lyrion
---

<style>
.md-grid {
  max-width: 65rem;
  margin-left: auto;
  margin-right: auto;
}
</style>

# Getting the most out of metadata in Lyrion

Lyrion builds your library view from the metadata embedded in your audio files.
If you understand which tags Lyrion reads (and how different file formats store those tags), you can make your library *browseable* and *searchable* in a predictable and rewarding way.

This guide focuses on:

- The **canonical metadata keys** Lyrion uses internally.
- The **format-specific tags/frames/atoms** that Lyrion maps into those keys.
- Practical tagging guidance for **new users** and **power users**.

!!! note
	This page documents what Lyrion ingests during library scanning based on the server code (the format readers and schema layer). Plugins and skins can add additional metadata, but the mappings below cover core scanning.

## How Lyrion reads tags (high-level)

When you scan your library, Lyrion:

1. Detects the file type.
2. Uses the corresponding format reader to extract tags (eg. ID3 frames, Vorbis comments, MP4 atoms).
3. Normalizes a variety of “source tags” into Lyrion’s **canonical keys**.
4. Stores those canonical values into the library database (tracks, albums, contributors, genres, works, etc).

Two practical consequences:

- **The same concept can be stored under different raw names** depending on the file format (eg. MP3 `TIT1` vs FLAC `WORK`).
- Some values are **derived** (eg. sort keys) or **split** (eg. disc like `1/3` into disc number and disc count).

## How to check what Lyrion saw

- In the web UI, open a track and use: **More → More Info → View Tags**.
- For bulk/automation, use the CLI/JSON-RPC.

!!! note
	**View Tags** reads the file directly and can show tags which are not ingested into the database.

## Basic tags all files should have

These are the tags most people should care about first wherever they're applicable to a track or album:

| What you’re trying to describe | Lyrion key | FLAC/Ogg/Opus (Vorbis comments) | MP3 (ID3v2 frame) | MP4/M4A/ALAC (atom) | WMA/ASF field | APEv2 key |
|---|---|---|---|---|---|---|
| Disc / set number | `DISC` | `DISCNUMBER` → `DISC` | `TPOS` → (split from `SET`) | `DISK` (split in MP4 reader) | `WM/PartOfSet` | `DISCNUMBER` |
| Track number | `TRACKNUM` | `TRACKNUMBER` → `TRACKNUM` | `TRCK` | `TRKN` | `WM/TrackNumber` | `TRACK` |
| Track title | `TITLE` | `TITLE` | `TIT2` | `NAM` | `Title` | `TITLE` |
| Track subtitle (eg. movement subtitle, Demo etc.) | `SUBTITLE` | `SUBTITLE` (use this exact key) | `TIT3` | (no standard atom mapped by core) | `WM/SubTitle` |
| Composer | `COMPOSER` | `COMPOSER` | `TCOM` | `WRT` | `WM/Composer` | `COMPOSER` |
| Track artist (performer) | `ARTIST` | `ARTIST` | `TPE1` | `ART` | `Author` | `ARTIST` |
| Conductor | `CONDUCTOR` | `CONDUCTOR` | `TPE3` | `CON` | `WM/Conductor` | `CONDUCTOR` |
| Album artist | `ALBUMARTIST` | `ALBUMARTIST` (or `MUSICBRAINZ_ALBUMARTIST`) | Tagger “Album Artist” (Lyrion maps `ALBUM ARTIST` to `ALBUMARTIST`; note: `TPE2` is mapped to `BAND`) | `AART` | `WM/AlbumArtist` | `ALBUM ARTIST` |
| Album title | `ALBUM` | `ALBUM` | `TALB` | `ALB` | `WM/AlbumTitle` | `ALBUM` |
| Compilation flag | `COMPILATION` | `COMPILATION` | `TCMP` (or `YTCP`) | `CPIL` | `WM/IsCompilation`/`WM/PartOfACompilation` | `COMPILATION` |
| Genre | `GENRE` | `GENRE` | `TCON` | `GEN`/`GNRE` | `WM/Genre` | `GENRE` |
| Year | `YEAR` | `DATE`/`ORIGINALYEAR` → year extracted | Read from ID3 date/year frames via the MP3 tag reader | `DAY` | `WM/Year` | `DATE` |
| Lyrics | `LYRICS` | `LYRICS` (or `UNSYNCEDLYRICS` → `LYRICS`) | `USLT` | `LYR` | `WM/Lyrics` | `LYRICS` |


!!! tip
	If you are using “classical works” features, also tag `WORK` (below). It’s worth doing early: it changes how you browse.

## Classical essentials

These keys drive the “works” and related browsing logic.

| Concept | Lyrion key | FLAC/Ogg/Opus | MP3 (ID3v2) | MP4/M4A | WMA |
|---|---|---|---|---|---|
| Work / piece | `WORK` | `WORK` | `TIT1` | `WRK` | `WM/Work` |
| Grouping (often used for sub-work grouping) | `GROUPING` | `GROUPING` | `GRP1` | `GRP` | `WM/ContentGroupDescription` |
| Performance (optional, helps separate multiple performances) | `PERFORMANCE` | `PERFORMANCE` (use this exact key) | (no standard ID3 frame mapped by core) | (no standard atom mapped by core) | (no standard WMA field mapped by core) |

## Multi-disc and box-set essentials

Multi-disc releases can contain a core release plus bonus discs (eg. a live concert). Box-sets can also contain multiple albums.
Use disc subtitle to identify individual discs by name.

| Concept | Lyrion key | FLAC/Ogg/Opus | MP3 (ID3v2) | MP4/M4A | WMA |
|---|---|---|---|---|---|
| Disc subtitle / set subtitle (eg. box-set disc name, bonus concert disc) | `DISCSUBTITLE` | FLAC: `SETSUBTITLE` → `DISCSUBTITLE`; Ogg/Opus: use `DISCSUBTITLE` | `TSST` | (no standard atom mapped by core) | `WM/SetSubTitle` |


!!! tip
	Both Track subtitle and Disc subtitle are included in Lyrion's Advanced search dialogue.


!!! warning
	Some “friendly” tagging UIs hide raw frame names.
	If `WORK` browsing doesn’t behave as expected for MP3, verify that your tagger actually wrote `TIT1` (not a different, non-mapped frame).

## Additional tags (sorting, MusicBrainz, replay gain)

For a complete, per-format reference, use the canonical key list and format-specific alias tables below.

Each format reader (the Slim/Formats code) only lists the raw tag names that need to be mapped into Lyrion’s canonical internal keys so every format lands on the same schema. After those mappings, the reader still hands the full tag payload to Slim/Schema.pm, and that schema layer decides which keys are persisted to the library database. As a user, this means you should ensure that you use the input tag names set out in the tables below (you could instead use Lyrion's internal canonical names listed below, but for interoperability with other servers, mobile players and tagging software etc, you're better off sticking with the tagnames listed in the Input tag name column - they're the names most commonly used for the relevant file type).  Additional tagnames not listed in these tables, are available to plugins or future schema updates even if they aren’t currently stored.

Lyrion also supports user-defined roles that can be read from tags. Lyrion’s contributor system is extensible: beyond built-in roles like ARTIST, COMPOSER, or CONDUCTOR, you can enable custom contributor roles and feed them through metadata tags named after those roles. When the scanner encounters a tag that matches an enabled role (case-insensitive), it ingests the tagged values into the contributor tables just like the core roles, letting you browse, filter, or search by your own role names (eg. MASTERING ENGINEER, ARRANGER, LIBRETTIST, REMIXER etc.)

## Canonical tag keys (work across formats)

If you write these tag names (case-insensitive), Lyrion will ingest them for all supported audio formats and store them under the same internal key.

| Tag name you can write | Stored as (Lyrion key) | Notes |
|---|---|---|
| TITLE | TITLE | Track title |
| TITLESORT | TITLESORT | Title sort key |
| ALBUM | ALBUM | Album title |
| ALBUMSORT | ALBUMSORT | Album sort key |
| ARTIST | ARTIST | Track artist |
| ARTISTSORT | ARTISTSORT | Artist sort key |
| ALBUMARTIST | ALBUMARTIST | Album artist |
| ALBUMARTISTSORT | ALBUMARTISTSORT | Album artist sort key |
| BAND | BAND | “Band” / ensemble (some taggers use this for album artist) |
| COMPOSER | COMPOSER | Contributor role |
| COMPOSERSORT | COMPOSERSORT | Composer sort key |
| CONDUCTOR | CONDUCTOR | Contributor role |
| GENRE | GENRE | Stored as genre rows (not a single track column) |
| YEAR | YEAR | Year; full dates may be reduced to year |
| TRACKNUM | TRACKNUM | Track number; values like `3/10` are supported |
| DISC | DISC | Disc/set number; values like `1/3` are supported |
| DISCC | DISCC | Total discs (disc count) |
| BPM | BPM | Beats per minute |
| COMMENT | COMMENT | Comment/description |
| LYRICS | LYRICS | Lyrics |
| COMPILATION | COMPILATION | Compilation flag |
| WORK | WORK | Work/piece title (classical browsing) |
| WORKSORT | WORKSORT | Work sort key |
| GROUPING | GROUPING | Grouping (often used for sub-work grouping) |
| PERFORMANCE | PERFORMANCE | Performance (helps separate multiple performances) |
| SUBTITLE | SUBTITLE | Track subtitle (eg. movement subtitle) |
| DISCSUBTITLE | DISCSUBTITLE | Disc/set subtitle (eg. box-set disc name) |
| MUSICBRAINZ_ID | MUSICBRAINZ_ID | Track MBID (UUID) |
| MUSICBRAINZ_ALBUM_ID | MUSICBRAINZ_ALBUM_ID | Release/album MBID (UUID) |
| MUSICBRAINZ_ARTIST_ID | MUSICBRAINZ_ARTIST_ID | Artist MBID (UUID) |
| MUSICBRAINZ_ALBUMARTIST_ID | MUSICBRAINZ_ALBUMARTIST_ID | Album-artist MBID (UUID) |
| MUSICBRAINZ_ALBUM_STATUS | MUSICBRAINZ_ALBUM_STATUS | Release status |
| RELEASETYPE | RELEASETYPE | Release type |
| MUSICBRAINZ_TRM_ID | MUSICBRAINZ_TRM_ID | Legacy TRM ID |
| REPLAYGAIN_TRACK_GAIN | REPLAYGAIN_TRACK_GAIN | Track ReplayGain |
| REPLAYGAIN_TRACK_PEAK | REPLAYGAIN_TRACK_PEAK | Track peak |
| REPLAYGAIN_ALBUM_GAIN | REPLAYGAIN_ALBUM_GAIN | Album ReplayGain (stored on the album) |
| REPLAYGAIN_ALBUM_PEAK | REPLAYGAIN_ALBUM_PEAK | Album peak (stored on the album) |

!!! note
	Lyrion also ingests **contributors** (artist, album artist, composer, conductor, etc.) into contributor tables, not just track columns.
	Additional contributor roles can be enabled/configured in Lyrion; those roles can also be ingested if present.

## Format-specific aliases

Each format reader also recognizes additional tag names and maps them into the canonical keys above.
If you are tagging files “natively” for a given container (ID3 frames, Vorbis comments, MP4 atoms, etc.), use these aliases.

### MP3 (ID3v2)

| Input tag name | Stored as (Lyrion key) |
|---|---|
| TALB | ALBUM |
| ALBUM ARTIST | ALBUMARTIST |
| MEDIA JUKEBOX: ALBUM ARTIST | ALBUMARTIST |
| MUSICBRAINZ ALBUM ARTIST | ALBUMARTIST |
| TSO2 | ALBUMARTISTSORT |
| YTS2 | ALBUMARTISTSORT |
| TSOA | ALBUMSORT |
| YTSA | ALBUMSORT |
| TPE1 | ARTIST |
| TSOP | ARTISTSORT |
| XSOP | ARTISTSORT |
| YTSP | ARTISTSORT |
| TPE2 | BAND |
| TBPM | BPM |
| COMM | COMMENT |
| TCMP | COMPILATION |
| YTCP | COMPILATION |
| TCOM | COMPOSER |
| TSOC | COMPOSERSORT |
| YTSC | COMPOSERSORT |
| TPE3 | CONDUCTOR |
| TPOS | DISC |
| TPOS | DISCC |
| TSST | DISCSUBTITLE |
| TCON | GENRE |
| GRP1 | GROUPING |
| USLT | LYRICS |
| MUSICBRAINZ ALBUM ARTIST ID | MUSICBRAINZ_ALBUMARTIST_ID |
| MUSICBRAINZ ALBUM ID | MUSICBRAINZ_ALBUM_ID |
| MUSICBRAINZ ALBUM STATUS | MUSICBRAINZ_ALBUM_STATUS |
| MUSICBRAINZ ARTIST ID | MUSICBRAINZ_ARTIST_ID |
| UFID | MUSICBRAINZ_ID |
| MUSICBRAINZ TRM ID | MUSICBRAINZ_TRM_ID |
| MUSICBRAINZ ALBUM TYPE | RELEASETYPE |
| MEDIA JUKEBOX: ALBUM GAIN | REPLAYGAIN_ALBUM_GAIN |
| MEDIA JUKEBOX: REPLAY GAIN | REPLAYGAIN_TRACK_GAIN |
| MEDIA JUKEBOX: PEAK LEVEL | REPLAYGAIN_TRACK_PEAK |
| TIT3 | SUBTITLE |
| TIT2 | TITLE |
| TSOT | TITLESORT |
| TST | TITLESORT |
| YTST | TITLESORT |
| TRCK | TRACKNUM |
| TIT1 | WORK |

!!! note
	MP3 disc info: the `TPOS` frame is split into `DISC` and `DISCC` when it contains values like `1/3`.

### FLAC (Vorbis comments)

| Input tag name | Stored as (Lyrion key) |
|---|---|
| ALBUM ARTIST | ALBUMARTIST |
| MUSICBRAINZ_ALBUMARTIST | ALBUMARTIST |
| MUSICBRAINZ_SORTNAME | ARTISTSORT |
| DESCRIPTION | COMMENT |
| DISCNUMBER | DISC |
| DISCTOTAL | DISCC |
| TOTALDISCS | DISCC |
| SETSUBTITLE | DISCSUBTITLE |
| UNSYNCEDLYRICS | LYRICS |
| MUSICBRAINZ_ALBUMARTISTID | MUSICBRAINZ_ALBUMARTIST_ID |
| MUSICBRAINZ_ALBUMID | MUSICBRAINZ_ALBUM_ID |
| MUSICBRAINZ_ALBUMSTATUS | MUSICBRAINZ_ALBUM_STATUS |
| MUSICBRAINZ_ARTISTID | MUSICBRAINZ_ARTIST_ID |
| MUSICBRAINZ_TRACKID | MUSICBRAINZ_ID |
| MUSICBRAINZ_TRMID | MUSICBRAINZ_TRM_ID |
| MUSICBRAINZ_ALBUMTYPE | RELEASETYPE |
| MUSICBRAINZ_ALBUM_TYPE | RELEASETYPE |
| REPLAY GAIN | REPLAYGAIN_TRACK_GAIN |
| PEAK LEVEL | REPLAYGAIN_TRACK_PEAK |
| TRACKNUMBER | TRACKNUM |
| ORIGINALYEAR | YEAR |

### Ogg Vorbis / Opus (Vorbis comments)

| Input tag name | Stored as (Lyrion key) |
|---|---|
| ALBUM ARTIST | ALBUMARTIST |
| MUSICBRAINZ_ALBUMARTIST | ALBUMARTIST |
| MUSICBRAINZ_SORTNAME | ARTISTSORT |
| DESCRIPTION | COMMENT |
| DISCNUMBER | DISC |
| TOTALDISCS | DISCC |
| MUSICBRAINZ_ALBUMARTISTID | MUSICBRAINZ_ALBUMARTIST_ID |
| MUSICBRAINZ_ALBUMID | MUSICBRAINZ_ALBUM_ID |
| MUSICBRAINZ_ALBUMSTATUS | MUSICBRAINZ_ALBUM_STATUS |
| MUSICBRAINZ_ARTISTID | MUSICBRAINZ_ARTIST_ID |
| MUSICBRAINZ_TRACKID | MUSICBRAINZ_ID |
| MUSICBRAINZ_TRMID | MUSICBRAINZ_TRM_ID |
| MUSICBRAINZ_ALBUMTYPE | RELEASETYPE |
| MUSICBRAINZ_ALBUM_TYPE | RELEASETYPE |
| REPLAY GAIN | REPLAYGAIN_TRACK_GAIN |
| PEAK LEVEL | REPLAYGAIN_TRACK_PEAK |
| TRACKNUMBER | TRACKNUM |
| DATE | YEAR |
| ORIGINALDATE | YEAR |
| ORIGINALYEAR | YEAR |

### MP4/M4A/ALAC (MP4 atoms)

| Input tag name | Stored as (Lyrion key) |
|---|---|
| ALB | ALBUM |
| AART | ALBUMARTIST |
| MusicBrainz Album Artist | ALBUMARTIST |
| SOAA | ALBUMARTISTSORT |
| SOAL | ALBUMSORT |
| ART | ARTIST |
| MusicBrainz Sortname | ARTISTSORT |
| SOAR | ARTISTSORT |
| TMPO | BPM |
| CMT | COMMENT |
| CPIL | COMPILATION |
| WRT | COMPOSER |
| SOCO | COMPOSERSORT |
| CON | CONDUCTOR |
| DISK | DISC |
| DISK | DISCC |
| GEN | GENRE |
| GNRE | GENRE |
| GRP | GROUPING |
| LYR | LYRICS |
| MusicBrainz Album Artist Id | MUSICBRAINZ_ALBUMARTIST_ID |
| MusicBrainz Album Id | MUSICBRAINZ_ALBUM_ID |
| MusicBrainz Album Status | MUSICBRAINZ_ALBUM_STATUS |
| MusicBrainz Artist Id | MUSICBRAINZ_ARTIST_ID |
| MusicBrainz Track Id | MUSICBRAINZ_ID |
| MusicBrainz Album Type | RELEASETYPE |
| NAM | TITLE |
| SONM | TITLESORT |
| TRKN | TRACKNUM |
| WRK | WORK |
| DAY | YEAR |

!!! note
	MP4 disc info: the `DISK` atom is split into `DISC` and `DISCC` when it contains values like `1/3`.

### WMA/ASF

| Input tag name | Stored as (Lyrion key) |
|---|---|
| WM/AlbumTitle | ALBUM |
| WM/AlbumArtist | ALBUMARTIST |
| WM/AlbumSortOrder | ALBUMSORT |
| Author | ARTIST |
| WM/ArtistSortOrder | ARTISTSORT |
| WM/BeatsPerMinute | BPM |
| Description | COMMENT |
| WM/Comments | COMMENT |
| Compilation | COMPILATION |
| WM/IsCompilation | COMPILATION |
| WM/PartOfACompilation | COMPILATION |
| compilation | COMPILATION |
| WM/Composer | COMPOSER |
| WM/Conductor | CONDUCTOR |
| WM/PartOfSet | DISC |
| WM/SetSubTitle | DISCSUBTITLE |
| WM/Genre | GENRE |
| WM/ContentGroupDescription | GROUPING |
| WM/Lyrics | LYRICS |
| MusicBrainz/Album Artist Id | MUSICBRAINZ_ALBUMARTIST_ID |
| MusicBrainz/Album Id | MUSICBRAINZ_ALBUM_ID |
| MusicBrainz/Album Status | MUSICBRAINZ_ALBUM_STATUS |
| MusicBrainz/Artist Id | MUSICBRAINZ_ARTIST_ID |
| MusicBrainz/Track Id | MUSICBRAINZ_ID |
| MusicBrainz/TRM Id | MUSICBRAINZ_TRM_ID |
| MusicBrainz/Album Type | RELEASETYPE |
| replaygain_album_gain | REPLAYGAIN_ALBUM_GAIN |
| replaygain_album_peak | REPLAYGAIN_ALBUM_PEAK |
| replaygain_track_gain | REPLAYGAIN_TRACK_GAIN |
| replaygain_track_peak | REPLAYGAIN_TRACK_PEAK |
| WM/SubTitle | SUBTITLE |
| Title | TITLE |
| WM/TrackNumber | TRACKNUM |
| WM/Work | WORK |
| WM/Year | YEAR |

### APEv2 (also WavPack/Musepack)

| Input tag name | Stored as (Lyrion key) |
|---|---|
| ALBUM ARTIST | ALBUMARTIST |
| DISCNUMBER | DISC |
| TRACK | TRACKNUM |
| DATE | YEAR |

!!! note
	WAV/AIFF files that contain ID3 metadata follow the MP3/ID3 mappings.