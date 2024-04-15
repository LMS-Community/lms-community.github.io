---
layout: default
title: SlimBrowse Protocol
---

# SlimBrowse Protocol ("Squeezeplay Interface")

Interface specifications for browsing using Jive. What this document lays out is how browse menus sent in request responses are coded on the LMS side that SqueezePlay can read and interpret correctly.

!!! note
    This page does not layout how to manage "home menu" items, that is, those top-level menu items sent to SqueezePlay as part of a "menu:menu" cli command request from SqueezePlay.

    [Home Menu items are managed differently](adding-menus-squeezeplay.md).

## Introduction

SlimBrowser is designed to browse music from SqueezeCenter. It expects data in the following form to build its menus (using approximate Perl syntax, where `{}` denotes a hash and `[]` an array):

```perl
{
    base = {
        <base_fields>
    },
    count = <count_value>,
    rescan = 1,
    goNow = <window push directive>,
    window = {
        <window_fields>
    },
    item_loop = [
        {
            <item_fields>
        },
        {
            <item_fields>
        },
        ...,
    ],
}
```

where (items in bold are mandatory):

* `base`
    * Contains are a number of fields applicable to the entire window/menu as defined in <base fields>
* __`count`__
    * Positive integer indicating how many items are available for the given query (which may be different than the number of items in the item_loop array; Jive requests shall support paging).
* `rescan`
    * If present with value 1, indicates a rescan is in progress. Jive behavior TBD.
* `goNow`
    * If present with a supported value, will immediately push the Squeezeplay UI to another pre-defined window. Supported values are "home", "nowPlaying", and "playlist", which will immediately push the Squeezeplay UI to the Home screen, the Now Playing screen, or the current playlist screen, respectively.
* `window`
    * if a window block is sent at the top level with the response data, the current rendered window on Squeezeplay should be styled with the parameters laid out in <window_fields>. Note that a window block contained within the base block or within an item block in the item_loop array is not for the current window but for the window created when executing a menu item callback (i.e. the "next" window").
* __`item_loop`__
    * Array containing the items, each containing a number of fields applicable to an individual menu item as defined in <item_fields>. A menu item can itself be a list, i.e. contain the fields described here to define the lower level. See hierarchical support below.

## `<base_fields>`

These fields allow defining values applicable to the entire menu or window.

```perl
{
    icon = "..."
    jsonrpc = "http://..."
    window = {
        <window_fields>
    }
    actions = {
        <actions_fields>
    }
    nextWindow = "..."
    setSelectedIndex = "..."
    onClick = "..."
}
```

* `icon`
    * Full or partial base URL for images.
* `window`
    * Allows specifying the elements to use for a window opened from this menu. See `<window_fields>`.
* `actions`
    * Allows specifying the command(s) to use for this menu. See `<actions_fields>`.
* `jsonrpc`
    * Allows to override the JSONRPC URL used by Jive (defaults to the JSON RPC server of the LMS it's browsing from).
* `nextWindow`
    * Specify a specific `nextWindow` for items in this window to jump to. See `<item_fields>` section for more detail.
* `setSelectedIndex`
    * Sets the selected index for the menu (if one exists) for the window loaded as specified by the `nextWindow` param. If no `nextWindow` is provided but a `setSelectedIndex` is, Squeezeplay will assume `nextWindow = 'refresh'`,
* `onClick`
    * specify a specific window for items to refresh with new data when the item is selected (this is really for use with radio/checkbox/choice items). `refreshMe`, `refreshOrigin`, and `refreshGrandparent` are valid values

## `<item_fields>`

These fields are parsed into a menu item. Some fields are designed to complement fields defined in the `<base_fields>`.

```perl
{
    text = "..."
    textkey = "."
    icon-id = ...
    icon = "..."
    extid = "..."
    radio = val
    checkbox = val
    slider = val
    selectedIndex = val
    choiceStrings = [ array ]
    nextWindow = val
    setSelectedIndex = integer
    onClick = val
    showBigArtwork = ...
    input = {
        <input_fields>
    }
    window = {
        <window_fields>
    }
    actions = {
        <actions_fields>
    }
    <action_alias> = "..."
}
```

Where (items in bold are mandatory):

* `text`
    * Menu item text. May contain `\n`, in which case the item is displayed on multiple lines.
* `textkey`
    * Single character indicating the sorted text key (index) of the item (introduced in 7.6).
* `icon-id`
    * Artwork ID. Will be fetched using a separate http request to LMS using the well known URL. The size is defined by the style. `icon-id` has precedence over `icon` (defined below).
* `icon`
    * Full or partial URL of some image to display.
* `extid`
    * The album's external ID, if it is eg. from an online music service.
* `radio`
    * If present, indicates a radio button is to be created for this item. Radio buttons must also involve a do action, defined in `<action_fields>`.
* `checkbox`
    * If present, indicates a checkbox is to be created for this item. Must be paired with on/off actions. See checkbox-specific items "on" and "off" under `<action_fields>`.
* `slider`
    * If present (typically set to a value of '1'), this item is meant to be rendered alone in a window without a menu. Currently, sliders must be the only item delivered in a request response.
* `selectedIndex`
    * If present, indicates a choice widget is to be created for this item. Must be paired with choiceStrings and a actions->do->choices array. See choice-specific item "choices" under `<action_fields>`.
* `choiceStrings`
    * Must be paired with `selectedIndex` and actions->do->choices. An array of strings to use in coordination with the choices array.
* `onClick`
    * specify a specific window for items to refresh with new data when the item is selected (this is really for use with radio/checkbox/choice items). `refreshMe`, `refreshOrigin`, and `refreshGrandparent` are valid values
* `showBigArtWork`
    * If present, indicates that the "go"/"do" action will return an artwork id or
      URL, which can be used the fetch an image to display in a popup.
* `nextWindow`
    * `nextWindow` is a special directive to tell Squeezeplay to load or refresh a particular window after executing the command.
    * `nextWindow` param at the item level takes precedence over a `nextWindow` directive at the base level, but a `nextWindow` param at the json command level (e.g., 'go' action) is highest precedence.
    * Valid `nextWindow` directives are:
        * `nowPlaying`: push to the Now Playing browse window
        * `playlist`: push to the current playlist window
        * `home`: push to the top level "home" window
        * `parent`: push back to the previous window in the stack and refresh that window with the json that created it
        * `parentNoRefresh`: same as parent but do not refresh the window
        * `grandparent`: push back two windows in the stack
        * `refresh`: stay on this window, but resend the cli command that was used to construct it and refresh the window with the freshly returned data
        * `refreshOrigin`: push to the previous window in the stack, but resend the cli command that was used to construct it and refresh the window with the freshly returned data
        * (7.4+) Any other value of a window that is present on the window stack and has a `windowId` in it's window fields. Search the window stack backwards until a window with this `windowId` is found and pop all windows above it.
* `setSelectedIndex`
    * Sets the selected index for the menu (if one exists) for the window loaded as specified by the `nextWindow` param. If no `nextWindow` is provided but a `setSelectedIndex` is, Squeezeplay will assume `nextWindow = 'refresh'`.
* `input`
    * If present, indicates user input is required before proceeding with the actions. See <input_fields>.
* `window`
    * Allows specifying the elements to use for a window opened from this menu. See <window_fields>.
* `actions`
    * Allows specifying the command(s) to use for this menu. See <actions_fields>.
* `<action_alias>`
  * If present in item, instructs the client to use a different Action for the given action.
  * The actions which can be renamed and their aliases are:

    | Action      | Alias            |
    |-------------|------------------|
    | "play"      | "playAction"     |
    | "play-hold" | "playHoldAction" |
    | "add"       | "addAction"      |
    | "go"        | "goAction"       |


## `<input_fields>`

Used if input is required before proceeding with the action. Specifies length to input, allowed chars and help text or token.

```perl
{
    len = ...
    allowedChars = "..."
    inputStyle = "...",
    help = {
        text = "...",
        token = "...",
    }
    softbutton1 = "...",
    softbutton2 = "...",
}
```

Where (items in bold are mandatory):

* __`len`__
    * Min number of characters to request before proceeding.
* `allowedChars`
    * Overrides the set of characters allowed for input. The default value is given by the localized `ALLOWEDCHARS_NOCAPS` string in share/jive/global_strings.txt. In EN, this is " abcdefghijklmnopqrstuvwxyz!@#$%^&*()_+{}|:\\\"'<>?-=,./~`[];0123456789"
* `inputStyle`
    * Specifies the style of text input to be performed. Defaults to 'text'. Other values are 'time' and 'ip'.
* `initialText`
    * String that contains what should be filled into the text input entry as a default.
* `help`
    * A help text, if any. Can be specified either using the localized text or a token (localized by Jive).
* `softbutton1`, `softbutton2`
    * Text for softbuttons, if any. If either of these are configured, the help text widget will change from 'help' to 'softHelp' to accomodate the layout of the buttons.


## `<window_fields>`

If selecting an item results in opening a new window (i.e. the "go" action), the window fields, if present, will be used instead of the item fields for the window title and style. Fields defined in an item override any field defined in `<base_fields>.<window_fields>`.

```perl
{
    text = "..."
    textarea = "..."
    textareaToken = "..."
    icon-id = ...
    icon = "..."
    titleStyle = "..."
    menuStyle = "..."
    windowStyle = "..."
    help = {
             text = "..."
    }
    windowId = "..."
}
```

Where (items in bold are mandatory):

* `text`, `icon-id`, and `icon`
    * Same semantic as for items. Typically, these are different for each item and are defined in `<item_fields>.<window_fields>`.
* `textarea`
    * Send block of text for display of a textarea in the opened window. For use when window will not have a menu to display, or when the menu to display is without any decorated widgets like radio buttons, checkboxes, or choice items.
* `textareaToken`
    * Same as textarea, but send a string token that is translated on the client-side. Same caveats as textarea apply. `textareaToken` is used for a specific case and is unlikely to be useful for plugin development.
* `titleStyle` and `menuStyle`
    * Style of the title (resp. menu) of the new window. Typically, this is the same for all items and is defined in `<base_fields>.<window_fields>`. The only supported value is "album" (for multiline with icon title/item).
* `windowStyle`
  * Style of the new window. If absent and menuStyle is "album" then use "icon_list". Default value is "text_list".
  * Supported values:
    * "home_menu"
    * "icon_list"
    * "text_list"
* `help{text}`
    * Displays help text at the bottom of a window.
* `windowId`
    * Defines an id for a window. This `windowId` can be used with the "`nextWindow`" item directive to move backwards to this window on the window stack.


## `<actions_fields>`

The action fields specify the command sent by Jive when the user performs an action on the item, for example presses a key. In many cases, the command to be performed is the same regardless of the item (f.e., play), only one parameter will change for each item (f.e., the item id). The syntax therefore allows actions to be defined in the [`#base_fields <base_fields>`] and being completed in the [`#item_fields <item_fields>`]. It is however possible to define completely a command at the item level.

```perl
{
    <action_name> = "<url_command>"
    <action_name> = {
        <json_command>
    }
    <action_name> = null

    <json_params_id> = {
        <params>
    }
}
```

Actions are identified by their name, corresponding to the keys or other controls available on Jive. Actions can refer to a JSON command or a URL (this shall remain coherent between base and item level). Actions can be set as "null" to have no effect (to prevent a pre-defined or base-defined command to work on a particular menu or item).

`<json_params_id>` is only available in items, see json commands below.

### `<action_name>`
Actions are defined using a string composed of the key pressed and its holding state.

* __`keys`__
    * One of "go"/"do", "more", "back", "play", "add", "rew", "fwd" or "pause".
* __holding state__ or "-hold" (not for "go"/"do", "more" and "back")

For example, field play-hold defines the command to send when the play key is held. It can be defined at the item level (applies to the item only), or at the base level. In this last case, it can be complemented by params defined at the item level.

### `<url_command>`
URLs are strings, enclosed in quotes. MULTI-LEVEL

### `<json_command>`

JSON RPC commands consist of a hash with the following keys:

```perl
{
    player = 0
    cmd = ["...", "..."]
    params = {
        <param_name> = ...,
        ...
    }
    itemsParams = <json_params_id>
    nextWindow = "...",
}
```

* `player`
    * Player if the command requires it. The actual value is replaced by Jive.
* `cmd`
    * Array of command terms, f.e. `['playlist', 'jump']`.
* `params`
    * Hash of parameters, f.e. `{sort = new}`. Passed to the server in the form "key:value", f.e. 'sort:new'.
        * The value `__INPUT__` is replaced by any user entered data.
        * The value `__TAGGEDINPUT__` is replaced by user entered data in a "key:value" format. For example, the param foo = `__TAGGEDINPUT__` would be replaced by 'foo:<user-entered input>'
* `itemsParams`
    * In base level commands, this defines the name of the field in the item [`<actions_fields>`](#actions_fields) that must be used to complete the command for a particular item. See the example below.
* `nextWindow`
    * If a `nextWindow` param is given at the json command level, it takes precedence over a `nextWindow` param at the item level, which in turn takes precendence over a `nextWindow` param at the base level. See <item_fields> section for more detail on this parameter.
* `setSelectedIndex`
    * Sets the selected index for the menu (if one exists) for the window loaded as specified by the `nextWindow` param. If no `nextWindow` is provided but a setSelectedIndex is, squeezeplay will assume `nextWindow = 'refresh'`. The same precedence rules apply here as do for `nextWindow` described above.


### Slider actions

Slider objects sent from SC are a special case in that they are not contained in a menu, therefore need to be sent as a single item request response. The item needs to look something like this:

```perl
{
    slider      => 1,
    min         => val,
    max         => val,
    adjust      => val,
    initial     => val,
    sliderIcons => '...',
    text        => '...',
    help        => '...',
    actions => {
        do => {
            player => 0,
            cmd    => [ ... ],
            params => {
                valtag => '...',
            },
        },
    },
}
```

Where (items in __bold_ are mandatory):

* __`slider`__
    * identifies item to be delivered as a slider object.
* __`min`__
    * the minimum value of the range of values to be set
* __`max`__
    * the maximum value of the range of values to be set
* `adjust`
    * the slider object on SBC doesn't cope well with values <=0, so this is an adjustment, for the purpose of Squeezeplay's slider rendering only, to the min/max values. This value typically (though not necessarily) when added to min is equal to 1. For example, if you had a min of -23 and a max of 23, the adjust value would be 24.
* `initial`
    * the initial pre-adjust value to set the slider to. When absent, defaults to min.
* `sliderIcons`
    * In the absence of this parameter, a - and + icon are added to either end of the slider widget. Possible values for sliderIcons are 'volume' and 'none'. 'volume' renders vol- and vol+ icons on either end of the slider object. 'none' shows no icons, only the slider.
* `text`
    * when present, this renders text above the slider in a textArea widget.
* `help`
    * when present, delivers help text in a helptext box on the window
* __`actions`__, __`actions.do`__ and __`actions.do.params.valtag`__
    * slider objects require a 'do' action, and that do action needs to have a cli command callback that identifies, via the valtag param, the tag to be used in the callback. For example, for a command that requires a format of

```
  <player_id> testcommand foo:val
```

The actions portion of the slider item would be configured like so:

```
actions => {
    do => {
        player => 0,
        cmd    => [ 'testcommand' ],
        params => {
            valtag => 'foo',
        },
    },
},
```

The value the user scrolls to on the slider sets the value that is sent back with the tagged parameter 'foo'
For further reference Slim::Control::Jive has several spots where sliders are configured and delivered.


### Go Do, On and Off actions
"go" refers to a command that opens a new window (i.e. returns results to browse), while "do" refers to an action to perform that does not return browsable data. "do" takes precedence over "go".

"on" and "off" are similar to "do", but are used in the specific case of a checkbox item (i.e., one "do" action for when the checkbox is checked, one for when it is unchecked).

Paging parameters (json: _index and _qty, url: TBD) are added automatically by Jive for "go".

### More actions
"more" refers to a command that opens as a context menu.

Paging parameters (json: _index and _qty, url: TBD) are added automatically by Jive.

### Choices array in Do action
If a "choices" array of commands is sent in the do actions hashref along with a selectedIndex var and choiceStrings array in the main body of the item, each of the choices array elements will be paired with the choiceStrings and the menu item will be delivered with a choice widget. Each element in the choices array will form the command callback when that choice is selected.

### Pre-defined actions
Some actions have "built in" defaults: the presence of a new action overrides Jive's standard (built in) behavior.

* back
    * Goes up one level in the browsing, closing the current window. Override not supported.
* rew
    * Does `playlist jump -1` or `playlist jump 0` depending on the repetition rate of the key
* fwd
    * Does `playlist jump +1`
* pause
    * Does `pause 0` or `pause 1` depending on the player state
* pause-hold
    * Does `stop`
* play, play-hold, add, add-hold, rew-hold, fwd-hold
    * These have no predefined command.

### Special params
Some parameters have special meaning in the client.

* slideshow
    * If present, the action is expected to return a list of images in the format described in Slideshow.
* isContextMenu
    * If present, the action result shall display in a context menu instead of a new window.

### Slideshow

```perl
{
    base = {
        <base_fields>
    },
    offset = 0,
    title = "...",
    data = [
        {
            <image_fields>
        },
        {
            <image_fields>
        },
        ...,
    ],
}
```

### `<image_fields>`

```perl
{
    image = "...",
    caption = "..."
}
```

* __`image`__
  * Full or partial URL of some image to display.
* __`caption`__
  * A short piece of text that describes the image

### Example

```
{
    // no base defined as most items have a very different command set

    count = 3,
    // because the top menu contains few elements, Jive got them all in one step and this is equal to the number of elements
    // in the item_loop array below.

    item_loop = [
        {
            text = 'Albums',
            // this is what the menu item will show. No icon or icon-id defined, so the menu item is text only.

            actions = {
                go = {
                    cmd = ['albums'],
                    params = {
                            menu = "tracks"
                    }
                }
                // our action command will requests albums from the server using JSON

                // no other actions defined, so pressing play f.e. has no effect
            }
        },
        {
            text = 'New music',

            window = {
                text = 'Surprise!',
                icon = 'http://....'
            },
            // Normally Jive opens a window titled using the text of the menu item (i.e. "text"), but in this case
            // we want the window title to be different and read "Surprise!"

            actions = {
                go = {
                    cmd = ['albums'],
                    params = {
                        sort = 'new',
                        tags = 'jsjs',
                        menu = 'tracks',
                    }
                }
            }
        },
        {
            text = 'Browse SlimNetwork',
            actions = {
                go = "http://slimnetwork/browse"
                // SN uses URLs, not JSON commands
            }
        },
        {
            text = 'Settings',

            // this is hierarchical so we define here the items
            count = 5,
            item_loop = [
                ...
            ]
        },
        {
            text = 'Search',
            // ask user for at least 3 chars before firing the action
            input = 3,
            actions = {
                go = {
                    cmd = ['search'],
                    params = {
                        // __TAGGEDINPUT__ will be replaced by the entered text in the form "search:"
                        search = '__TAGGEDINPUT__',
                        tags = 'blabla',
                        menu = 'tracks',
                    }
                }
            }
        },
    ]
}
```

Selecting albums issues the command defined in actions.action and returns the following data:

```
{
    base = {
            icon = "art?id="
            actions = {
                    go = {
                            cmd = ['tracks'],
                            params = {
                                    menu = "songinfo",
                            },
                            itemParams = 'anyParams',
                    }
                    play = {
                            player = 0,
                            cmd = ['playlistctrl'],
                            params = {
                                    cmd = 'load'
                            },
                            itemParams = 'anyParams',
                    }
            }
    }

    count = 12,

    item_loop = [
        {
            text = "Play all",
            actions = {
                do = {...} // overrides go in base
            },
        },
        {
            text = "Rock",
            icon = "rock.jpg", // a partial URL, combined with the above
            anyParams = {
                genre_id = 33,
            },
        },
        {
            text = "Alternative",
            icon-id = 33,  // a SS artworkId
            anyParams = {
                genre_id = 34,
            },
        },
        ...
    ]
}
```

## showBriefly communications

The server provides a facility for sending messages to clients via the `$client->showBriefly()` method. The purpose of the `showBriefly` is (typically) to show a brief popup message on the display to convey something to the user. This method has been in use for many years, originally for the ip3k-based Squeezeboxes (slimp3, squeezebox 1/2/3, boom), but has also been adapted for Squeezeplay-based players (Controller, Radio, Touch). For Squeezeplay-based players, this is done via the jive block in a `showBriefly` message.

`showBriefly` messages are communicated to Squeezeplay devices via the displaystatus notification subscription and are handled by the jive.slim.Player class on the Lua side. `showBriefly` messages operate independently of SlimBrowser/SlimMenu communication, and (typically) produce transient popup windows that are not part of the browse stack (but are part of the Framework stack).


### `jive` block

A typical `jive` block in a `showBriefly` might look like this

```perl
$client->showBriefly( {
    'jive' => {
        'text' => [
            $client->string('FAVORITES_ADDING'),
            $title,
        ],
    },
} );
```

`text` is an array block of text to be sent for display in the showBriefly. Other parameters that can be sent in the jive block:

* `type`
    * tells SP what style of popup to use. Valid types are 'popupplay', 'icon', 'song', 'mixed', and 'popupalbum'. In 7.6, 'alertWindow' has been added (see next section)
* `duration`
    * duration in seconds to display the showBriefly popup. Defaults to 3 seconds. In 7.6, a duration of -1 will create a popup that doesn't go away until dismissed.
* `style`
    * used for specific styles to be used in popup windows, e.g. adding a + badge when adding a favorite.

See jive/slim/Player.lua code in the _process_displaystatus() method for specifics on how SP handles the variations sent from the server for showBriefly messages.

### `alertWindow`

7.6 introduces the ability to send a `showBriefly` message that will push a full, non-transient window to the squeezeplay UI. This is done with an alertWindow specification within the jive block. `alertWindow` supports two params inside the block: title, which is text to display in the title bar of the window, and text, which is the text to display in the body of the window as a textarea widget. The alertWindow is meant for messages that should not leave the screen without the user dismissing it explicitly, and as a full window has the ability of passing much larger text messages than in a small popup.

An `alertWindow` can be sent by sending a type of `alertWindow` in the jive block

```perl
$client->showBriefly( {
    'jive' => {
        type => 'alertWindow',
        title => $client->string('PLAYER_ON_FIRE'),
        'text' => [
            $client->string('OH_NO'),
            $client->string('YOUR_PLAYER_IS_ON_FIRE_DESCRIPTION'),
        ],
    },
} );
```

## NOTES

* There is a dependency between the style (in Jive) and the data returned.
* Settings are not supported by the above syntax.
* The business with checking for multiple params should not cause performance issues as it is done "rarely" (at each button press, but not while scrolling, building the menu, etc.)

## LMS (SqueezeCenter) command implementation

A new "menu" query is defined to handle the top level menu. Other existing queries are re-used, but a new parameter "menu" is added that allows:

* declaring usage in menu mode (the data returned conforms to the syntax above)
* indicate the next browse level

For example, the hierarchy [genres, artist, album] is done using a top level menu with command "genres menu:artist", that generates items with commands "artists menu:albums", etc... This is done in order to re-use the code of these queries. Experience shows they are high maintenance.