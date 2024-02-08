---
layout: default
title: Adding translations
---

# Adding translations

With the help of more than 30 volunteers LMS has already been translated into more than 17 languages!

If you would like to help us to make LMS even more globally accessible and have noticed a missing translation in your language, or would like to add a new language, you can help us by creating a pull request on Github for your changes in the file [strings.txt](https://github.com/Logitech/slimserver/blob/HEAD/strings.txt). This file contains all translations of all text strings which are used in LMS and is pretty self-explanatory.

```
STRING_TOKEN
→ DE → Dies ist ein Text
→ EN → This is some text
```

!!! note
    The one important thing to keep in mind is to always single use tabs (`→`) rather than spaces to indent the strings, and to separate tokens from the actual content.

Every string must be available in English (`EN`), as that's what LMS would fall back to if a translation was missing.

!!! tip
    If your translation would be identical to the English version, there's no need to redefine it for your language, as LMS would automatically fall back to English.