---
layout: default
title: Squeezebox Radio
---

# Squeezebox Radio

<figure markdown="span">
  ![](assets/sb_radio.jpg){ width="300" }
</figure>

Squeezebox Radio, released in September 2009, is the first full color, Squeezeplay/Linux based Squeezebox. The Radio uses the same acoustic platform as the award winning Squeezebox Boom.

Squeezebox Radio includes front panel controls, auxiliary line-in, headphone outputs, and front panel controls. Its host processor is a 400 MHz ARM9E-JS, with 64MB of RAM and 128MB of flash memory. It uses an updated version of SqueezeOS, the software from Squeezebox Controller.

The Radio has a two-way, bi-amplified mono speaker (as opposed to stereo speakers) which provides the best sound quality of any device its size. Much of the acoustical treatment is the same as on the Squeezebox Boom, details of which can be in [this white paper](assets/Logitech_Squeezebox_Boom_Audio_Design.pdf). Using Lyrion Music Server, two Squeezebox Radios can be synchronized to act as one stereo player.

An accessory pack consisting of a battery and an infrared remote control is optional.

## Migrating to Community Firmware

When setting up a Squeezebox Radio to work with your local LMS instance, the setup wizard in older firmware can get stuck trying to connect to MySqueezebox.com which is now defunct.  Use the same
[technique](../getting-started/migrate-from-uesr.md) described in the next section
to press and hold the "Back" (:material-arrow-left-bold: ) button on your Radio to access the Settings screen.
You may need to try this multiple times.  Then navigate to:

Settings → Advanced → Networking → Remote Library → Add New Library → enter IP address of your LMS → Connect to this library

You should then be connected to your local LMS.  If you have the plugin entitled "Community Firmware for Touch/Radio/Controller" installed on your local LMS, you should see a prompt for a firmware update which will eliminate the connection attempt to Mysquezeebox.com and rebrand the startup screen to Lyrion.


## UE Smart Radio

Some SB Radios have been "upgraded" to UE Smart Radio. Follow [this guide](../getting-started/migrate-from-uesr.md) if you want to revert to Squeezebox.

## See also

- [Squeezebox Radio Quickstart Guide](https://downloads.lms-community.org/docs/Squeezebox%20Radio.pdf)
