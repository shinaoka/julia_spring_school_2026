# Prerequisites Setup Pages Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Reorganize the prerequisites page into a hub page and move tool-specific setup instructions into supplemental pages that are reachable by links but do not appear in the sidebar.

**Architecture:** Keep `book/prerequisites.qmd` focused on goals, tool selection, and shared requirements. Create one standalone `setup-*.qmd` page per tool with `sidebar: false` and `page-navigation: false`, then ensure Quarto renders those pages without adding them to `book.chapters`.

**Tech Stack:** Quarto book project, Markdown (`.qmd`)

---

### Task 1: Record rendering strategy

**Files:**
- Modify: `book/_quarto.yml`

**Step 1: Add explicit render targets**

Add a `project.render` list that includes the chapter pages plus the new `setup-*.qmd` pages.

**Step 2: Keep sidebar scope unchanged**

Leave `book.chapters` limited to the main lecture flow so supplemental pages are not listed in the sidebar.

### Task 2: Rebuild the prerequisites hub

**Files:**
- Modify: `book/prerequisites.qmd`
- Modify: `book/topics/prerequisites.typ`

**Step 1: Move learning goals to the top**

Place the lecture goals ahead of detailed setup content.

**Step 2: Replace detailed setup instructions with a hub section**

Keep the tool-generation overview and a comparison table, but replace long setup prose with short summaries and links to the tool-specific pages.

**Step 3: Preserve shared prerequisites**

Retain common requirements such as GitHub, `gh`, Julia, VS Code, and the package predownload section.

### Task 3: Create supplemental setup pages

**Files:**
- Create: `book/setup-vscode-copilot.qmd`
- Create: `book/setup-cursor.qmd`
- Create: `book/setup-codex-cli.qmd`
- Create: `book/setup-claude-code.qmd`
- Create: `book/setup-opencode.qmd`

**Step 1: Add page front matter**

Each page should set `sidebar: false` and `page-navigation: false`.

**Step 2: Move tool-specific instructions**

Transfer the setup content from `prerequisites.qmd` into the matching page, keeping the existing level of detail and links.

**Step 3: Add a return link**

Include a short link back to `prerequisites.qmd` near the top or bottom of each page.

### Task 4: Verify structure

**Files:**
- Verify: `book/_quarto.yml`
- Verify: `book/prerequisites.qmd`
- Verify: `book/setup-*.qmd`

**Step 1: Check link and sidebar intent**

Run a text search to confirm each setup page is linked from `prerequisites.qmd` and not listed in `book.chapters`.

**Step 2: Render the book**

Run `quarto render` from `book/` and confirm it exits successfully.

**Step 3: Check rendered outputs**

Confirm the generated `dist/` includes the setup pages and that the main sidebar still only contains the book chapters.
