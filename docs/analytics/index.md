---
layout: default
title: Some numbers about LMS Installations
---

[Learn more about how this data is gathered](learn-more.md)

## Number of LMS installations

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "description": "LMS Installations by Version",
  "data": {
    "url": "/analytics/stats.json",
    "format": {"property": "versions"}
  },
  "encoding": {
    "x": {"field": "d", "type": "temporal", "title": "Date"},
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

## Number of connected players

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "description": "Connected players",
  "data": {
    "url": "/analytics/stats.json",
    "format": {"property": "players"}
  },
  "encoding": {
    "x": {"field": "d", "type": "temporal", "title": "Date"},
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

## Player types

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "width": "container",
  "height": 250,
  "description": "Player types",
  "data": {
    "url": "/analytics/stats.json",
    "format": {"property": "playerTypes"}
  },
  "transform": [
    {
      "lookup": "p",
      "from": {
        "key": "name",
        "fields": ["displayname"],
        "data": {
          "url": "/analytics/players-displayname.json"
        }
      }
    }
  ],
  "mark": {"type": "arc", "tooltip": true},
  "encoding": {
    "theta": {"field": "c", "type": "quantitative", "stack": "normalize", "title": "Count"},
    "color": {"field": "displayname", "type": "nominal", "title": "Player type"}
  }
}
```

## Operating systems and architectures

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "width": "container",
  "height": 250,
  "description": "Player types",
  "data": {
    "url": "/analytics/stats.json",
    "format": {"property": "os"}
  },
  "mark": {"type": "arc", "tooltip": true},
  "encoding": {
    "theta": {"field": "c", "type": "quantitative", "stack": "normalize", "title": "Count"},
    "color": {"field": "o", "type": "nominal", "title": "Operating System"}
  }
}
```

## LMS installations worldwide

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "width": 750,
  "height": 350,
  "data": {
    "url": "/analytics/world_map.json",
    "format": {"property": "features"}
  },
  "projection": {"type": "naturalEarth1"},
  "transform": [
    {
      "lookup": "properties.iso_a2",
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
      "legend": null
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

## Installed and activated plugins

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "height": {"step": 17},
  "data": {
    "url": "/analytics/stats.json",
    "format": {"property": "plugins"}
  },
  "mark": "bar",
  "encoding": {
    "y": {"field": "p", "title": "Plugins", "type": "nominal", "sort": "-x"},
    "x": {"field": "c", "title": "Installations", "type": "quantitative"}
  }
}
```
