#!/usr/bin/env python3
"""Generate Dart lookup methods for data_binding.dart l10n using existing ARB keys."""
import re

with open('lib/features/widget_builder/models/data_binding.dart', 'r') as f:
    content = f.read()

# Extract binding definitions
pattern = r"path: '([^']+)',\s*\n\s*label: '([^']+)',\s*\n\s*description: '([^']+)'"
matches = re.findall(pattern, content)

# Read existing ARB keys
with open('lib/l10n/app_en.arb', 'r') as f:
    arb_content = f.read()

# Extract all widgetBuilderBinding keys and their values
arb_pattern = r'"(widgetBuilderBinding[^"]+)":\s*"([^"]+)"'
arb_entries = dict(re.findall(arb_pattern, arb_content))

# Build reverse lookup: value -> key (for labels, excluding Desc and Category)
value_to_label_key = {}
value_to_desc_key = {}
for key, value in arb_entries.items():
    if key.startswith('@'):
        continue
    if 'Category' in key:
        continue
    if key.endswith('Desc'):
        value_to_desc_key[value] = key
    else:
        value_to_label_key[value] = key

# Map each path to its label/desc ARB key
path_to_label_key = {}
path_to_desc_key = {}
missing_labels = []
missing_descs = []

for path, label, desc in matches:
    if label in value_to_label_key:
        path_to_label_key[path] = value_to_label_key[label]
    else:
        missing_labels.append((path, label))
    
    if desc in value_to_desc_key:
        path_to_desc_key[path] = value_to_desc_key[desc]
    else:
        missing_descs.append((path, desc))

# Print report
print(f"Total bindings: {len(matches)}")
print(f"Label matches: {len(path_to_label_key)}")
print(f"Desc matches: {len(path_to_desc_key)}")

if missing_labels:
    print(f"\nMissing label ARB keys ({len(missing_labels)}):")
    for path, label in missing_labels:
        print(f"  {path}: '{label}'")

if missing_descs:
    print(f"\nMissing desc ARB keys ({len(missing_descs)}):")
    for path, desc in missing_descs:
        print(f"  {path}: '{desc}'")

# Generate Dart switch for labels
label_cases = []
for path, label, desc in matches:
    if path in path_to_label_key:
        key = path_to_label_key[path]
        label_cases.append(f"      '{path}' => l10n.{key},")

# Generate Dart switch for descriptions
desc_cases = []
for path, label, desc in matches:
    if path in path_to_desc_key:
        key = path_to_desc_key[path]
        desc_cases.append(f"      '{path}' => l10n.{key},")

dart_code = f"""// GENERATED FILE -- do not edit by hand.
// Regenerate with: python3 tool/gen_binding_lookup.py
//
// These methods are generated for reference and pasted into
// BindingRegistry in lib/features/widget_builder/models/data_binding.dart.

// ignore_for_file: unused_import
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../lib/features/widget_builder/models/data_binding.dart';

/// Generated lookup helpers that map binding paths to l10n keys.
extension BindingLookupMethods on BindingRegistry {{
  /// Get localized label for a binding path.
  static String localizedLabel(String path, AppLocalizations l10n) {{
    return switch (path) {{
{chr(10).join(label_cases)}
      _ => BindingRegistry.getByPath(path)?.label ?? path,
    }};
  }}

  /// Get localized description for a binding path.
  static String localizedDescription(String path, AppLocalizations l10n) {{
    return switch (path) {{
{chr(10).join(desc_cases)}
      _ => BindingRegistry.getByPath(path)?.description ?? path,
    }};
  }}
}}
"""

with open('tool/binding_lookup_methods.dart.txt', 'w') as f:
    f.write(dart_code)

print(f"\nGenerated lookup methods in tool/binding_lookup_methods.dart.txt")
