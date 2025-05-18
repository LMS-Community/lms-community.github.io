---
layout: default
title: Some numbers about LMS Installations - player types historical view
hide:
  - navigation
  - toc
---

<style>
.md-content {
  /* max-width: 900px; */
  margin-left: auto;
  margin-right: auto;
}
</style>

Lyrion Music Server encourages users to share their usage data with the LMS community. It is used to steer and influence Lyrion Music Server development priorities. The plugin responsible for the data collection is part of LMS since version 8.5.1.

[Learn more about how this data is gathered](learn-more.md)

```vegalite
{
    "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
    "title": "Number of player types",
    "description": "Time series chart of LMS player types",
    "data": {
        "url": "/analytics/stats.json",
        "format": {
            "property": "playerHistory"
        }
    },
    "height": 800,
    "encoding": {
        "x": {
            "field": "d",
            "type": "temporal",
            "title": "Date",
            "timeUnit": "yearmonthdate"
        },
        "y": {
            "field": "c",
            "type": "quantitative",
            "title": "Installations",
            "scale": {
                "domainMin": 150
            }
        },
        "color": {
            "field": "p",
            "type": "nominal",
            "title": "OS"
        }
    },
    "transform": [
        {
            "filter": {
                "field": "c",
                "range": [
                    400,
                    99000
                ]
            }
        }
    ],
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
            "params": [
                {
                    "name": "hover",
                    "select": {
                        "type": "point",
                        "on": "pointerover",
                        "clear": "pointerout"
                    }
                }
            ],
            "mark": {
                "type": "circle",
                "tooltip": true
            },
            "encoding": {
                "opacity": {
                    "condition": {
                        "test": {
                            "param": "hover",
                            "empty": false
                        },
                        "value": 1
                    },
                    "value": 0
                },
                "size": {
                    "condition": {
                        "test": {
                            "param": "hover",
                            "empty": false
                        },
                        "value": 48
                    },
                    "value": 100
                }
            }
        }
    ]
}
```
