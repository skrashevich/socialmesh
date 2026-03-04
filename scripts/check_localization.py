#!/usr/bin/env python3
"""Check for unused l10n keys in app_en.arb.

Extracts all dot-accessed identifiers from Dart source once into a set,
then does O(1) membership checks per ARB key. Skips generated code,
tests (no l10n usage), and meshcore-open (separate l10n system).
"""

import json
import re
import sys
import time
from collections import defaultdict
from pathlib import Path

PROJECT = Path(__file__).resolve().parent.parent
ARB = PROJECT / "lib" / "l10n" / "app_en.arb"

# Directories to skip entirely (relative to PROJECT)
SKIP_DIRS = {
    ".dart_tool",
    "build",
    "ios",
    "android",
    "macos",
    "linux",
    "windows",
    "web",
    "test",
    "meshcore-open",
}

# Paths under lib/ to skip
SKIP_LIB_DIRS = {
    "l10n",  # generated app_localizations*.dart
    "generated",  # protobuf generated code
}


def collect_dart_files() -> list[Path]:
    """Collect Dart source files, skipping generated and irrelevant dirs."""
    lib_dir = PROJECT / "lib"
    files: list[Path] = []
    for p in lib_dir.rglob("*.dart"):
        # Skip lib/l10n/ and lib/generated/
        rel = p.relative_to(lib_dir)
        top = rel.parts[0] if len(rel.parts) > 1 else ""
        if top in SKIP_LIB_DIRS:
            continue
        files.append(p)
    return files


def extract_dot_identifiers(source: str) -> set[str]:
    """Extract all identifiers that appear after a dot in Dart source.

    Matches patterns like `.someKey`, `.someKey(`, `.someKey,` etc.
    This catches l10n.key, context.l10n.key, ref.watch(...).key, etc.
    """
    # Match .identifier where identifier is a valid Dart identifier
    # \. followed by a word-boundary identifier
    return set(re.findall(r"\.([a-zA-Z_]\w*)", source))


def extract_string_literals(source: str) -> set[str]:
    """Extract contents of single- and double-quoted string literals."""
    literals: set[str] = set()
    # Single-quoted strings (non-greedy, no escaped quotes for speed)
    for m in re.finditer(r"'([^']*)'", source):
        literals.add(m.group(1))
    # Double-quoted strings
    for m in re.finditer(r'"([^"]*)"', source):
        literals.add(m.group(1))
    return literals


def main() -> None:
    t0 = time.monotonic()

    # 1. Load ARB keys
    with open(ARB) as f:
        data = json.load(f)
    keys = [k for k in data if not k.startswith("@") and k != "@@locale"]
    print(f"Total keys: {len(keys)}")

    # 2. Collect source files
    dart_files = collect_dart_files()
    print(f"Dart files to scan: {len(dart_files)}")

    # 3. Read all source, extract identifiers and string literals in one pass
    all_dot_ids: set[str] = set()
    all_literals: set[str] = set()
    total_bytes = 0

    for p in dart_files:
        try:
            source = p.read_text(errors="ignore")
        except OSError:
            continue
        total_bytes += len(source)
        all_dot_ids.update(extract_dot_identifiers(source))
        all_literals.update(extract_string_literals(source))

    print(f"Source scanned: {total_bytes / 1_048_576:.1f} MB")
    print(f"Unique dot-identifiers: {len(all_dot_ids):,}")
    print(f"Unique string literals: {len(all_literals):,}")

    # 4. Classify each key with O(1) lookups
    unused: list[str] = []
    dynamic_risk: list[str] = []

    for key in keys:
        if key in all_dot_ids:
            continue  # Used: l10n.key / context.l10n.key / etc.
        if key in all_literals:
            dynamic_risk.append(key)  # Might be constructed dynamically
        else:
            unused.append(key)

    used_count = len(keys) - len(unused) - len(dynamic_risk)
    elapsed = time.monotonic() - t0

    # 5. Report
    print(f"\n{'=' * 40}")
    print(f"Used:             {used_count:5d}  ({used_count / len(keys) * 100:.1f}%)")
    print(f"Unused:           {len(unused):5d}  ({len(unused) / len(keys) * 100:.1f}%)")
    print(
        f"Dynamic risk:     {len(dynamic_risk):5d}  ({len(dynamic_risk) / len(keys) * 100:.1f}%)"
    )
    print(f"{'=' * 40}")

    # Group unused by camelCase prefix
    groups: defaultdict[str, list[str]] = defaultdict(list)
    for k in unused:
        m = re.match(r"^[a-z]+", k)
        prefix = m.group() if m else "other"
        groups[prefix].append(k)

    print("\n--- Unused by prefix ---")
    for prefix, ks in sorted(groups.items(), key=lambda x: -len(x[1])):
        print(f"  {prefix}: {len(ks)}")

    # Save lists
    unused_path = PROJECT / "build" / "unused_l10n_keys.txt"
    dynamic_path = PROJECT / "build" / "dynamic_risk_l10n_keys.txt"
    unused_path.parent.mkdir(parents=True, exist_ok=True)

    unused_path.write_text("\n".join(sorted(unused)) + "\n")
    dynamic_path.write_text("\n".join(sorted(dynamic_risk)) + "\n")

    print(f"\nSaved to {unused_path}")
    print(f"Saved to {dynamic_path}")
    print(f"Completed in {elapsed:.2f}s")

    # Exit with error code if unused keys found (useful for CI)
    if unused:
        sys.exit(1)


if __name__ == "__main__":
    main()
