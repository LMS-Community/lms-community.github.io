---
layout: default
title: #CURTRACK Guide
---

# How to Use `#CURTRACK` for Playlists Guide

The `#CURTRACK` statement is a capability in Lyrion Music Server (LMS) for playlists. You can insert a `#CURTRACK 0` as the first statement in a playlist. This statement is only effective if "Play now (▶)" is used to start the playlist. If the "Append to queue (+)", "Play next" or shuffle is turned on the `#CURTRACK` statement will be ignored.

When `#CURTRACK` is active (meaning the playlist was started using the "Play now (▶)") LMS will update the number in the `#CURTRACK` statement to the track number prior to the currently playing track number. In this way you can stop the playlist, clear the play queue, play something else and at a later time restart the playlist with a "Play now (▶)" and the playlist will resume on the track that was playing when the playlist was stopped. When the playlist finishes #CURTRACK will be reset to 0 so that the next time the playlist is started via the "Play now (▶)" it will start from the beginning.

You can edit the playlist and change the number in the `#CURTRACK` statement and it will be honored the next time the playlist is started using "Play now (▶)". If the `#CURTRACK` statement is inserted in a playlist without a number it will be ignored by LMS regardless of how the playlist is started.

There is no need to rescan your library when you insert or modify the `#CURTRACK` statement in a playlist.

In any other music player `#CURTRACK` will be viewed as a comment and ignored.
