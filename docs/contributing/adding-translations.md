---
layout: default
title: Adding translations
---

# Adding translations

With the help of more than 30 volunteers LMS has already been translated into more than 17 languages!

If you would like to help us to make LMS even more globally accessible and have noticed a missing translation in
your language, or would like to add a new language, you can help us by creating a pull request on Github for your
changes in the file [`strings.txt`](https://github.com/LMS-Community/slimserver/blob/HEAD/strings.txt). More
`strings.txt` files can be found for each of the plugins in the
[`Slim/Plugin`](https://github.com/LMS-Community/slimserver/tree/HEAD/Slim/Plugin) folder of the project.

These files contain translations of text strings which are used in LMS and is pretty self-explanatory.

```
STRING_TOKEN
→ DE → Dies ist ein Text
→ EN → This is some text
```

!!! note
    The one important thing to keep in mind is to always single use tabs (`→`) rather than spaces to indent the strings,
    and to separate tokens from the actual content.

Every string must be available in English (`EN`), as that's what LMS would fall back to if a translation was missing.
But if your translation is identical to the English version, then there's no need to add one. LMS will always fall back
to `EN` if it can't find a localization.

But that's not all of them... there are more phrases to be found in various other places, some of which follow the same
file structure, some of which are JSON or other formats (depending on the needs):

* The [first time installation wizard](https://github.com/LMS-Community/slimserver/blob/HEAD/HTML/EN/settings/wizard.json)
* The [macOS Menubar item](https://github.com/LMS-Community/slimserver-platforms/blob/HEAD/osx/MenuBarItem/LMSMenu.json)
* The [Windows installer](https://github.com/LMS-Community/slimserver-platforms/blob/HEAD/win32/installer/strings.iss)
* [Docker Migration Information](https://github.com/LMS-Community/slimserver-platforms/blob/HEAD/Docker/DockerRepoWarning/strings.txt)


## Current coverage of translations

The data below can be skewed towards English, as there's no need to define terms for your language when the translation
is identical to the English version.

!!! tip
    If your translation would be identical to the English version, there's no need to redefine it for your language, as
    LMS would automatically fall back to English. Therefore there's no need to try to achieve 100% coverage!

```vegalite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "title": "Coverage in %",
  "data": {"url": "/contributing/strings-coverage.json"},
  "mark": "bar",
  "encoding": {
    "x": {"field": "Coverage", "type": "quantitative"},
    "y": {"field": "Language", "type": "nominal", "sort": "-x"}
  }
}
```
