#!/usr/bin/env python3
"""Check for unused keys in lib/l10n/app_en.arb.

Exit code 0 — all keys are used.
Exit code 1 — unused keys found (prints them to stdout).
"""
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

PROJECT = Path(__file__).parent.parent
ARB = PROJECT / 'lib/l10n/app_en.arb'


def main() -> int:
    with open(ARB) as f:
        data = json.load(f)
    keys = [k for k in data if not k.startswith('@') and k != '@@locale']

    dart_files = [
        p for p in (PROJECT / 'lib').rglob('*.dart')
        if 'app_localizations' not in p.name
    ]

    combined = '\n'.join(
        p.read_text(errors='ignore') for p in dart_files
    )

    unused = []
    for key in keys:
        pattern = re.compile(
            r'(?:l10n|localizations|AppLocalizations[^.]{0,30})\.'
            + re.escape(key)
            + r'(?![a-zA-Z0-9_])'
        )
        if not pattern.search(combined):
            # Fallback: key as string literal (dynamic construction)
            if f"'{key}'" not in combined and f'"{key}"' not in combined:
                unused.append(key)

    if not unused:
        print(f'OK: all {len(keys)} l10n keys are used.')
        return 0

    groups: dict[str, list[str]] = defaultdict(list)
    for k in unused:
        m = re.match(r'^[a-z]+', k)
        groups[m.group() if m else 'other'].append(k)

    print(f'UNUSED L10N KEYS: {len(unused)} of {len(keys)}\n')
    for prefix, ks in sorted(groups.items(), key=lambda x: -len(x[1])):
        print(f'  [{prefix}] ({len(ks)})')
        for k in ks:
            print(f'    {k}')
    return 1


if __name__ == '__main__':
    sys.exit(main())
