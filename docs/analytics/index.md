---
layout: default
title: Some numbers about LMS Installations
hide:
  - navigation
  - toc
---

<style>
.md-content {
  max-width: 900px;
  margin-left: auto;
  margin-right: auto;
}
</style>

Lyrion Music Server encourages users to share their usage data with the LMS community. It is used to steer and influence Lyrion Music Server development priorities. The plugin responsible for the data collection is part of LMS since version 8.5.1.

[Learn more about how this data is gathered](learn-more.md)

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v6.json",
  "title": "Number of LMS installations",
  "description": "Time series chart of LMS installations by version",
  "data": {
    "url": "/analytics/stats.json",
    "format": {"property": "versions"}
  },
  "encoding": {
    "x": {"field": "d", "type": "temporal", "title": "Date", "timeUnit": "yearmonthdate"},
    "y": {"field": "c", "type": "quantitative", "title": "Installations"},
    "color": {"field": "v", "type": "nominal", "title": "Version"}
  },
  "layer": [
    {
        "mark": {
            "type": "line",
            "point": {
                "filled": true,
                "size": 15
            }
        }
    },
    {
        "params": [{
            "name": "hover",
            "select": {"type": "point", "on": "pointerover", "clear": "pointerout"}
        }],
        "mark": {"type": "circle", "tooltip": true},
        "encoding": {
            "opacity": {
                "condition": {"test": {"param": "hover", "empty": false}, "value": 1},
                "value": 0
            },
            "size": {
                "condition": {"test": {"param": "hover", "empty": false}, "value": 48},
                "value": 100
            }
        }
    }]
}
```

<a href="players">
```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v6.json",
  "title": "Number of connected players",
  "description": "Time series chart of number of connected players",
  "data": {
    "url": "/analytics/stats.json",
    "format": {"property": "players"}
  },
  "encoding": {
    "x": {"field": "d", "type": "temporal", "title": "Date", "timeUnit": "yearmonthdate"},
    "y": {"field": "p", "type": "quantitative", "title": "Connected Players"}
  },
  "layer": [
    {
        "mark": {
            "type": "line",
            "point": {
                "filled": true,
                "size": 15
            }
        }
    },
    {
        "params": [{
            "name": "hover",
            "select": {"type": "point", "on": "pointerover", "clear": "pointerout"}
        }],
        "mark": {"type": "circle", "tooltip": true},
        "encoding": {
            "opacity": {
                "condition": {"test": {"param": "hover", "empty": false}, "value": 1},
                "value": 0
            },
            "size": {
                "condition": {"test": {"param": "hover", "empty": false}, "value": 48},
                "value": 100
            }
        }
    }]
}
```
</a>

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v6.json",
  "title": "Connected players per LMS installation",
  "description": "Histogram which shows how many players are connected per LMS installation",
  "data": {
    "url": "/analytics/stats.json",
    "format": {
      "property": "connectedPlayers",
      "parse": {
          "p": "number"
      }
  }
  },
  "mark": {"type": "bar", "tooltip": true},
  "encoding": {
    "x": {
      "field": "p",
      "type": "ordinal",
      "title": "Connected players per installation"
    },
    "y": {"field": "c", "type": "quantitative", "title": "Count of installations"}
  }
}
```

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v6.json",
  "title": "Number of tracks in library",
  "description": "Histogram which shows how many tracks (about) are in a LMS installation",
  "data": {
    "url": "/analytics/stats.json",
    "format": {"property": "tracks"}
  },
  "mark": {"type": "bar", "tooltip": true},
  "transform": [
    {
      "lookup": "t",
      "from": {
        "key": "t",
        "fields": ["l"],
        "data": {
          "values": [
            { "t": "0", "l": "0" },
            { "t": "1", "l": "1-500" },
            { "t": "500", "l": "501-1,000" },
            { "t": "1000", "l": "1,001-5,000" },
            { "t": "5000", "l": "5,001-10,000" },
            { "t": "10000", "l": "10,001-20,000" },
            { "t": "20000", "l": "20,001-50,000" },
            { "t": "50000", "l": "50,001-100,000" },
            { "t": "100000", "l": "100,001-500,000" },
            { "t": "500000", "l": "500,001-1,000,000" },
            { "t": "1000000", "l": ">1,000,001" }
          ]
        }
      }
    }
  ],
  "encoding": {
    "y": {
      "field": "l",
      "type": "ordinal",
      "title": "Tracks in Library",
      "sort": ["0","1","500","1000","5000","10000","20000","50000","100000","500000","1000000"]
    },
    "x": {"field": "c", "type": "quantitative", "title": "Count of installations"}
  }
}
```

<a href="players">
```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v6.json",
  "width": "container",
  "height": 420,
  "title": "Player types",
  "description": "Pie chart with player types",
  "data": {
    "url": "/analytics/stats.json",
    "format": {"property": "playerTypes"}
  },
  "mark": {"type": "arc", "tooltip": true},
  "encoding": {
    "theta": {"field": "c", "type": "quantitative", "stack": "normalize", "title": "Percentage"},
    "color": {"field": "p", "type": "nominal", "title": "Player type", "sort": "c"},
    "order": {"field": "c", "type": "quantitative", "sort": "descending", "title": "Count"}
  }
}
```
</a>

<a href="os">
```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v6.json",
  "width": "container",
  "height": 420,
  "title": "Operating systems and architectures",
  "description": "Pie chart with operating systems and architectures",
  "data": {
    "url": "/analytics/stats.json",
    "format": {"property": "os"}
  },
  "mark": {"type": "arc", "tooltip": true},
  "encoding": {
    "theta": {"field": "c", "type": "quantitative", "stack": "normalize", "title": "Percentage"},
    "color": {"field": "o", "type": "nominal", "title": "Operating System", "sort": "c"},
    "order": {"field": "c", "type": "quantitative", "sort": "descending", "title": "Count"}
  }
}
```
</a>

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v6.json",
  "width": "container",
  "height": 450,
  "title": "LMS installations worldwide",
  "description": "Map of LMS installations worldwide",
  "data": {
    "url": "/analytics/world_map.json",
    "format": {"property": "features"}
  },
  "projection": {"type": "naturalEarth1"},
  "transform": [
    {
      "lookup": "properties.iso_a2_eh",
      "from": {
        "key": "c",
        "fields": ["i"],
        "data": {
          "url": "/analytics/stats.json",
          "format": {"property": "countries"}
        }
      }
    }
  ],
  "mark": {
    "type": "geoshape",
    "stroke": "#141010",
    "strokeWidth": 0.5
  },
  "encoding": {
    "color": {
      "field": "i",
      "type": "quantitative",
      "scale": {"scheme": "greens"},
      "title": "Installations"
    },
    "tooltip": [
      {"field": "properties.name", "title": "Country"},
      {
        "field": "i",
        "type": "quantitative",
        "title": "Installations"
      }
    ]
  },
  "config": {"mark": {"invalid": null}}
}
```
