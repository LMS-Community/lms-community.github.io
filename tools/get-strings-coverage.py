#!/usr/bin/env python3

import json
import fileinput
from babel import Locale

lang, translation = None, None
translations = {}

# Read strings.txt
for line in fileinput.input(encoding='utf-8'):
	line = line.rstrip('\n')

	if line.startswith('#'):
		continue

	if line.startswith('\t'):
		line = line.lstrip('\t')
		lang, translation = line.split("\t")
	else:
		slug = line

	if lang and not lang in translations:
		translations[lang] = {}

	if lang:
		translations[lang][slug] = translation

# Calculate max number of strings
total = 0
for lang in translations.keys():
	total = max(total, len(translations[lang]))

# Get display name of language code and calculate percentage
output = []
for lang in translations.keys():
	loc = Locale.parse(lang)

	language = loc.get_display_name('en_US')
	language_id = lang
	coverage = 100.0 * len(translations[lang]) / total

	output.append({"Language": language, "Identifier": language_id, "Coverage": coverage})

print(json.dumps(output))
