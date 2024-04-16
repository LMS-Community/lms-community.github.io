---
layout: default
title: Learn more about how this data is gathered
---

# Learn more about how this data is gathered

Bundled in LMS versions 8.5.1 and 9.0.0 is the "Report Analytics Data" plugin. This plugin doesn't collect personal data. It can be disabled like any plugin, but users are encouraged to keep it enabled. Reports will be sent a few minutes after the system start, and then once a week. The analytics data is sent to [stats.lms-community.org](https://stats.lms-community.org), for which the code is maintained on [Github](https://github.com/LMS-Community/lms-stats-service). 

The following data is gathered:

- Hashed UUID of server
- LMS version and revision
- Operating System
- Perl version
- Hardware platform
- Number and types of connected players
- List of installed plugins
- Selected skin
- Number of tracks
- Country

You can enable debug logging for `plugin.analytics` to see what is being reported:

```
Slim::Plugin::Analytics::Plugin::_reportStats (53) nIj.............YhF8: {
  os          => "linux",
  osname      => "Debian (Docker)",
  perl        => "5.32.1",
  platform    => "x86_64-linux",
  playerTypes => { baby => 1, fab4 => 1, receiver => 1 },
  players     => 3,
  plugins     => [
                   "1001Albums",
                   "AudioScrobbler",
                   "Bandcamp",
                   .........
                   "TIDAL",
                   "ViewTags",
                 ],
  revision    => "1712965357",
  skin        => "Default",
  tracks      => 441,
  version     => "9.0.0",
}
```
