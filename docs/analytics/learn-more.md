---
layout: default
title: Learn more about how this data is gathered
---

# Learn more about how this data is gathered

Bundled in LMS versions 8.5.1 and 9.0.0 is the "Report Analytics Data" plugin. This plugin doesn't collect personal data. It can be disabled like any plugin, but users are encouraged to keep it enabled. Reports will be sent a few minutes after the system start, and then once a week. The analytics data is sent to [stats.lms-community.org](https://stats.lms-community.org).

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

You can enable debug logging for `plugin.analytics` to see what is being reported:

```
Slim::Plugin::Analytics::Plugin::_reportStats (53) nIj.............YhF8: {
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
