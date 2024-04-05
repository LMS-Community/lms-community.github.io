#!/usr/bin/env python3

import fileinput
import json
from babel import Locale

lang, translation = None, None
translations = {}

for line in fileinput.input(encoding="utf-8"):
	line = line.rstrip('\n')

	if line.startswith("#"):
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

total = 0
for lang in translations.keys():
	total = max(total, len(translations[lang]))

output = []
for lang in translations.keys():
	loc = Locale.parse(lang)

	language = loc.get_display_name('en_US')
	language_id = lang
	coverage = 100.0 * len(translations[lang]) / total

	output.append({"Language": language, "Identifier": language_id, "Coverage": coverage})

print(json.dumps(output))
