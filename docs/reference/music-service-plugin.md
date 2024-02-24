---
layout: default
title: Music Service Plugin
---

# Music Service Plugin Implementation Guide

This documen tries to outline how to implement an integration with a music service. It's base on the experience made with eg. [Spotty](https://github.com/michaelherger/Spotty-Plugin) or [Qobuz](https://github.com/pierrepoulpe/SqueezeboxQobuz). Check out one of those plugins if you want to get more ideas.

## File/Module Organization

Here's a rough layout of a typical folder and file structure for a plugin:

* `Plugins/MyMusicService`
    * `Plugin.pm`: this is the entry point to the plugin. It deals with setting up all dependencies and gives shared code a home. It initializes the settings, importer, protocol handler etc.
    * `API.pm`: this module implements the API interaction with the music service. In many cases we want to further split it up (see below) for async (server) and sync (scanner/importer) modes. In this case I put shared code in `API.pm`, eg. URLs, data manipulation routines etc. I usually provide one method per API call.
        * `API/Async.pm`: these API call implementations use LMS' own `Slim::Networking::SimpleAsyncHTTP` class to run non-blocking requests. This is crucial to not interrupt playback, as LMS is single threaded.
        * `API/Sync.pm`: in order to run synchronous API calls you can use `LWP::UserAgent`. This is important for eg. the importer code, as the scanner doesn't provide the aforementioned support for async calls.
    * `OPML.pm` (or `Browse.pm`): the `OPML` name is a bit outdated. What I put in there is the code which provides the browse modes, the navigation tree. All API calls done within this module must use *async* HTTP requests to not block the server. I try to separate out navigation tree nodes into their own subs. Typically such a sub would call the API to get back the raw data, then transform this data into navigation elements.
    * `ProtocolHandler.pm`: the protocol handler class deals with much of the playback (and deserves its own document...). LMS uses pseudo protocols like `spotty://` or `qobuz://` to deal with tracks and other aspects of these services.
    * `Settings.pm`: handle configuration tasks for the plugin. Sometimes there's more to it, eg. if special pages or handlers are required for authentication etc. In this case we can have additional modules in the `Settings` namespace.
        * `Settings/Auth.pm`: another handler to deal with authentication
    * `Importer.pm`: this module is used when a music service can be imported into the "My Music" collection. It would be called to import favorite artists, albums, etc. from the music service. All API calls done from the importer must use *synchronous* HTTP requests!
        * `startScan()`: this is the entry point called from the scanner code. Everything called from here must not use any of the async stuff usually used in the server.
        * `needsUpdate()`: this method tells the Online Music Library Integration plugin whether any change in a user's music service account requires a rescan of the library. This method must use async calls, as it's run in the server. It should be a relatively cheap call or series of calls to get a fingerprint of the user's library with the service. If the fingerprint changes, OMLI should re-run a scan. Some services would have such a fingerprint or "last changed" timestamp in the user's profile. On others it can be helpful to see how many itemst there are (albums, playlists, artists), and/or the latest change to any of them happened etc. This avoids pulling in all the library just to figure out whether a rescan was even required.
    * `HTML/EN/plugins/MyMusicService`: this folder provides the home for HTML templates, static content like stylesheets, JavaScript etc.
        * `html`: this additional subfolder is the home of static content. It can be accessed without an additional page handler. Images belong here.
        * `settings`: if there's a need for more than the basic settings page I often put the templates in their own subfolder. That's absolutely optional.
    * `Bin/*`: provide a home for platform specific binaries, if needed.
    * `lib`: put your additional CPAN modules in there.
    * `install.xml`: the plugin's manifest file.
    * `strings.txt`: a simple text file with string translations. See [Adding Translations](../contributing/adding-translations.md) for details about the format.


## Important Notes

* Be kind to the music service. Try to avoid unnecessary requests by using caching etc. You don't want to run into request rate limitations.
* Don't cache too aggressively: users know when they changed something on the service. They want changes to show up in LMS immediately. Therefore I'd often cache user specific data like favorites for a minute or two, only.
* Read the API documentation.
    * Some APIs allow you to tell what data to return. Don't request data you don't need!
    * Respect rate limitations. Many services return headers with information about available requests etc. Use them, don't run blindly until you're blocked. It could harm the plugin's reputation.
    * Sometimes there are requests like profile information, which can tell us whether favorites have changed or not. This usually is more efficient than requesting that data whenever needed.
    * Don't try to avoid paywalls! We want to be good citizens. Doing illegal activity could not only harm you, but all of the LMS community!
* Start small, release often. Start with a basic plugin and add features as requests come up. This allows you to optimize your code along the way, before you've got too much code.
* Try to support multiple accounts. Your users sooner or later will ask for them. In order to do this you should make the API implementation instantiable. That way each client can carry a reference to their API instance.
* Don't hard code textual content. Always use localizable string tokens.

