#!/usr/bin/env python3
"""Extract hardcoded English strings from widget_builder for l10n audit."""
import re
import os
import json

base = 'lib/features/widget_builder'
results = []

# Line-level patterns to skip (infrastructure, logging, technical)
skip_line_patterns = [
    r'AppLogging',
    r'^\s*import ',
    r'^\s*//',
    r'^\s*\*',
    r'path: ',
    r"iconName: '",
    r'\.parse\(',
    r'\.contains\(',
    r'\.startsWith',
    r'\.endsWith',
    r"format: '",
    r"defaultValue: '",
    r"tags: \[",
    r"fontWeight: '",
    r"textColor: '",
    r"backgroundColor: '",
    r"borderColor: '",
    r"gaugeColor: '",
    r'super\.',
    r'\.write\(',
    r'shapeType:',
    r'gaugeType:',
    r'chartType:',
    r'actionType:',
    r'throw\s',
    r'Exception\(',
    r'MarketplaceException\(',
    r'\.execute\(',
    r'\.rawQuery\(',
    r'CREATE TABLE',
    r'ALTER TABLE',
    r'INSERT INTO',
    r'SELECT\s',
    r'\.collection\(',
    r'\.doc\(',
    r'SharedPreferences',
    r'required this',
    r"text: '",     # template text content in schema definitions
    r"label: '(?:Quick Message|Share Location|Traceroute|Request Positions)'",  # ActionSchema labels
]

for root_dir, dirs, files in os.walk(base):
    for fname in sorted(files):
        if not fname.endswith('.dart'):
            continue
        fpath = os.path.join(root_dir, fname)
        with open(fpath) as f:
            lines = f.readlines()
        for i, line in enumerate(lines, 1):
            stripped = line.strip()
            if stripped.startswith('//') or stripped.startswith('/*') or stripped.startswith('*'):
                continue
            
            # Find all single-quoted string literals that start with uppercase
            matches = re.findall(r"'([A-Z][^']{2,})'", line)
            for m in matches:
                # Skip infrastructure lines
                skip = False
                for sp in skip_line_patterns:
                    if re.search(sp, line):
                        skip = True
                        break
                if skip:
                    continue
                
                # Skip technical identifiers
                if m.startswith(('node.', 'device.', 'network.', 'messaging.', 'gps.')):
                    continue
                if re.match(r'^[a-z_]+\.[a-z_]+$', m):
                    continue
                if re.match(r'^#[0-9A-Fa-f]+$', m):
                    continue
                if re.match(r'^[A-Z][a-z]*\.$', m):
                    continue
                # Only include if it looks like English text (3+ letter word)
                if re.search(r'[a-zA-Z]{3,}', m):
                    results.append({
                        'file': fpath,
                        'line': i,
                        'value': m
                    })

for r in results:
    print(f"{r['file']}:{r['line']}: {r['value']}")
print(f"\nTotal: {len(results)}")
