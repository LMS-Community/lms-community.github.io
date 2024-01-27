---
layout: default
title: LMS Repositories Developers
---

# LMS Repositories Developers

LMS 7.3+ includes a plugin which enables extensions to be downloaded to LMS and Jive (for example Squeezebox Radio). 3rd party authors may host their own content for download and define a repository xml file which refers to it.
The xml format is:

```xml
 <?xml version="1.0"?>
 <extensions>
   <details>
     <title lang="EN">The Repository's Title</title>
   </details>
   <applets>
     <applet name="AppletName" version="1.0" target="jive" minTarget="7.3" maxTarget="7.3">
       <title lang="EN">English Title</title>
       <title lang="DE">German Title</title>
       <desc lang="EN">English description</desc>
       <desc lang="DE">German description</desc>
       <changes lang="EN">English change log</changes>
       <changes lang="DE">German change log</changes>
       <creator>Name of Author</creator>
       <email>email of Author</email>
       <url>url for zip file</url>
       <sha>digest of zip</sha>
     </applet>
   </applets>
   <plugins>
     <plugin name="PluginName" version="1.0" target="windows" minTarget="7.9" maxTarget="*">
       <title lang="EN">English Title</title>
       <title lang="DE">German Title</title>
       <desc lang="EN">English description</desc>
       <desc lang="DE">German description</desc>
	   <category>categorycode</category>
       <changes lang="EN">English change log</changes>
       <changes lang="DE">German change log</changes>
       <creator>Name of Author</creator>
       <email>email of Author</email>
       <url>url for zip file</url>
       <sha>digest of zip</sha>
     </plugin>
   </plugins>
   <wallpapers>
     <wallpaper name="WallpaperName" url="url for wallpaper file" />
   </wallpapers>
   <sounds>
     <sound name="SoundName"     url="url for sound file"     />
   </sounds>
 </extensions>
```

* `name` - the name of the applet/plugin - must match the file naming of the lua/perl packages
* `version` - the version of the applet/plugin (used to decide if a newer version should be installed)

    an example of a set of increasing versions ... 1.0, 1.1a, 1.1b, 1.1

* `target` - string defining the target, you can specify multiple target by separating them by '|' (optional - all if not defined)

    For applets you can use 'jive' (=SB-Controller), 'fab4' (=SB-Touch) or 'baby' (=SB-Radio). Omit the target attribute if you want your applet to be available for all devices, otherwise set to one or more targets (split by |).

    For plugins if set this specfies the target architecture and may include multiple strings from "windows|mac|unix"

* `minTarget` - min version of the target software
* `maxTarget` - max version of the target software or * for no limit
* `title` - contains localisations for the title of the applet (optional - uses name if not defined)
* `desc` - localised description of the applet or plugin (optional)
* `category` - (plugin only) a single category from the list shown below (optional)
* `changes` - localised change log of the applet or plugin (optional)
* `link` - (plugin only) url for web page describing the plugin in more detail
* `creator` - name of author(s) (optional)
* `email` - email of authors(s) (optional)
* `url` - url for the applet/plugin itself, this should be a zip file
* `sha` - (plugin and applet only) sha1 digest of the zip file which is verifed before the zip is extracted

* `categorycode` - it is used when generating lists of plugins to make it easier for users to browse by topic - pick from one of the following (without quotation marks):

    'hardware', 'information', 'misc', 'musicservices', 'playlists', 'radio', 'scanning', 'skin', 'tools'

    If you are unsure which category to pick then do not provide one or use 'misc' for miscellaneous.  
    If the plugin could be in more than one category then pick the one that you think end-users would be most likely to think of first when trying to find it.  
    If you invent your own categorycode then it will be ignored and the plugin will appear in the 'misc' category.

Further details are available in the comments of the Slim::Plugins::Extensions::Plugin source file.

Take a look at pre-existing repository definition files to see how other developers have used this.
You can see an aggregation of these in the auto-generated extension list at [LMS-Community/lms-plugin-repository](https://github.com/LMS-Community/lms-plugin-repository/blob/master/extensions.xml)

## LMS Plugins

Authors should create their plugins in the standard way with packages named as Plugins::name:: where 'name' is reused for the name of the plugin in the repository.

A common starting point for new development is to look at a pre-existing plugin (probably a simple one) to see how it was put together.

Plugins may be packaged into a zip file using PluginBuilder (ed: link required) or by manually zipping the contents of the directory into a zip file. A sha1 checksum of the zip file should also be created. The zip file should then be hosted at a url which is defined in the url element of the plugin xml entry with the sha1 element containing its sha1 checksum.

## Hashing Files

If developing on Windows then a good small freeware utility to produce a sha1 hash can be found at [Nirsoft - HashMyFiles](https://www.nirsoft.net/utils/index.html).
