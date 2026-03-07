#!/usr/bin/env bash
set -euo pipefail

output_dir="${QUARTO_PROJECT_OUTPUT_DIR:-dist}"

pages=(
  "setup-vscode-copilot.qmd"
  "setup-cursor.qmd"
  "setup-codex-cli.qmd"
  "setup-claude-code.qmd"
  "setup-opencode.qmd"
)

mkdir -p "$output_dir"

for page in "${pages[@]}"; do
  base_name="${page%.qmd}"
  html_name="${base_name}.html"
  files_dir="${base_name}_files"

  quarto render "$page" --to html

  if [ -f "$output_dir/$html_name" ]; then
    find "$output_dir/$html_name" -delete
  fi
  mv "$html_name" "$output_dir/$html_name"

  if [ -d "$files_dir" ]; then
    if [ -d "$output_dir/$files_dir" ]; then
      find "$output_dir/$files_dir" -depth -delete
    fi
    mv "$files_dir" "$output_dir/$files_dir"
  fi
done
