---
hide:
    - navigation
layout: default
title: LMS Downloads
---

!!! hint
    If you’re looking for the Docker image of Lyrion Music Server, please head over to the [:material-docker: Docker Hub Page](https://hub.docker.com/r/lmscommunity/lyrionmusicserver) or the [:material-github: Github Container Registry](https://github.com/LMS-Community/slimserver/pkgs/container/lyrionmusicserver).

## v{{ latest.version }} - Latest Release

This is the released version. Please see [Getting Started](../getting-started/index.md) for more information.
([Changelog](https://htmlpreview.github.io/?https://raw.githubusercontent.com/LMS-Community/slimserver/{{ latest.version }}/Changelog{{ latest.majorVersion }}.html) -
[Git Commit Log](https://github.com/LMS-Community/slimserver/commits/{{ latest.version }}))

!!! hint
    Mac users please note: we no longer ship a preference pane, but a menu bar item. Please see
    [How to uninstall the legacy Mac Settings Pane Item](../reference/uninstall-legacy-mac.md) for instructions
    how to uninstall it.

!!! hint
    Windows 32-bit users please note: your beloved Windows 32-bit build is no longer available due to hardware
    failure on the build system. You will have to migrate to the new 64-bit version. Please read
    [How to migrate from Windows 32-bit build to 64-bit](../reference/migrate-win32-win64.md).

| Name | Size | Creation Date | Description |
| ---  | --- :| ---           | ---  |
| [{{ latest.win64.name }}]({{ latest.win64.url }}) | {{ latest.win64.size }} | {{ latest.win64.timestamp }} | {{ latest.win64.desc }} |
| [{{ latest.macos.name }}]({{ latest.macos.url }}) | {{ latest.macos.size }} | {{ latest.macos.timestamp }} | {{ latest.macos.desc }} |
| [{{ latest.debamd64.name }}]({{ latest.debamd64.url }}) | {{ latest.debamd64.size }} | {{ latest.debamd64.timestamp }} | {{ latest.debamd64.desc }} |
| [{{ latest.debarm.name }}]({{ latest.debarm.url }}) | {{ latest.debarm.size }} | {{ latest.debarm.timestamp }} | {{ latest.debarm.desc }} |
| [{{ latest.debi386.name }}]({{ latest.debi386.url }}) | {{ latest.debi386.size }} | {{ latest.debi386.timestamp }} | {{ latest.debi386.desc }} |
| [{{ latest.deb.name }}]({{ latest.deb.url }}) | {{ latest.deb.size }} | {{ latest.deb.timestamp }} | {{ latest.deb.desc }} |
| [{{ latest.rpm.name }}]({{ latest.rpm.url }}) | {{ latest.rpm.size }} | {{ latest.rpm.timestamp }} | {{ latest.rpm.desc }} |
| [{{ latest.nocpan.name }}]({{ latest.nocpan.url }}) | {{ latest.nocpan.size }} | {{ latest.nocpan.timestamp }} | {{ latest.nocpan.desc }} |
| [{{ latest.tararm.name }}]({{ latest.tararm.url }}) | {{ latest.tararm.size }} | {{ latest.tararm.timestamp }} | {{ latest.tararm.desc }} |
| [{{ latest.encore.name }}]({{ latest.encore.url }}) | {{ latest.encore.size }} | {{ latest.encore.timestamp }} | {{ latest.encore.desc }} |
| [{{ latest.src.name }}]({{ latest.src.url }}) | {{ latest.src.size }} | {{ latest.src.timestamp }} | {{ latest.src.desc }} |


## v{{ stable.version }} - Stable Nightly Build

The stable branch is like the officially released latest version, with some additional bug fixes. Use this if you want to use a reliable system, but need an important fix.
([Changelog](https://htmlpreview.github.io/?https://raw.githubusercontent.com/LMS-Community/slimserver/public/{{ stable.minorVersion }}/Changelog{{ stable.majorVersion }}.html) -
[Git Commit Log](https://github.com/LMS-Community/slimserver/commits/public/{{ stable.minorVersion }}))

| Name | Size | Creation Date | Description |
| ---  | --- :| ---           | ---  |
| [{{ stable.win64.name }}]({{ stable.win64.url }}) | {{ stable.win64.size }} | {{ stable.win64.timestamp }} | {{ stable.win64.desc }} |
| [{{ stable.macos.name }}]({{ stable.macos.url }}) | {{ stable.macos.size }} | {{ stable.macos.timestamp }} | {{ stable.macos.desc }} |
| [{{ stable.debamd64.name }}]({{ stable.debamd64.url }}) | {{ stable.debamd64.size }} | {{ stable.debamd64.timestamp }} | {{ stable.debamd64.desc }} |
| [{{ stable.debarm.name }}]({{ stable.debarm.url }}) | {{ stable.debarm.size }} | {{ stable.debarm.timestamp }} | {{ stable.debarm.desc }} |
| [{{ stable.debi386.name }}]({{ stable.debi386.url }}) | {{ stable.debi386.size }} | {{ stable.debi386.timestamp }} | {{ stable.debi386.desc }} |
| [{{ stable.deb.name }}]({{ stable.deb.url }}) | {{ stable.deb.size }} | {{ stable.deb.timestamp }} | {{ stable.deb.desc }} |
| [{{ stable.rpm.name }}]({{ stable.rpm.url }}) | {{ stable.rpm.size }} | {{ stable.rpm.timestamp }} | {{ stable.rpm.desc }} |
| [{{ stable.nocpan.name }}]({{ stable.nocpan.url }}) | {{ stable.nocpan.size }} | {{ stable.nocpan.timestamp }} | {{ stable.nocpan.desc }} |
| [{{ stable.tararm.name }}]({{ stable.tararm.url }}) | {{ stable.tararm.size }} | {{ stable.tararm.timestamp }} | {{ stable.tararm.desc }} |
| [{{ stable.encore.name }}]({{ stable.encore.url }}) | {{ stable.encore.size }} | {{ stable.encore.timestamp }} | {{ stable.encore.desc }} |
| [{{ stable.src.name }}]({{ stable.src.url }}) | {{ stable.src.size }} | {{ stable.src.timestamp }} | {{ stable.src.desc }} |


## v{{ dev.version }} - Development Build

The development version is where you’ll find all the latest and greatest features. But as it’s under development you might encounter bugs, or changing behaviour.
([Changelog](https://htmlpreview.github.io/?https://raw.githubusercontent.com/LMS-Community/slimserver/public/{{ dev.minorVersion }}/Changelog{{ dev.majorVersion }}.html) -
[Git Commit Log](https://github.com/LMS-Community/slimserver/commits/public/{{ dev.minorVersion }}))

!!! danger
    Please only use this build if you’re willing to deal with the occasional broken revision!

| Name | Size | Creation Date | Description |
| ---  | --- :| ---           | ---  |
| [{{ dev.win64.name }}]({{ dev.win64.url }}) | {{ dev.win64.size }} | {{ dev.win64.timestamp }} | {{ dev.win64.desc }} |
| [{{ dev.macos.name }}]({{ dev.macos.url }}) | {{ dev.macos.size }} | {{ dev.macos.timestamp }} | {{ dev.macos.desc }} |
| [{{ dev.debamd64.name }}]({{ dev.debamd64.url }}) | {{ dev.debamd64.size }} | {{ dev.debamd64.timestamp }} | {{ dev.debamd64.desc }} |
| [{{ dev.debarm.name }}]({{ dev.debarm.url }}) | {{ dev.debarm.size }} | {{ dev.debarm.timestamp }} | {{ dev.debarm.desc }} |
| [{{ dev.deb.name }}]({{ dev.deb.url }}) | {{ dev.deb.size }} | {{ dev.deb.timestamp }} | {{ dev.deb.desc }} |
| [{{ dev.rpm.name }}]({{ dev.rpm.url }}) | {{ dev.rpm.size }} | {{ dev.rpm.timestamp }} | {{ dev.rpm.desc }} |
| [{{ dev.nocpan.name }}]({{ dev.nocpan.url }}) | {{ dev.nocpan.size }} | {{ dev.nocpan.timestamp }} | {{ dev.nocpan.desc }} |
| [{{ dev.tararm.name }}]({{ dev.tararm.url }}) | {{ dev.tararm.size }} | {{ dev.tararm.timestamp }} | {{ dev.tararm.desc }} |
| [{{ dev.encore.name }}]({{ dev.encore.url }}) | {{ dev.encore.size }} | {{ dev.encore.timestamp }} | {{ dev.encore.desc }} |
| [{{ dev.src.name }}]({{ dev.src.url }}) | {{ dev.src.size }} | {{ dev.src.timestamp }} | {{ dev.src.desc }} |


## Downloads Museum

If you're interested in older releases, feel free to visit the [download museum](archive.md).


## Squeezebox Firmware

And [here](listing.md?update/firmware/8.5.1/) are the last _official_ Squeezebox Firmware images available for you.

More recent firmware images for Squeezebox Touch, Radio, and Controller are available through the "Community Firmware" plugin. See the [Plugins](../plugins/index.md) section for details about how to install plugins..

