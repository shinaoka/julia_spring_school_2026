#!/usr/bin/env python3

import base64
import binascii
import os
import re
import sys
from pathlib import Path


DATA_BASE64_RE = re.compile(
    r"data:(?P<mime>application/javascript|text/css);base64,(?P<b64>[A-Za-z0-9+/=\n\r]+)"
)


def _b64_decode(b64_text: str) -> bytes:
    cleaned = re.sub(r"\s+", "", b64_text)
    padding = (-len(cleaned)) % 4
    cleaned += "=" * padding
    return base64.b64decode(cleaned)


def _b64_encode(raw: bytes) -> str:
    return base64.b64encode(raw).decode("ascii")


def relativize_html_text(html: str, prefix: str) -> str:
    # Convert root-relative paths like "/internal/..." into per-page relative ones.
    # Example on a page under dist/lectures/: prefix = "../".
    html = re.sub(
        r"\b(href|src|action)=(['\"])\/(?!\/)",
        lambda m: f"{m.group(1)}={m.group(2)}{prefix}",
        html,
    )

    def _rewrite_data_url(match: re.Match[str]) -> str:
        mime = match.group("mime")
        b64 = match.group("b64")
        try:
            decoded = _b64_decode(b64)
        except (binascii.Error, ValueError):
            return match.group(0)

        try:
            text = decoded.decode("utf-8")
        except UnicodeDecodeError:
            return match.group(0)

        # Inside embedded scripts, Shiroa uses root-relative paths like
        # '/internal/...', '/home.html', '/lectures/...'. Convert them to
        # per-page relative by replacing the leading '/' in string literals.
        text = re.sub(r"([\"'`])\/(?!\/)", lambda m: f"{m.group(1)}{prefix}", text)

        reencoded = _b64_encode(text.encode("utf-8"))
        return f"data:{mime};base64,{reencoded}"

    return DATA_BASE64_RE.sub(_rewrite_data_url, html)


def main() -> int:
    if len(sys.argv) != 2:
        print("Usage: relativize_dist.py <dist-dir>", file=sys.stderr)
        return 2

    dist_dir = Path(sys.argv[1])
    if not dist_dir.exists() or not dist_dir.is_dir():
        print(f"dist dir not found: {dist_dir}", file=sys.stderr)
        return 2

    html_files = sorted(dist_dir.rglob("*.html"))
    for path in html_files:
        # Compute prefix from this file's directory back to dist root.
        rel_parent = path.parent.relative_to(dist_dir)
        depth = 0 if str(rel_parent) == "." else len(rel_parent.parts)
        prefix = "../" * depth

        original = path.read_text(encoding="utf-8")
        updated = relativize_html_text(original, prefix)
        if updated != original:
            path.write_text(updated, encoding="utf-8")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
