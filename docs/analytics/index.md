---
layout: default
title: Some Stats
---


## Countries

```mermaid
%%{ {{ pieStyles }} }%%
pie title Countries
{{ countries }}
```


## Operating Systems

```mermaid
%%{ {{ pieStyles }} }%%
pie title Operating Systems
{{ os }}
```


## Plugins

```mermaid
---
config:
    xyChart:
        height: 1800
    {{ xyBarStyles }}
---
xychart-beta horizontal
    x-axis [{{ pluginLabels }}]
    y-axis "Installations"
    bar [{{ pluginCounts }}]
```
