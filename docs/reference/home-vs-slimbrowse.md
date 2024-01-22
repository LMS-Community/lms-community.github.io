---
layout: default
title: Home Menu vs. SlimBrowse
---

# Home Menu Items versus SlimbrowseItems

## Comparing the two types of items/menus delivered from SqueezeCenter to SqueezePlay

There are two types of items delivered from SqueezeCenter to Jive/Controller/SqueezePlay (hereafter referred to as Squeezeplay):

* "Home Menu" items (delivered as individual items) [Further discussion](adding-menus-squeezeplay.md)
* "Slimbrowse" items (delivered as full menus) [Further discussion](slimbrowse.md)

### Home Menu Items

"Home menu" items are those items that are managed by Squeezeplay's jive.ui.HomeMenu class, and includes not only items in the top-level menu, but miscellaneous "nodes" below that level. Examples of "Home menu" items are Home->Music Library->Genres, Home->Settings->Screen->Wallpaper, and Home->Internet Radio.

Each "home menu" items requires a unique ID that is used in the management of these items, as well as a 'node', which tells Squeezeplay where to place the item. Current examples of home menu nodes are 'home', 'settings', 'advanced', 'myMusic', and a special case 'hidden', which I'll talk about below.

If you are adding items through a Plugin via Slim::Control::Jive::registerPluginMenu, these are "home menu" items.
Further, all home menu items (except one special case: settings, which by design cannot be hidden from view) can be added to the top level via the CustomizeHomeMenu applet, available in the most current 7.1 firmware.


### Slimbrowse Items

"Slimbrowse" items are those menus delivered from SqueezeCenter to SqueezePlay via a specific cli command. Examples of this are Home->Music Library->Artists, Home->Music Library->Genres, and drilling down further Home->Music Library->Genres->Acid Jazz->etc.

Slimbrowse items, unlike home menu items, are not available for customizing into the top level menu. So, if your plugin creates an item that calls a custom cli command to produce the submenu selections, the top item from your plugin can be added to the top level Squeezeplay menu, but not the submenu items that are returned from the cli command.

The menus that are returned from Home->Internet Radio and Home->Music Services menus on Squeezeplay are actually Slimbrowse items, so in order to give the user the ability to add/remove individual items like Pandora, Rhapsody, Staff Picks, RadioTime, SHOUTcast, etc.-- this required some new code on the SqueezeCenter side. In order to make these items configurable for adding to the top level menu, but otherwise not displayed as individual home menu items, they are sent over as a member of a new 'hidden' node. node=hidden items by default are not displayed.