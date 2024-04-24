---
layout: default
title: Some numbers about LMS Installations
hide:
  - toc
---

Lyrion Music Server encourages users to share their usage data with the LMS community. It is used to steer and influence Lyrion Music Server development priorities. The plugin responsible for the data collection is part of LMS since version 8.5.1.

[Learn more about how this data is gathered](learn-more.md)

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
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
                "filled": false,
                "fill": "white"
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

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
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
                "filled": false,
                "fill": "white"
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

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "title": "Connected players per LMS installation",
  "description": "Histogram which shows how many players are connected per LMS installation",
  "data": {
    "url": "/analytics/stats.json",
    "format": {"property": "connectedPlayers"}
  },
  "mark": {"type": "bar", "tooltip": true},
  "encoding": {
    "x": {
      "field": "p",
      "type": "ordinal",
      "title": "Connected players per installation",
      "sort": ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
    },
    "y": {"field": "c", "type": "quantitative", "title": "Count of installations"}
  }
}
```

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "width": "container",
  "height": 350,
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

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "width": "container",
  "height": 350,
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

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
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
