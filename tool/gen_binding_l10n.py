#!/usr/bin/env python3
"""Generate ARB entries and Dart lookup methods for data_binding.dart l10n."""
import re

with open('lib/features/widget_builder/models/data_binding.dart', 'r') as f:
    content = f.read()

pattern = r"path: '([^']+)',\s*\n\s*label: '([^']+)',\s*\n\s*description: '([^']+)'"
matches = re.findall(pattern, content)

# Generate ARB entries
arb_lines = []
for path, label, desc in matches:
    parts = path.split('.')
    key_suffix = ''.join(p[0].upper() + p[1:] for p in parts)
    label_key = f'widgetBuilderBinding{key_suffix}Label'
    desc_key = f'widgetBuilderBinding{key_suffix}Desc'
    
    arb_lines.append(f'  "{label_key}": "{label}",')
    arb_lines.append(f'  "@{label_key}": {{')
    arb_lines.append(f'    "description": "Binding label for {path}"')
    arb_lines.append(f'  }},')
    arb_lines.append(f'  "{desc_key}": "{desc}",')
    arb_lines.append(f'  "@{desc_key}": {{')
    arb_lines.append(f'    "description": "Binding description for {path}"')
    arb_lines.append(f'  }},')

with open('tool/binding_arb_entries.txt', 'w') as f:
    f.write('\n'.join(arb_lines))

# Generate Dart lookup method
dart_label_cases = []
dart_desc_cases = []
for path, label, desc in matches:
    parts = path.split('.')
    key_suffix = ''.join(p[0].upper() + p[1:] for p in parts)
    label_key = f'widgetBuilderBinding{key_suffix}Label'
    desc_key = f'widgetBuilderBinding{key_suffix}Desc'
    dart_label_cases.append(f"      '{path}' => l10n.{label_key},")
    dart_desc_cases.append(f"      '{path}' => l10n.{desc_key},")

dart_code = f"""  /// Get localized label for a binding path.
  static String localizedLabel(String path, AppLocalizations l10n) {{
    return switch (path) {{
{chr(10).join(dart_label_cases)}
      _ => getByPath(path)?.label ?? path,
    }};
  }}

  /// Get localized description for a binding path.
  static String localizedDescription(String path, AppLocalizations l10n) {{
    return switch (path) {{
{chr(10).join(dart_desc_cases)}
      _ => getByPath(path)?.description ?? path,
    }};
  }}
"""

with open('tool/binding_dart_methods.txt', 'w') as f:
    f.write(dart_code)

# Category names
cat_arb = []
cats = [
    ('node', 'Node Info'),
    ('device', 'Device Metrics'),
    ('network', 'Network'),
    ('environment', 'Environment'),
    ('power', 'Power & Battery'),
    ('airQuality', 'Air Quality'),
    ('gps', 'GPS & Position'),
    ('messaging', 'Messaging'),
]
for key, name in cats:
    arb_key = f'widgetBuilderBindingCategory{key[0].upper() + key[1:]}'
    cat_arb.append(f'  "{arb_key}": "{name}",')
    cat_arb.append(f'  "@{arb_key}": {{')
    cat_arb.append(f'    "description": "Binding category name: {key}"')
    cat_arb.append(f'  }},')

with open('tool/binding_category_arb.txt', 'w') as f:
    f.write('\n'.join(cat_arb))

# Category Dart lookup
cat_dart_cases = []
for key, name in cats:
    arb_key = f'widgetBuilderBindingCategory{key[0].upper() + key[1:]}'
    cat_dart_cases.append(f"      BindingCategory.{key} => l10n.{arb_key},")

cat_dart = f"""  /// Get localized category name.
  static String localizedCategoryName(
    BindingCategory category,
    AppLocalizations l10n,
  ) {{
    return switch (category) {{
{chr(10).join(cat_dart_cases)}
    }};
  }}
"""

with open('tool/binding_category_dart.txt', 'w') as f:
    f.write(cat_dart)

print(f"Generated {len(matches)} binding entries ({len(matches)*2} ARB keys)")
print(f"Generated {len(cats)} category entries ({len(cats)} ARB keys)")
print(f"Total: {len(matches)*2 + len(cats)} new ARB keys")
