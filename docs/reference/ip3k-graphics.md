---
layout: default
title: Classic/Transporter/Boom Graphics Font Files
---

This document is about the bitmap files used to render the fonts on the legacy players (Clasic/Transporter/Boom). It does _not_ cover any of the newer, colour display based devices (Radio/Touch/Controller).

Font files reside in the `Graphics` folder

For each font set (one font for each line of the display) there's a separate BMP file. For example:

* `medium.1.font.bmp` - the font used at the top of the screen when in "medium" display mode
* `medium.2.font.bmp` - the font used at the bottom of the screen when in "medium" display mode

Single-line display modes, such as the Huge font, only require the bottom font file.

Open these files in a bitmap editor (Gimp, Windows Paint etc.) and you'll see a long horizontal line of characters.

For SqueezeboxG, the file is 17 pixels high. For Squeezebox2/3/Classic/Boom/Transporter it is 33 pixels high.

The first 16 (SqueezeboxG) or 32 (Squeezebox2) rows are the font bitmaps themselves. The last row is used to mark the beginning and end of characters. One or more continuous pixels in this row indicate the end of the previous character.

Each file has up to 256 characters using the latin1 character set, in order from 0 to 255.

The first 31 characters in each standard font are reserved for use as special graphics characters. The first 17 of these are:

* 0 - Inter-character spacing
* 1 - Note symbol
* 2 - Right arrow
* 3 - Progress indicator end
* 4 - Progress indicator first column (empty)
* 5 - Progress indicator second column (empty)
* 6 - Progress indicator additional columns (empty)
* 7 - Progress indicator first column (full)
* 8 - Progress indicator second column (full)
* 9 - Progress indicator additional columns (full)
* 10 - Cursor overlay
* 11 - Moodlogic symbol
* 12 - Empty circle [radio button symbol]
* 13 - Full circle [radio button symbol]
* 14 - Empty square [radio button symbol]
* 15 - Full square [radio button symbol]
* 16 - Bell symbol

The inter-character spacing character must always be present. However if any pixels are set in it, then the server interprets this to mean no inter-character spacing. This is useful for font files defining custom characters which are intented to be displayed without space between them.

The 32nd character is a space character, and the rest follow the latin1 character set.

We used Adobe Photoshop to create the font files, saving them as 1bpp Windows BMP files.

If you modify a font file, you'll need to restart the server to see your changes.

## Custom Fonts

Plugins may choose to use font files to define custom characters to display on a graphics player. In this case the plugin should be distributed with font files which follow the naming convention:

`<fontname>.<line_number>.font.bmp`

These files should be placed in the plugin's root directory and the server restarted before they are available to the server.

Custom fonts files define characters for the fontname specified by the file name. The first character chr(0) defines the inter character spacing and following characters define characters chr(1), chr(2), chr(3) etc.

Note also that character 0x0a [chr(10)] is reserved and should not be used, as are characters 0x1b, 0x1c, 0x1d [chr(27) - chr(29].

Although a plugin may build strings using character values, it is normal to register a name for each character using `Slim::Display::Graphics::setCustomChar`.