---
layout: default
title: Some Numbers about LMS Installations
---

[Learn more about how this data is gathered](learn-more.md)

## Countries

```mermaid
%%{ {{ pieStyles }} }%%
pie title Countries
{{ countries }}
```


## LMS Versions

```mermaid
%%{ {{ pieStyles }} }%%
pie title LMS Versions
{{ versions }}
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
        height: 3000
    {{ xyBarStyles }}
---
xychart-beta horizontal
    x-axis [{{ pluginLabels }}]
    y-axis "Installations"
    bar [{{ pluginCounts }}]
```
