---
layout: default
title: #CURTRACK Guide
---

# `#CURTRACK` Guide

`#CURTRACK` is a capability in Logitech Media Server (LMS) for playlists. You can insert a `#CURTRACK 0` as the first statement in a playlist. This statement is only effective if "Play now (>)" is used to start the playlist. If the "Append to queue (+)" is used the `#CURTRACK` statement will be ignored.

When `#CURTRACK` is active (meaning the playlist was started using the "Play now (>)") LMS will update the number to the track # prior to the currently playing track number. This way you can stop the playlist and at a later time restart the playlist with a "Play now (>)" and the playlist will resume on the track that was playing when the playlist was stopped.

You can edit the playlist and change the number in the `#CURTRACK` statement and it will be honored the next time the playlist is started using "Play now (>)". If the `#CURTRACK` statement is inserted in a playlist without a number it will be ignored by LMS regardless of how the playlist is started.

In any other player `#CURTRACK` will be viewed as a comment and ignored.
