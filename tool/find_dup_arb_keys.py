#!/usr/bin/env python3
"""Find duplicate top-level keys in an ARB file."""
import re
import sys
from collections import Counter

arb_path = sys.argv[1] if len(sys.argv) > 1 else 'lib/l10n/app_en.arb'

with open(arb_path, 'r') as f:
    lines = f.readlines()

# Top-level keys are at indent 4 (inside the root {} object)
top_keys = []
for i, line in enumerate(lines):
    m = re.match(r'^    "([^"]+)"\s*:', line)
    if m:
        top_keys.append((m.group(1), i + 1))

counts = Counter(k for k, _ in top_keys)
dups = {k for k, c in counts.items() if c > 1}

print(f"Total top-level keys: {len(top_keys)}")
print(f"Duplicate keys: {len(dups)}")
for dup_key in sorted(dups):
    locs = [ln for k, ln in top_keys if k == dup_key]
    print(f"  {dup_key}: lines {locs}")
