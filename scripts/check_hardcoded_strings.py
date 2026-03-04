#!/usr/bin/env python3
"""Find hardcoded English strings in Dart source that should be l10n keys.

Strategy
--------
1.  Read every non-generated Dart file under lib/ once.
2.  For each line that is NOT a comment or log/assert statement, apply a
    battery of regex patterns to extract candidate user-facing strings.
3.  Filter out technical noise (identifiers, paths, interpolation-only, etc.).
4.  Classify each hit by context (snackbar, Text widget, named param, …)
    and assign a priority (P1–P4).
5.  Write detailed and summary reports to build/.

Patterns detected (14 total)
-----------------------------
1.  Text('...')                       — direct Text widget construction
2.  param: 'string'                   — named parameters with string values
3.  param: Text('...')                — named params wrapping Text widgets
4.  showXxxSnackBar(ctx, 'string')    — snackbar helpers
5.  safeShowSnackBar('string')        — lifecycle-safe snackbar
6.  AppBottomSheet patterns           — caught via param patterns
7.  throw / Exception('...')          — exception messages
8.  return 'English text'             — function return values
9.  ?? 'English fallback'             — null-coalescing fallbacks
10. condition ? 'English' : ...       — ternary branches
11. enumVal => 'English text'         — switch/map expressions
12. this.param = 'English'            — constructor default values
    String param = 'English'          — function default values
13. .add('English text')              — list-builder English strings
14. static const String = 'English'   — class-level string constants
15. 'English text',                   — bare positional args (enum constructors,
                                        list entries, multi-line function args)

Key design choices
------------------
*   Data-only files (airports, airlines, ringtones, demo fixtures, etc.) are
    scanned separately and tagged so they don't pollute the actionable count.
*   models/ and storage/ are NOT blanket-classified as data dirs — too many
    user-facing strings live there (canned responses, tapbacks, widget
    templates).  Only files matching DATA_FILE_PATTERNS get data treatment.
*   The `name:` / `city:` / `code:` params inside model or data files are
    treated as proper-noun data, not translatable UI strings.
*   Exception messages and toString() debug strings are reported at P4.
*   We track the *matched pattern* so the report shows exactly why a line was
    flagged, making manual triage fast.
"""

import re
import sys
import time
from collections import Counter, defaultdict
from dataclasses import dataclass
from pathlib import Path

PROJECT = Path(__file__).resolve().parent.parent
LIB = PROJECT / "lib"

# ── Directories & files to skip entirely ──────────────────────────────────

SKIP_LIB_DIRS = frozenset({"l10n", "generated"})

# Individual files to skip entirely — MeshCore protocol files that live
# outside the features/meshcore/ directory (which is already skipped via
# SKIP_FEATURE_DIRS).  These are not user-facing for Meshtastic users.
SKIP_FILES = frozenset(
    {
        "core/meshcore_constants.dart",
        "features/device/widgets/meshcore_console.dart",
        "models/meshcore_channel.dart",
        "models/meshcore_contact.dart",
        "providers/meshcore_providers.dart",
        "providers/meshcore_message_providers.dart",
        "services/meshcore/protocol/meshcore_session.dart",
    }
)

# Feature directories that are either feature-flagged OFF in production,
# not user-facing (admin tooling), or belong to a separate protocol.
# Determined from main_shell.dart — only always-on features need translations.
#
# Feature-flagged OFF (env flag, default false):
#   - aether (AETHER_ENABLED)
#   - tak (TAK_GATEWAY_ENABLED)
#   - social (SOCIAL_ENABLED)
#   - file_transfer (FILE_TRANSFER_ENABLED)
#
# Commented out in main_shell drawer:
#   - global_layer
#   - device_shop
#
# Separate protocol (not Meshtastic):
#   - meshcore
#
# Admin/internal tooling (not public-facing):
#   - admin, conformance
SKIP_FEATURE_DIRS = frozenset(
    {
        "aether",
        "ar",
        "tak",
        "social",
        "file_transfer",
        "global_layer",
        "device_shop",
        "meshcore",
        "admin",
        "conformance",
        "intro",  # animations are commented-out dead code in main.dart
        "tasks",  # unreachable from any navigation path
    }
)

# Files that contain proper-noun datasets, fixture data, or generated
# constants that should never be translated.  Checked as suffix matches
# against the path relative to lib/.
DATA_FILE_PATTERNS = (
    "data/airports.dart",
    "data/airlines.dart",
    "data/airline_data.dart",
    "data/airport_data.dart",
    "firebase_options.dart",
    "demo/demo_data.dart",
    "dev/demo/demo_data.dart",
    "mock_service.dart",
    "ringtone_screen.dart",  # ringtone presets are const data objects
    "help/help_content.dart",  # English fallbacks — localized at render time
    "whats_new/whats_new_registry.dart",  # English fallbacks — localized at render time
    "admin_follow_requests_screen.dart",  # seed/demo data for admin tool
    "intro_animation_preview_screen.dart",  # animation label data, not user UI
)

# ── Named parameters ─────────────────────────────────────────────────────

# These almost always hold user-visible text when they contain English.
UI_PARAMS = frozenset(
    {
        "title",
        "label",
        "subtitle",
        "description",
        "hintText",
        "labelText",
        "helperText",
        "errorText",
        "errorMessage",
        "tooltip",
        "semanticsLabel",
        "message",
        "content",
        "heading",
        "text",
        "hint",
        "placeholder",
        "caption",
        "body",
        "emptyTitle",
        "emptySubtitle",
        "emptyMessage",
        "emptyDescription",
        "emptyActionLabel",
        "actionLabel",
        "confirmLabel",
        "cancelLabel",
        "positiveLabel",
        "negativeLabel",
        "broadcastLabel",
        "broadcastSubtitle",
        "userMessage",
        "fallbackMessage",
        "notificationTitle",
        "notificationText",
        "blockedMessage",
        "suggestion",
        "summaryText",
    }
)

# These are technical / structural and should be ignored completely.
TECHNICAL_PARAMS = frozenset(
    {
        "key",
        "tag",
        "id",
        "type",
        "route",
        "path",
        "url",
        "uri",
        "endpoint",
        "family",
        "debugLabel",
        "restorationId",
        "heroTag",
        "initialRoute",
        "fontFamily",
        "fontWeight",
        "package",
        "asset",
        "assetName",
        "icon",
        "color",
        "backgroundColor",
        "foregroundColor",
        "reason",  # internal reboot/restart reasons
        "oemName",  # brand proper nouns
        "rtttl",  # RTTTL notation strings
        "deepLinkAction",  # deep link route identifiers
        "where",  # SQL WHERE clause
        "routeName",  # navigation route names
        "orderBy",  # SQL ORDER BY clause
        "notes",  # diagnostic/internal notes
        "note",  # diagnostic/internal notes
        "error",  # internal error identifiers
        "source",  # data source identifiers
        "context",  # internal context labels
        "details",  # internal detail strings
        "fallbackRoute",  # navigation fallback routes
        "contentType",  # MIME / content type strings
        "channel",
        "channelId",
        "channelName",  # Android notification channel — system, not user
        "groupKey",
        "topic",
        "collection",
        "field",
        "columnName",
        "tableName",
        "databaseName",
        "boxName",
        "prefKey",
        "eventName",
        "analyticsName",
        "methodName",
        "named",  # GoRouter named route
        "value",
        "defaultValue",
        "initialValue",
        "format",
        "pattern",
        "regex",
        "mimeType",
        "extension",
        "encoding",
        "algorithm",
        "scheme",
        "host",
        "authority",
        "fragment",
        "query",
        "from",  # migration / routing
        "to",
        "className",
        "widgetName",
        "testId",
        "heroId",
        "semanticLabel",  # icon semantic (not user text in most cases)
        "payload",  # notification routing payload
        "textColor",  # CSS-style color strings in widget builder
        "borderColor",  # CSS-style color strings in widget builder
        "bindingPath",  # data-binding path in widget builder
        "initialSearchQuery",  # programmatic search filter
        "toInputType",  # flow compiler type identifier
        "deepLinkRoute",  # deep link route path
        "messageType",  # diagnostic message type
        "errorExcerpt",  # diagnostic error excerpt
        "messageId",  # diagnostic message ID
        "logoUrl",  # URL to logo image
        "destinationUrl",  # URL destination
        "storageSuffix",  # storage key suffix
        "authorId",  # user/author ID
        "observation",  # diagnostic observation
        "value2",  # IFTTT webhook value (technical)
        "value3",  # IFTTT webhook value (technical)
        "tz",  # timezone identifier (e.g. 'Australia/Melbourne')
        "publicChannelPskHex",  # pre-shared key hex — not translatable
        "_entitlementId",  # RevenueCat entitlement ID
        "_tag",  # logging tag
        "_productsEndpoint",  # API endpoint path
        "_serviceUuid",  # BLE service UUID
        "_fromRadioUuid",  # BLE characteristic UUID
        "_toRadioUuid",  # BLE characteristic UUID
        "_logRadioUuid",  # BLE characteristic UUID
        "_deviceInfoServiceUuid",  # BLE service UUID
        "_modelNumberUuid",  # BLE characteristic UUID
        "_manufacturerNameUuid",  # BLE characteristic UUID
        "serviceUuid",  # BLE service UUID
        "ownerUid",  # Firebase user UID
    }
)

# In data-object files (models/, data/, storage/), these hold proper nouns
# or internal labels — not translatable.
DATA_OBJECT_PARAMS = frozenset(
    {
        "name",
        "city",
        "code",
        "iata",
        "icao",
        "country",
        "region",
        "timezone",
        "callsign",
        "manufacturer",
        "shortName",
        "longName",
        "displayName",
        "fileName",
        "subject",  # share sheet subject — English brand string
    }
)


# ── Hit dataclass ─────────────────────────────────────────────────────────


@dataclass(slots=True)
class Hit:
    path: str  # relative to PROJECT
    lineno: int
    line: str  # stripped source line
    text: str  # the extracted English string
    pattern: str  # which regex pattern matched
    category: str  # assigned after classification
    param: str  # named param if applicable
    is_data_file: bool  # from a data/fixture file


# ── Compiled regex patterns ───────────────────────────────────────────────


# Shared fragments for matching quoted string content.  We allow escaped
# characters (\\u2026, \\n, \\t, etc.) inside the string so that Dart
# unicode escapes don't break the match.
_SQ_CONTENT = r"((?:[^'\\]|\\.){2,})"  # 2+ chars inside single quotes
_DQ_CONTENT = r'((?:[^"\\]|\\.){2,})'  # 2+ chars inside double quotes


def _sq(inner: str) -> re.Pattern[str]:
    """Wrap *inner* in single-quoted string capture."""
    return re.compile(inner.replace("STR", f"'{_SQ_CONTENT}'"))


def _dq(inner: str) -> re.Pattern[str]:
    """Wrap *inner* in double-quoted string capture."""
    return re.compile(inner.replace("STR", f'"{_DQ_CONTENT}"'))


# 1. Text('...')  /  Text("...")
RE_TEXT_SQ = _sq(r"Text\(\s*STR")
RE_TEXT_DQ = _dq(r"Text\(\s*STR")

# 2. param: 'string'  /  param: "string"
#    Captures (param, string).
RE_PARAM_SQ = re.compile(r"""(\w+):\s*'((?:[^'\\]|\\.){2,})'""")
RE_PARAM_DQ = re.compile(r'''(\w+):\s*"((?:[^"\\]|\\.){2,})"''')

# 3. param: Text('...')  /  param: const Text('...')
RE_PTXT_SQ = re.compile(r"""(\w+):\s*(?:const\s+)?Text\(\s*'((?:[^'\\]|\\.){2,})'""")
RE_PTXT_DQ = re.compile(r'''(\w+):\s*(?:const\s+)?Text\(\s*"((?:[^"\\]|\\.){2,})"''')

# 4. showXxxSnackBar(ctx, 'string')
RE_SNACK_SQ = re.compile(
    r"""show(?:Error|Info|Success|Warning|Action)SnackBar\([^,]*,\s*'((?:[^'\\]|\\.){2,})'"""
)
RE_SNACK_DQ = re.compile(
    r'''show(?:Error|Info|Success|Warning|Action)SnackBar\([^,]*,\s*"((?:[^"\\]|\\.){2,})"'''
)

# 5. safeShowSnackBar('string')
RE_SAFESNK_SQ = re.compile(r"""safeShowSnackBar\(\s*'((?:[^'\\]|\\.){2,})'""")
RE_SAFESNK_DQ = re.compile(r'''safeShowSnackBar\(\s*"((?:[^"\\]|\\.){2,})"''')

# 6. AppBottomSheet patterns — caught by param patterns already

# 7. throw / Exception('...')
RE_THROW_SQ = re.compile(
    r"""(?:throw\s+\w*(?:Exception|Error)|(?:State|Argument|Format|Unsupported)Error)\(\s*'((?:[^'\\]|\\.){2,})'"""
)
RE_THROW_DQ = re.compile(
    r'''(?:throw\s+\w*(?:Exception|Error)|(?:State|Argument|Format|Unsupported)Error)\(\s*"((?:[^"\\]|\\.){2,})"'''
)

# ── NEW patterns: return, null-coalescing, ternary, switch, defaults, .add ──

# 8. return 'English text';
RE_RETURN_SQ = re.compile(r"""return\s+'((?:[^'\\]|\\.){2,})'""")
RE_RETURN_DQ = re.compile(r'''return\s+"((?:[^"\\]|\\.){2,})"''')

# 9. ?? 'English fallback'
RE_NULLCOAL_SQ = re.compile(r"""\?\?\s*'((?:[^'\\]|\\.){2,})'""")
RE_NULLCOAL_DQ = re.compile(r'''\?\?\s*"((?:[^"\\]|\\.){2,})"''')

# 10. condition ? 'English' : 'English'  (captures each branch separately)
RE_TERNARY_SQ = re.compile(r"""\?\s*'((?:[^'\\]|\\.){2,})'""")
RE_TERNARY_DQ = re.compile(r'''\?\s*"((?:[^"\\]|\\.){2,})"''')

# 11. switch/map expression:  enumVal => 'English text'
RE_SWITCH_SQ = re.compile(r"""=>\s*'((?:[^'\\]|\\.){2,})'""")
RE_SWITCH_DQ = re.compile(r'''=>\s*"((?:[^"\\]|\\.){2,})"''')

# 12. Constructor/function defaults: this.param = 'English' or String param = 'English'
RE_THISDEFAULT_SQ = re.compile(r"""this\.(\w+)\s*=\s*'((?:[^'\\]|\\.){2,})'""")
RE_THISDEFAULT_DQ = re.compile(r'''this\.(\w+)\s*=\s*"((?:[^"\\]|\\.){2,})"''')
RE_STRDEFAULT_SQ = re.compile(r"""String\s+(\w+)\s*=\s*'((?:[^'\\]|\\.){2,})'""")
RE_STRDEFAULT_DQ = re.compile(r'''String\s+(\w+)\s*=\s*"((?:[^"\\]|\\.){2,})"''')

# 13. .add('English text') — list-builder English
RE_ADD_SQ = re.compile(r"""\.add\(\s*'((?:[^'\\]|\\.){2,})'""")
RE_ADD_DQ = re.compile(r'''\.add\(\s*"((?:[^"\\]|\\.){2,})"''')

# 14. static const String foo = 'English text'
RE_STATICCONST_SQ = re.compile(
    r"""static\s+const\s+String\s+(\w+)\s*=\s*'((?:[^'\\]|\\.){2,})'"""
)
RE_STATICCONST_DQ = re.compile(
    r'''static\s+const\s+String\s+(\w+)\s*=\s*"((?:[^"\\]|\\.){2,})"'''
)

# 15. Bare positional string argument on its own line:
#       'English text',          — list entry, positional arg, enum constructor arg
#       'English text');         — final positional arg before close paren
#       'English text',          — trailing comma variant
#     These are standalone lines where the string is NOT preceded by a keyword,
#     param name, or pattern already matched above.  They appear as positional
#     arguments in constructors (especially enum const constructors), list
#     literals, and function calls.
RE_BARE_SQ = re.compile(r"""^\s*'((?:[^'\\]|\\.){3,})'[,;)\s]*$""")
RE_BARE_DQ = re.compile(r"""^\s*"((?:[^"\\]|\\.){3,})"[,;)\s]*$""")


# ── Helpers ───────────────────────────────────────────────────────────────

_COMMENT_PREFIXES = ("//", "///", "/*", "* ", "*\t")


def _is_comment(stripped: str) -> bool:
    return any(stripped.startswith(p) for p in _COMMENT_PREFIXES)


_LOG_RE = re.compile(
    r"^(?:log|_log|logger|_logger)\.\w+\(|^debugPrint\(|^print\(|^assert\("
)

# Matches the *start* of a multi-line log/debug call (including AppLogging).
_LOG_START_RE = re.compile(
    r"^(?:log|_log|logger|_logger|AppLogging)\.\w+\(|^debugPrint\(|^print\(|^assert\("
)


def _is_log(stripped: str) -> bool:
    return bool(_LOG_RE.match(stripped))


# Strings that are clearly technical / not English prose.
_TECH_RE = re.compile(
    r"^[a-z_][a-z0-9_./:@#?&=-]*$"  # path / url / identifier
    r"|^[\$\{\}\s%d.#,/:_\-+]+$"  # pure format / interpolation
    r"|^[A-Z][A-Z0-9_]+$"  # UPPER_SNAKE constant
    r"|^[A-Z]\w+\($"  # toString-style: 'ClassName(' or 'ClassName($field'
    r"|^\.[A-Z]"  # platform identifiers like '.AppleSystemUIFont'
    r"|^conf_"  # generated config identifiers like 'conf_${ts}_$suffix'
)

# Well-known font family names that are not translatable.
_FONT_FAMILIES = frozenset(
    {
        "Roboto",
        "Segoe UI",
        ".AppleSystemUIFont",
        "SF Pro",
        "SF Mono",
        "Helvetica",
        "Helvetica Neue",
        "Arial",
        "Courier New",
        "Menlo",
        "Fira Code",
    }
)


def _looks_technical(text: str) -> bool:
    if text.startswith("$") or text.startswith("{"):
        return True
    if text.startswith("."):
        return True
    if text.startswith("/") and " " not in text:
        # Route paths like '/scanner', '/main'
        return True
    if text.startswith("!${"):
        # Hex-formatted node identifiers like '!${nodeNum.toRadixString(16)}'
        return True
    if not re.search(r"[A-Za-z]", text):
        return True
    # Copyright / attribution strings are not translatable
    if "\u00a9" in text:  # © symbol
        return True
    # Font family names are not translatable
    if text in _FONT_FAMILIES:
        return True
    # Timezone identifiers like 'Australia/Melbourne', 'America/New_York'
    if re.match(r"^[A-Z][a-z]+/[A-Z][a-z_]+$", text):
        return True
    # Protocol identifiers with interpolation: 'CHANNEL_$x', 'GetConfig_${…}'
    if re.match(r"^[A-Z]\w*_\$", text):
        return True
    # Bracket-only wrappers: '[$notes]', '(${result.error})'
    if re.match(r"^[\[\(]\$", text):
        return True
    # Single camelCase or snake_case word < 40 chars — likely identifier
    if re.match(r"^[a-zA-Z_][a-zA-Z0-9_]*$", text) and len(text) < 40:
        return True
    # toString-style debug: 'ClassName(' or 'ClassName(field: ...'
    if re.match(r"^[A-Z]\w+\(", text):
        return True
    # UPPER_PREFIX_$interpolation: 'NONE (first pull)' is borderline but
    # strings that are ALL-CAPS with parens are usually technical.
    if re.match(r"^[A-Z]{2,}\s*\(", text):
        return True
    # Strings that are purely interpolation with minor decoration:
    # e.g. '0x${...}', 'uid=${...}', 'probe=$probeName'
    if re.match(r"^[a-z0-9_]+=?\$", text):
        return True
    # URL-like strings with scheme
    if re.match(r"^https?://", text):
        return True
    # Query-param fragments: '&label=${...}'
    if re.match(r"^[&?]\w+=", text):
        return True
    # Hex color/number prefixes: '#${...}', '0x${...}'
    if re.match(r"^[#0][x$]", text):
        return True
    if _TECH_RE.match(text):
        return True
    return False


# Files inside models/ or storage/ that contain user-facing text and must NOT
# be treated as data files.  Matched as suffix against the path relative to lib/.
_USER_FACING_DATA_DIR_FILES = frozenset(
    {
        "models/canned_response.dart",  # default quick-reply texts shown to users
        "models/tapback.dart",  # tapback reaction labels shown in UI
    }
)


def _is_in_data_dir(rel_path: str) -> bool:
    """True if the file lives in a data-only directory (demo, mock, fixtures,
    or genuinely non-translatable data/ dirs).  We intentionally exclude
    ``models/`` and ``storage/`` from the blanket sweep — too many user-facing
    strings live there (canned responses, widget templates, tapbacks).  Only
    files matching DATA_FILE_PATTERNS are treated as data in those dirs."""
    # Never flag explicitly user-facing files
    if any(rel_path.endswith(uf) for uf in _USER_FACING_DATA_DIR_FILES):
        return False
    return any(
        seg in ("data", "demo", "mock", "fixtures") for seg in rel_path.split("/")
    )


# ── File collection ───────────────────────────────────────────────────────


def _is_in_skipped_feature(rel_path: str) -> bool:
    """True if the file lives under a feature-flagged-off or non-user-facing
    feature directory (e.g. features/aether/, features/tak/, features/admin/).
    Also catches services/meshcore/ and similar nested paths."""
    parts = rel_path.split("/")
    # Check features/<name>/...
    if len(parts) >= 2 and parts[0] == "features" and parts[1] in SKIP_FEATURE_DIRS:
        return True
    # Check services/<name>/... (e.g. services/meshcore/)
    if len(parts) >= 2 and parts[0] == "services" and parts[1] in SKIP_FEATURE_DIRS:
        return True
    # Check core/<name>/... for protocol-specific code
    if len(parts) >= 2 and parts[0] == "core" and parts[1] in SKIP_FEATURE_DIRS:
        return True
    # Catch top-level meshcore files
    if any(seg == "meshcore" for seg in parts):
        return True
    return False


def _collect_dart_files() -> list[tuple[Path, bool]]:
    """Return (path, is_data_file) pairs for all scannable Dart files.

    Files under feature-flagged-off directories are excluded entirely
    (they don't need translations until the feature ships).
    """
    files: list[tuple[Path, bool]] = []
    skipped_feature_count = 0
    for p in sorted(LIB.rglob("*.dart")):
        rel = p.relative_to(LIB)
        if rel.parts[0] in SKIP_LIB_DIRS:
            continue
        rel_str = str(rel)
        # Skip entire feature directories that are flagged off or non-user-facing
        if _is_in_skipped_feature(rel_str):
            skipped_feature_count += 1
            continue
        # Skip individual MeshCore files outside features/meshcore/
        if rel_str in SKIP_FILES:
            skipped_feature_count += 1
            continue
        is_data = any(
            rel_str.endswith(pat) for pat in DATA_FILE_PATTERNS
        ) or _is_in_data_dir(rel_str)
        files.append((p, is_data))
    if skipped_feature_count:
        print(
            f"Skipped {skipped_feature_count} files in feature-flagged-off/"
            f"non-user-facing dirs ({', '.join(sorted(SKIP_FEATURE_DIRS))})"
        )
    return files


# ── Extraction ────────────────────────────────────────────────────────────


def _extract(path: Path, is_data_file: bool) -> list[Hit]:
    hits: list[Hit] = []
    rel = str(path.relative_to(PROJECT))

    try:
        lines = path.read_text(errors="ignore").splitlines()
    except OSError:
        return hits

    # Track bracket depth for multi-line log/debug calls so that
    # continuation lines (e.g. inside AppLogging.connection('...')) are
    # skipped even though they don't start with the log identifier.
    _in_log_depth = 0

    # Track bracket depth for multi-line Exception/throw so bare string
    # continuations inside them are classified as exceptions, not bare strings.
    _in_exception_depth = 0

    # Track whether we are inside a toString() method body so bare string
    # continuations (multi-line string concatenation inside toString) are
    # classified as debug, not bare_positional.
    _in_tostring_depth = 0

    for lineno, raw in enumerate(lines, 1):
        stripped = raw.lstrip()
        if _is_comment(stripped):
            continue

        # ── Multi-line log tracking ───────────────────────────────
        if _in_log_depth > 0:
            # We are inside a multi-line log statement — update depth
            _in_log_depth += raw.count("(") - raw.count(")")
            if _in_log_depth < 0:
                _in_log_depth = 0  # safety: mismatched parens
            continue
        if _is_log(stripped) or _LOG_START_RE.match(stripped):
            # Check if the statement closes on this same line
            depth = raw.count("(") - raw.count(")")
            if depth > 0:
                _in_log_depth = depth  # multi-line log — skip until closed
            continue

        # ── Multi-line exception tracking ─────────────────────────
        if _in_exception_depth > 0:
            _in_exception_depth += raw.count("(") - raw.count(")")
            if _in_exception_depth < 0:
                _in_exception_depth = 0
            # Don't skip — but mark that we're inside an exception context
            # so bare strings get classified as exception, not bare_positional.

        # ── Multi-line toString tracking ──────────────────────────
        if _in_tostring_depth > 0:
            _in_tostring_depth += raw.count("{") - raw.count("}")
            if _in_tostring_depth <= 0:
                _in_tostring_depth = 0
            # Don't skip — but mark context so bare strings get debug class.

        # ── lint-allow on current line OR adjacent lines ──────────
        if "// lint-allow: hardcoded-string" in raw:
            continue
        # Also check the next line (common pattern: the lint-allow comment
        # sits on the closing-paren line, one line after the string).
        if lineno < len(lines):
            next_line = lines[lineno]  # 0-indexed: lines[lineno] is lineno+1
            if "// lint-allow: hardcoded-string" in next_line:
                continue
        # Check the previous line ONLY if it is a standalone comment line
        # (i.e. the entire line is just a comment).  This prevents an inline
        # lint-allow on a *different* param (e.g. `message: '..', // lint-allow`)
        # from accidentally suppressing the *next* param (e.g. `userMessage:`).
        if lineno >= 2:
            prev_line = lines[lineno - 2]  # 0-indexed: lines[lineno-2] is lineno-1
            prev_stripped = prev_line.lstrip()
            if (
                prev_stripped.startswith("//")
                and "lint-allow: hardcoded-string" in prev_stripped
            ):
                continue

        # Detect start of multi-line exception/throw on this line
        _starts_exception = bool(
            re.match(
                r".*(?:throw\s+\w*(?:Exception|Error)|(?:State|Argument|Format|Unsupported)Error)\(",
                stripped,
            )
        )
        if _starts_exception:
            exc_depth = raw.count("(") - raw.count(")")
            if exc_depth > 0:
                _in_exception_depth = exc_depth

        # Detect toString() method start — track brace depth so bare
        # string continuations inside the body are classified as debug.
        if re.search(r"\btoString\b.*\{", stripped) or (
            re.search(r"\btoString\b", stripped) and stripped.rstrip().endswith("{")
        ):
            brace_depth = raw.count("{") - raw.count("}")
            if brace_depth > 0:
                _in_tostring_depth = brace_depth

        line_hits: list[Hit] = []

        # ── Text() widget ──────────────────────────────────────────
        for pat in (RE_TEXT_SQ, RE_TEXT_DQ):
            for m in pat.finditer(raw):
                text = m.group(1).strip()
                if not _looks_technical(text):
                    line_hits.append(
                        Hit(rel, lineno, stripped, text, "Text()", "", "", is_data_file)
                    )

        # ── param: Text('…') ──────────────────────────────────────
        for pat in (RE_PTXT_SQ, RE_PTXT_DQ):
            for m in pat.finditer(raw):
                param, text = m.group(1), m.group(2).strip()
                if param in TECHNICAL_PARAMS:
                    continue
                # For UI_PARAMS, skip _looks_technical — single English
                # words like 'Chat' or 'Settings' are valid findings.
                if param not in UI_PARAMS and _looks_technical(text):
                    continue
                if is_data_file and param in DATA_OBJECT_PARAMS:
                    continue
                if param in UI_PARAMS:
                    line_hits.append(
                        Hit(
                            rel,
                            lineno,
                            stripped,
                            text,
                            "param:Text()",
                            "",
                            param,
                            is_data_file,
                        )
                    )

        # ── param: 'string' (bare) ────────────────────────────────
        for pat in (RE_PARAM_SQ, RE_PARAM_DQ):
            for m in pat.finditer(raw):
                param, text = m.group(1), m.group(2).strip()
                if param in TECHNICAL_PARAMS:
                    continue
                # For UI_PARAMS, skip _looks_technical — single English
                # words like 'Chat' or 'Settings' are valid findings.
                if param not in UI_PARAMS and _looks_technical(text):
                    continue
                if is_data_file and param in DATA_OBJECT_PARAMS:
                    continue
                # Avoid duplicates with param:Text() above
                if any(h.lineno == lineno and h.text == text for h in line_hits):
                    continue
                if param in UI_PARAMS:
                    line_hits.append(
                        Hit(
                            rel,
                            lineno,
                            stripped,
                            text,
                            f"param:{param}",
                            "",
                            param,
                            is_data_file,
                        )
                    )
                # Non-UI, non-technical param — might still be user-facing
                # in a custom widget.  Include but mark as "other_param".
                elif param not in DATA_OBJECT_PARAMS:
                    line_hits.append(
                        Hit(
                            rel,
                            lineno,
                            stripped,
                            text,
                            f"other_param:{param}",
                            "",
                            param,
                            is_data_file,
                        )
                    )

        # ── Snackbar helpers ──────────────────────────────────────
        for pat in (RE_SNACK_SQ, RE_SNACK_DQ, RE_SAFESNK_SQ, RE_SAFESNK_DQ):
            for m in pat.finditer(raw):
                text = m.group(1).strip()
                if not _looks_technical(text):
                    if any(h.lineno == lineno and h.text == text for h in line_hits):
                        continue
                    line_hits.append(
                        Hit(
                            rel,
                            lineno,
                            stripped,
                            text,
                            "snackbar",
                            "",
                            "",
                            is_data_file,
                        )
                    )

        # ── throw / Exception ─────────────────────────────────────
        for pat in (RE_THROW_SQ, RE_THROW_DQ):
            for m in pat.finditer(raw):
                text = m.group(1).strip()
                if not _looks_technical(text):
                    if any(h.lineno == lineno and h.text == text for h in line_hits):
                        continue
                    line_hits.append(
                        Hit(
                            rel,
                            lineno,
                            stripped,
                            text,
                            "exception",
                            "",
                            "",
                            is_data_file,
                        )
                    )

        # ── return 'English text' ─────────────────────────────────
        for pat in (RE_RETURN_SQ, RE_RETURN_DQ):
            for m in pat.finditer(raw):
                text = m.group(1).strip()
                if _looks_technical(text):
                    continue
                if any(h.lineno == lineno and h.text == text for h in line_hits):
                    continue
                # Distinguish toString() debug returns from user-facing ones
                is_tostring = re.search(r"\btoString\b", stripped) is not None
                line_hits.append(
                    Hit(
                        rel,
                        lineno,
                        stripped,
                        text,
                        "return_tostring" if is_tostring else "return",
                        "",
                        "",
                        is_data_file,
                    )
                )

        # ── ?? 'English fallback' ─────────────────────────────────
        for pat in (RE_NULLCOAL_SQ, RE_NULLCOAL_DQ):
            for m in pat.finditer(raw):
                text = m.group(1).strip()
                if _looks_technical(text):
                    continue
                if any(h.lineno == lineno and h.text == text for h in line_hits):
                    continue
                line_hits.append(
                    Hit(
                        rel,
                        lineno,
                        stripped,
                        text,
                        "null_fallback",
                        "",
                        "",
                        is_data_file,
                    )
                )

        # ── ternary ? 'English' ───────────────────────────────────
        # Avoid double-counting ?? which we already handle above.
        for pat in (RE_TERNARY_SQ, RE_TERNARY_DQ):
            for m in pat.finditer(raw):
                # Skip if this is actually a ?? match (char before ? is also ?)
                start = m.start()
                if start > 0 and raw[start - 1] == "?":
                    continue
                text = m.group(1).strip()
                if _looks_technical(text):
                    continue
                if any(h.lineno == lineno and h.text == text for h in line_hits):
                    continue
                line_hits.append(
                    Hit(
                        rel,
                        lineno,
                        stripped,
                        text,
                        "ternary",
                        "",
                        "",
                        is_data_file,
                    )
                )

        # ── switch/map expression => 'English' ────────────────────
        for pat in (RE_SWITCH_SQ, RE_SWITCH_DQ):
            for m in pat.finditer(raw):
                text = m.group(1).strip()
                if _looks_technical(text):
                    continue
                if any(h.lineno == lineno and h.text == text for h in line_hits):
                    continue
                # Distinguish toString() / debug from user-facing
                is_tostring = re.search(r"\btoString\b", stripped) is not None
                line_hits.append(
                    Hit(
                        rel,
                        lineno,
                        stripped,
                        text,
                        "switch_tostring" if is_tostring else "switch_expr",
                        "",
                        "",
                        is_data_file,
                    )
                )

        # ── Constructor/function defaults: this.x = 'English' ─────
        for pat in (RE_THISDEFAULT_SQ, RE_THISDEFAULT_DQ):
            for m in pat.finditer(raw):
                param, text = m.group(1), m.group(2).strip()
                if _looks_technical(text):
                    continue
                if param in TECHNICAL_PARAMS:
                    continue
                if any(h.lineno == lineno and h.text == text for h in line_hits):
                    continue
                line_hits.append(
                    Hit(
                        rel,
                        lineno,
                        stripped,
                        text,
                        "default_this",
                        "",
                        param,
                        is_data_file,
                    )
                )

        # ── Function defaults: String param = 'English' ──────────
        for pat in (RE_STRDEFAULT_SQ, RE_STRDEFAULT_DQ):
            for m in pat.finditer(raw):
                param, text = m.group(1), m.group(2).strip()
                if _looks_technical(text):
                    continue
                if param in TECHNICAL_PARAMS:
                    continue
                if any(h.lineno == lineno and h.text == text for h in line_hits):
                    continue
                line_hits.append(
                    Hit(
                        rel,
                        lineno,
                        stripped,
                        text,
                        "default_param",
                        "",
                        param,
                        is_data_file,
                    )
                )

        # ── .add('English text') ──────────────────────────────────
        for pat in (RE_ADD_SQ, RE_ADD_DQ):
            for m in pat.finditer(raw):
                text = m.group(1).strip()
                if _looks_technical(text):
                    continue
                if any(h.lineno == lineno and h.text == text for h in line_hits):
                    continue
                line_hits.append(
                    Hit(
                        rel,
                        lineno,
                        stripped,
                        text,
                        "list_add",
                        "",
                        "",
                        is_data_file,
                    )
                )

        # ── static const String foo = 'English' ──────────────────
        for pat in (RE_STATICCONST_SQ, RE_STATICCONST_DQ):
            for m in pat.finditer(raw):
                param, text = m.group(1), m.group(2).strip()
                if _looks_technical(text):
                    continue
                if any(h.lineno == lineno and h.text == text for h in line_hits):
                    continue
                line_hits.append(
                    Hit(
                        rel,
                        lineno,
                        stripped,
                        text,
                        "static_const",
                        "",
                        param,
                        is_data_file,
                    )
                )

        # ── bare positional: standalone 'English text', ───────────
        # Only fires when the ENTIRE stripped line is just a quoted string
        # (with optional trailing comma/semicolon/paren).  This catches
        # enum constructor args, list entries, and multi-line positional
        # args that no other pattern above matched.
        if not line_hits:  # only if nothing else already matched this line
            for pat in (RE_BARE_SQ, RE_BARE_DQ):
                m = pat.match(raw)
                if m:
                    text = m.group(1).strip()
                    if _looks_technical(text):
                        continue
                    # If we are inside a multi-line toString context,
                    # classify as debug rather than bare_positional.
                    if _in_tostring_depth > 0:
                        line_hits.append(
                            Hit(
                                rel,
                                lineno,
                                stripped,
                                text,
                                "return_tostring",
                                "",
                                "",
                                is_data_file,
                            )
                        )
                    # If we are inside a multi-line exception context,
                    # classify as exception rather than bare_positional.
                    elif _in_exception_depth > 0:
                        line_hits.append(
                            Hit(
                                rel,
                                lineno,
                                stripped,
                                text,
                                "exception",
                                "",
                                "",
                                is_data_file,
                            )
                        )
                    else:
                        line_hits.append(
                            Hit(
                                rel,
                                lineno,
                                stripped,
                                text,
                                "bare_positional",
                                "",
                                "",
                                is_data_file,
                            )
                        )
                    break  # one match per line is enough

        hits.extend(line_hits)

    # Deduplicate: same line + same text
    seen: set[tuple[int, str]] = set()
    unique: list[Hit] = []
    for h in hits:
        k = (h.lineno, h.text)
        if k not in seen:
            seen.add(k)
            unique.append(h)
    return unique


# ── Classification ────────────────────────────────────────────────────────


def _classify(h: Hit) -> str:
    # Data files get their own bucket — not actionable for l10n.
    if h.is_data_file:
        return "data_file"

    if h.pattern == "exception":
        return "exception"

    if h.pattern in ("return_tostring", "switch_tostring"):
        return "debug_tostring"

    if h.pattern == "snackbar":
        return "snackbar"

    if h.param in ("errorText", "errorMessage"):
        return "error_ui"

    # Feature-area overrides (P2/P3 areas first — safe for bare_positional
    # because these areas don't produce P1 classifications).
    path_lower = h.path.lower()
    if "visual_flow" in path_lower or "vs_node" in path_lower:
        return "flow_editor"
    if "widget_builder" in path_lower:
        return "widget_builder"
    if "/help/" in path_lower or "help_content" in path_lower:
        return "help_content"
    if "whats_new" in path_lower:
        return "whats_new"
    if "mqtt" in path_lower:
        return "mqtt_config"
    if "/dashboard/" in path_lower:
        return "dashboard"
    if "aether" in path_lower:
        return "aether"
    if "/ar/" in path_lower or "/ar_" in path_lower:
        return "ar"
    if "notification" in path_lower:
        return "notification"

    # bare_positional has low semantic certainty — we don't know whether
    # it's a user-facing label or a CSV header or a technical constant.
    # Intercept here (after P2/P3 feature-area overrides for reporting
    # granularity, but BEFORE P1-producing areas like settings/onboarding)
    # so it doesn't get accidentally promoted to P1.
    if h.pattern == "bare_positional":
        return "bare_positional"

    # P1-producing feature-area overrides — bare_positional is already
    # handled above so only high-confidence patterns reach these.
    if "/settings/" in path_lower or "settings_screen" in path_lower:
        return "settings"
    if "onboarding" in path_lower:
        return "onboarding"

    # New pattern-based categories
    if h.pattern == "null_fallback":
        return "null_fallback"
    if h.pattern == "ternary":
        return "ternary"
    if h.pattern == "switch_expr":
        return "switch_expr"
    if h.pattern == "return":
        return "return_string"
    if h.pattern in ("default_this", "default_param"):
        return "constructor_default"
    if h.pattern == "list_add":
        return "list_add"
    if h.pattern == "static_const":
        return "static_const"

    # Pattern-based (original)
    if h.pattern in ("Text()", "param:Text()"):
        return "text_widget"
    if h.param in (
        "title",
        "label",
        "subtitle",
        "heading",
        "caption",
        "actionLabel",
        "confirmLabel",
        "cancelLabel",
        "positiveLabel",
        "negativeLabel",
        "emptyTitle",
        "emptyActionLabel",
    ):
        return "ui_label"
    if h.param in (
        "description",
        "hintText",
        "labelText",
        "helperText",
        "hint",
        "placeholder",
        "emptySubtitle",
        "emptyDescription",
        "emptyMessage",
    ):
        return "ui_hint"
    if h.param in (
        "message",
        "content",
        "body",
        "text",
        "userMessage",
        "fallbackMessage",
    ):
        return "ui_message"
    if h.param in ("tooltip",):
        return "tooltip"
    if h.param in ("subject",):
        return "share_subject"
    if h.param in ("name", "displayName"):
        return "display_name"
    if h.pattern.startswith("other_param:"):
        return "other_param"

    return "other"


def _feature_area(path: str) -> str:
    parts = path.split("/")
    # lib/features/<name>/...
    if len(parts) >= 3 and parts[1] == "features":
        return parts[2]
    if len(parts) >= 3 and parts[1] == "core":
        return f"core/{parts[2]}"
    if len(parts) >= 2:
        return parts[1]
    return "root"


# ── Priority ──────────────────────────────────────────────────────────────

PRIORITY: dict[str, int] = {
    # P1 — must fix: user sees English where they shouldn't
    "snackbar": 1,
    "error_ui": 1,
    "text_widget": 1,
    "ui_label": 1,
    "ui_hint": 1,
    "ui_message": 1,
    "onboarding": 1,
    "settings": 1,
    "constructor_default": 2,
    # P2 — should fix: visible but less prominent
    "tooltip": 2,
    "dashboard": 2,
    "help_content": 2,
    "whats_new": 2,
    "notification": 2,
    "widget_builder": 2,
    "mqtt_config": 2,
    "aether": 2,
    "ar": 2,
    "null_fallback": 2,
    "ternary": 2,
    "switch_expr": 2,
    "return_string": 2,
    "static_const": 2,
    "list_add": 2,
    "bare_positional": 2,
    # P3 — nice to have
    "share_subject": 3,
    "display_name": 3,
    "flow_editor": 3,
    "other_param": 3,
    "other": 3,
    # P4 — skip / not user-facing
    "exception": 4,
    "debug_tostring": 4,
    "data_file": 4,
}

_PRI_LABELS = {1: "P1 HIGH", 2: "P2 MED", 3: "P3 LOW", 4: "P4 SKIP"}


# ── Reports ───────────────────────────────────────────────────────────────


def _write_detail(hits: list[Hit], path: Path) -> None:
    ordered = sorted(
        hits, key=lambda h: (PRIORITY.get(h.category, 3), h.path, h.lineno)
    )
    with open(path, "w") as f:
        for h in ordered:
            pri = PRIORITY.get(h.category, 3)
            f.write(f"P{pri} [{h.category}] {h.path}:{h.lineno}")
            if h.param:
                f.write(f" ({h.param}:)")
            f.write(f'\n  "{h.text}"\n  {h.line}\n\n')


def _write_summary(
    hits: list[Hit],
    cat_counts: Counter[str],
    area_counts: Counter[str],
    area_p1: Counter[str],
    pri_totals: dict[int, int],
    path: Path,
) -> None:
    with open(path, "w") as f:
        actionable = sum(
            c for cat, c in cat_counts.items() if PRIORITY.get(cat, 3) <= 2
        )
        f.write("=== Hardcoded English Strings — l10n Extraction Report ===\n\n")
        f.write(f"Total hits:          {len(hits)}\n")
        f.write(f"Actionable (P1+P2):  {actionable}\n")
        for pri in (1, 2, 3, 4):
            f.write(f"  {_PRI_LABELS[pri]}: {pri_totals.get(pri, 0):>5d}\n")

        f.write("\n\n--- By Category ---\n")
        for cat, count in cat_counts.most_common():
            pri = PRIORITY.get(cat, 3)
            f.write(f"  P{pri} {cat:.<30s} {count:5d}\n")

        f.write("\n\n--- By Feature Area ---\n")
        for area, count in area_counts.most_common():
            p1 = area_p1.get(area, 0)
            f.write(f"  {area:.<30s} {count:5d}  (P1: {p1})\n")

        # Per-file P1 breakdown for easy triage
        p1_by_file: defaultdict[str, list[Hit]] = defaultdict(list)
        for h in hits:
            if PRIORITY.get(h.category, 3) == 1:
                p1_by_file[h.path].append(h)
        if p1_by_file:
            f.write("\n\n--- P1 Strings by File ---\n")
            for fpath, fhits in sorted(p1_by_file.items()):
                f.write(f"\n  {fpath} ({len(fhits)} strings):\n")
                for h in sorted(fhits, key=lambda h: h.lineno):
                    f.write(f'    L{h.lineno}: "{h.text[:90]}"\n')


# ── Main ──────────────────────────────────────────────────────────────────


def main() -> None:
    t0 = time.monotonic()

    files = _collect_dart_files()
    ui_files = [(p, d) for p, d in files if not d]
    data_files = [(p, d) for p, d in files if d]
    print(f"Dart files: {len(files)} ({len(ui_files)} UI, {len(data_files)} data)")

    all_hits: list[Hit] = []
    for p, is_data in files:
        all_hits.extend(_extract(p, is_data))

    for h in all_hits:
        h.category = _classify(h)

    elapsed = time.monotonic() - t0

    # ── Counts ──
    cat_counts: Counter[str] = Counter(h.category for h in all_hits)
    area_counts: Counter[str] = Counter(_feature_area(h.path) for h in all_hits)
    area_p1: Counter[str] = Counter(
        _feature_area(h.path) for h in all_hits if PRIORITY.get(h.category, 3) == 1
    )
    pri_totals: dict[int, int] = {}
    for pri in (1, 2, 3, 4):
        pri_totals[pri] = sum(
            c for cat, c in cat_counts.items() if PRIORITY.get(cat, 3) == pri
        )

    # ── Stdout ──
    actionable = pri_totals.get(1, 0) + pri_totals.get(2, 0)
    non_data = [h for h in all_hits if not h.is_data_file]
    data_only = [h for h in all_hits if h.is_data_file]

    print(f"Found {len(all_hits)} total hits in {elapsed:.2f}s")
    print(f"  Actionable code strings: {len(non_data)}")
    print(f"  Data-file strings:       {len(data_only)} (excluded from counts below)")
    print()

    print(f"{'Category':<24s} {'Count':>5s}  {'Priority'}")
    print("-" * 45)
    for cat, count in cat_counts.most_common():
        if cat == "data_file":
            continue
        pri = PRIORITY.get(cat, 3)
        print(f"  {cat:<22s} {count:5d}  {_PRI_LABELS[pri]}")
    if data_only:
        print(f"  {'data_file':<22s} {len(data_only):5d}  {_PRI_LABELS[4]}")

    print()
    for pri in (1, 2, 3, 4):
        label = _PRI_LABELS[pri]
        # For display, exclude data_file from P4 count to show separately
        if pri == 4:
            exc_count = pri_totals[pri] - len(data_only)
            print(f"{label}: {exc_count:>5d}  (+{len(data_only)} data-file)")
        else:
            print(f"{label}: {pri_totals[pri]:>5d}")
    print(f"{'TOTAL':<9s}: {len(all_hits):>5d}")
    print()

    # Feature areas (excluding data_file)
    non_data_area: Counter[str] = Counter(_feature_area(h.path) for h in non_data)
    print(f"{'Feature Area':<30s} {'Total':>5s}  {'P1':>4s}")
    print("-" * 44)
    for area, count in non_data_area.most_common():
        p1 = area_p1.get(area, 0)
        if count > 0:
            print(f"  {area:<28s} {count:5d}  {p1:4d}")

    # ── Write files ──
    out = PROJECT / "build"
    out.mkdir(parents=True, exist_ok=True)

    detail_path = out / "hardcoded_strings.txt"
    _write_detail(all_hits, detail_path)

    summary_path = out / "hardcoded_summary.txt"
    _write_summary(all_hits, cat_counts, area_counts, area_p1, pri_totals, summary_path)

    print(f"\nDetailed: {detail_path}")
    print(f"Summary:  {summary_path}")
    print(f"Completed in {time.monotonic() - t0:.2f}s")

    # Exit 1 if there are P1 hits — useful as a CI gate
    if pri_totals.get(1, 0) > 0:
        sys.exit(1)


if __name__ == "__main__":
    main()
