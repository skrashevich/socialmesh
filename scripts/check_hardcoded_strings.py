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

Key design choices
------------------
*   Data-only files (airports, airlines, ringtones, demo fixtures, etc.) are
    scanned separately and tagged so they don't pollute the actionable count.
*   The `name:` / `city:` / `code:` params inside model or data files are
    treated as proper-noun data, not translatable UI strings.
*   Exception messages are reported but at P4 — they're for logs, not users.
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


def _sq(inner: str) -> re.Pattern[str]:
    """Wrap *inner* in single-quoted string capture."""
    return re.compile(inner.replace("STR", r"'([^'\\]{2,})'"))


def _dq(inner: str) -> re.Pattern[str]:
    """Wrap *inner* in double-quoted string capture."""
    return re.compile(inner.replace("STR", r'"([^"\\]{2,})"'))


# 1. Text('...')  /  Text("...")
RE_TEXT_SQ = _sq(r"Text\(\s*STR")
RE_TEXT_DQ = _dq(r"Text\(\s*STR")

# 2. param: 'string'  /  param: "string"
#    Captures (param, string).
RE_PARAM_SQ = re.compile(r"""(\w+):\s*'([^'\\]{2,})'""")
RE_PARAM_DQ = re.compile(r'''(\w+):\s*"([^"\\]{2,})"''')

# 3. param: Text('...')  /  param: const Text('...')
RE_PTXT_SQ = re.compile(r"""(\w+):\s*(?:const\s+)?Text\(\s*'([^'\\]{2,})'""")
RE_PTXT_DQ = re.compile(r'''(\w+):\s*(?:const\s+)?Text\(\s*"([^"\\]{2,})"''')

# 4. showXxxSnackBar(ctx, 'string')
RE_SNACK_SQ = re.compile(
    r"""show(?:Error|Info|Success|Warning|Action)SnackBar\([^,]*,\s*'([^'\\]{2,})'"""
)
RE_SNACK_DQ = re.compile(
    r'''show(?:Error|Info|Success|Warning|Action)SnackBar\([^,]*,\s*"([^"\\]{2,})"'''
)

# 5. safeShowSnackBar('string')
RE_SAFESNK_SQ = re.compile(r"""safeShowSnackBar\(\s*'([^'\\]{2,})'""")
RE_SAFESNK_DQ = re.compile(r'''safeShowSnackBar\(\s*"([^"\\]{2,})"''')

# 6. AppBottomSheet patterns — caught by param patterns already

# 7. throw / Exception('...')
RE_THROW_SQ = re.compile(
    r"""(?:throw\s+\w*(?:Exception|Error)|(?:State|Argument|Format|Unsupported)Error)\(\s*'([^'\\]{2,})'"""
)
RE_THROW_DQ = re.compile(
    r'''(?:throw\s+\w*(?:Exception|Error)|(?:State|Argument|Format|Unsupported)Error)\(\s*"([^"\\]{2,})"'''
)


# ── Helpers ───────────────────────────────────────────────────────────────

_COMMENT_PREFIXES = ("//", "///", "/*", "* ", "*\t")


def _is_comment(stripped: str) -> bool:
    return any(stripped.startswith(p) for p in _COMMENT_PREFIXES)


_LOG_RE = re.compile(
    r"^(?:log|_log|logger|_logger)\.\w+\(|^debugPrint\(|^print\(|^assert\("
)


def _is_log(stripped: str) -> bool:
    return bool(_LOG_RE.match(stripped))


# Strings that are clearly technical / not English prose.
_TECH_RE = re.compile(
    r"^[a-z_][a-z0-9_./:@#?&=-]*$"  # path / url / identifier
    r"|^[\$\{\}\s%d.#,/:_\-+]+$"  # pure format / interpolation
    r"|^[A-Z][A-Z0-9_]+$"  # UPPER_SNAKE constant
)


def _looks_technical(text: str) -> bool:
    if text.startswith("$") or text.startswith("{"):
        return True
    if not re.search(r"[A-Za-z]", text):
        return True
    # Single camelCase or snake_case word < 40 chars — likely identifier
    if re.match(r"^[a-zA-Z_][a-zA-Z0-9_]*$", text) and len(text) < 40:
        return True
    if _TECH_RE.match(text):
        return True
    return False


def _is_in_data_dir(rel_path: str) -> bool:
    """True if the file lives in a data/ models/ storage/ or fixture dir."""
    return any(
        seg in ("data", "models", "storage", "demo", "mock", "fixtures")
        for seg in rel_path.split("/")
    )


# ── File collection ───────────────────────────────────────────────────────


def _collect_dart_files() -> list[tuple[Path, bool]]:
    """Return (path, is_data_file) pairs for all scannable Dart files."""
    files: list[tuple[Path, bool]] = []
    for p in sorted(LIB.rglob("*.dart")):
        rel = p.relative_to(LIB)
        if rel.parts[0] in SKIP_LIB_DIRS:
            continue
        rel_str = str(rel)
        is_data = any(
            rel_str.endswith(pat) for pat in DATA_FILE_PATTERNS
        ) or _is_in_data_dir(rel_str)
        files.append((p, is_data))
    return files


# ── Extraction ────────────────────────────────────────────────────────────


def _extract(path: Path, is_data_file: bool) -> list[Hit]:
    hits: list[Hit] = []
    rel = str(path.relative_to(PROJECT))

    try:
        lines = path.read_text(errors="ignore").splitlines()
    except OSError:
        return hits

    for lineno, raw in enumerate(lines, 1):
        stripped = raw.lstrip()
        if _is_comment(stripped):
            continue
        if _is_log(stripped):
            continue

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
                if _looks_technical(text) or param in TECHNICAL_PARAMS:
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
                if _looks_technical(text) or param in TECHNICAL_PARAMS:
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

    if h.pattern == "snackbar":
        return "snackbar"

    if h.param in ("errorText", "errorMessage"):
        return "error_ui"

    # Feature-area overrides
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
    if "/settings/" in path_lower or "settings_screen" in path_lower:
        return "settings"
    if "/dashboard/" in path_lower:
        return "dashboard"
    if "onboarding" in path_lower:
        return "onboarding"
    if "aether" in path_lower:
        return "aether"
    if "/ar/" in path_lower or "/ar_" in path_lower:
        return "ar"
    if "notification" in path_lower:
        return "notification"

    # Pattern-based
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
    if h.param in ("message", "content", "body", "text"):
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
    # P3 — nice to have
    "share_subject": 3,
    "display_name": 3,
    "flow_editor": 3,
    "other_param": 3,
    "other": 3,
    # P4 — skip / not user-facing
    "exception": 4,
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
