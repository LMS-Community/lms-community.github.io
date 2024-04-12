---
layout: default
title: Learn more about how this data is gathered
---

# Learn more about how this data is gathered

Bundled in LMS versions 8.5.1 and 9.0.0 is the "Report Analytics Data" plugin. This plugin is disabled by default and users are encouraged to enable it to start sharing your data. Reports will be sent a few minutes after the system start, and then once a week. The analytics data is sent to a Cloudflare relational database (stats.lms-community.org).

The following data is gathered:

- hashed UUID of server
- LMS version and revision
- OS
- Perl version
- hardware platform
- number of connected players
- list of installed plugins
- selected skin
- number of tracks

You can enable debug logging for `plugin.stats` to see what is being reported:

```
Slim::Plugin::Stats::Plugin::_reportStats (53) nIj.............YhF8: {
  os => "macOS 14.4.1",
  perl => "5.34.0",
  platform => "arm64",
  players => 0,
  plugins => [
        "1001Albums",
        "AudioScrobbler",
        "Bandcamp",
        .........
        "TIDAL",
        "ViewTags",
      ],
  skin => "Default",
  tracks => 441,
  version => "8.5.1",
}
```
