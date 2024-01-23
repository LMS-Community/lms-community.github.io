---
layout: default
title: Adding Menus from Plugins
---

# Adding Menus on SqueezePlay from LMS Plugins

The main menu hierarchy in SqueezePlay and Squeezebox Controller is now handled differently than deeper browse menus served by SqueezeCenter to SqueezePlay. This is to allow for an easier set of methods to manage what goes into these top level menus and where. Further discussion of the difference of these two types of SqueezeCenter->SqueezePlay "deliverables" can be [FOUND HERE](home-vs-slimbrowse.md).

Currently, the main menu hierarchy nodes look roughly like this (subject to change)

* Node: Home (id = 'home')
    * Node: Music Library (id = 'myMusic')
        * Node: Search (id = 'myMusicSearch')
        * Node: Random Mix (id = 'randomplay'; added via Plugin)
    * Node: Settings (id = 'settings')
        * Node: Screen (id = 'screenSettings')
        * Node: Advanced (id = 'advancedSettings')
    * Node: Extras (id = 'extras')
        * Node: Games (id = 'games')

These are "nodes", i.e., menu items that serve as "directories" of other items also managed out of these methods. Non-nodes managed by these methods are called "items", and can take the form of either action items, choice items, text input items, or text area items.

Further ramblings on where things should go can be found on the user interface hierarchy and ControllerSettings wiki pages.


## Adding a node from an LMS Plugin

If your plugin needs to create a node, this is done through the `Slim::Control::Jive::registerPluginNode()` method.

Any item in the main menu structure needs to have a unique 'id', which allows it to be identified and managed as needed by the Controller itself. Further, any node needs to attach itself to a node as well. For example, if you wanted to add a node for your Foobar plugin, you would do this to register this item to SqueezePlay:

```perl
  my $node = {
                      text           => 'Foobar',
                      weight         => 100,
                      id             => 'pluginFoobarMenu',
                      node           => 'settings',
                      homeMenuText   => 'Foobar Settings',
                      window         => { titleStyle => 'settings' },
  };
  Slim::Control::Jive::registerPluginNode($node, $client);
```

This will add a node with the text 'Foobar', and this node is added to the Settings node (which is in itself attached to the 'home' node). `homeMenuText` is an optional key-val pair that can set a different text string when this item is added to the top level menu via the SBC's Settings->Home Menu applet.

`$client` is an optional argument which can be sent if the node to be sent is specific to a certain player. In most cases, this argument is not necessary.

* the weight key is for ordering within the menu. You will need to look at what the weights are set to for other members of the node (default is 5) to understand where yours will be placed. Items with the same weight are sub-sorted alphabetically
* `window`: parameters for the window that is opened when descending into this node can be set in a hashref to the window key. In the example above, the "titleStyle" is set to 'settings'– this displays a mini-icon on the right side of the title bar that is demonstrative of a settings window.
* an optional item noCustom can be sent, which disallows SqueezePlay from allowing the user to add the item to the top level menu (through Settings->Home Menu)

## Adding menu items from an LMS Plugin

The SqueezePlay main menu items from SC plugins are sent via Slim::Control::Jive::registerPluginMenu(). Arguments to registerPluginMenu are an array of menu items, (optionally) the node that you want to add them to, and (optionally) a $client object if the menu you are sending needs to be specific to a player (in most cases you do not need to do this). If you don't send a node as a second argument, you will need to add a node key to each item in the array. Node keys in items take precedence over the function argument.

```perl
my @menu = ({
    # localize text where possible
    text    =>  Slim::Utils::Strings::string('SOME_STRING'),
    id      => 'pluginFoobarTweakSomething',
    weight  => 10,
    actions => {
        do => {
            player => 0,
            cmd    => [ 'someCustomPluginCommand', 'someArgument' ],
            params => {
                    state => 'tweaked',
            },
        }
    },
},{
    # localize text where possible
    text    => Slim::Utils::Strings::string('SOME_OTHER_STRING'),
    id      => 'pluginFoobarActivateSomething',
    weight  => 20,
    actions => {
        do => {
            player => 0,
            cmd    => [ 'someOtherCustomPluginCommand', 'someOtherArgument' ],
            params => {
                    activate => '1',
            },
        }
    },
});
Slim::Control::Jive::registerPluginMenu(\@menu, 'settings', $client);
```

See [SlimBrowse Protocol](slimbrowse.md) for more information on the API for actions, menu items, etc.

## Refreshing menus on SqueezePlay

It is possible that your plugin might have a dynamic nature to it, and after executing some code you need to tell SqueezePlay to update its main menu structure, or at least part of it.

With the new architecture, this is possible. Examples:

```perl
# refreshes any menu items driven by SC plugins
Slim::Control::Jive::refreshPluginMenus($client);

# $client is optional here-- if it's not used menu notification will update SqueezePlay no matter what player is selected
# refreshes entire main menu item list from SC, all nodes all items
# this part was added in svn r15471
Slim::Control::Jive::mainMenu($client);

# refreshes just SC items in settings node (and sub nodes of settings)
Slim::Control::Jive::playerSettingsMenu($client);

# refreshes *only* the player power menu item
Slim::Control::Jive::playerPower($client);

# refreshes the "Music Library" node (and sub nodes of this one, including the search node)
Slim::Control::Jive::myMusicMenu($client);

# refreshes just the search node
Slim::Control::Jive::searchMenu($client);
```

Sending the `$client` object is required for all methods except `refreshPluginMenus()`.
