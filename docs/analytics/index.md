---
layout: default
title: Some Numbers about LMS Installations
---

[Learn more about how this data is gathered](learn-more.md)

## Number of LMS Installations

(with stats enabled anyway...)

```mermaid
---
config:
    xyChart:
        height: 200
    {{ xyBarStyles }}
---
xychart-beta
    x-axis [{{ histDates }}]
    line [{{ histInstallations }}]
```


## Connected Players

```mermaid
---
config:
    xyChart:
        height: 200
    {{ xyBarStyles }}
---
xychart-beta
    x-axis [{{ histDates }}]
    line [{{ histPlayers }}]
```


## LMS Versions

```mermaid
%%{ {{ pieStyles }} }%%
pie title LMS Versions
{{ versions }}
```


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
        height: 2000
    {{ xyBarStyles }}
---
xychart-beta horizontal
    x-axis [{{ pluginLabels }}]
    y-axis "Installations"
    bar [{{ pluginCounts }}]
```
