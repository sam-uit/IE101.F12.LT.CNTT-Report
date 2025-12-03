# LaTeX Codebase Modernization (2025)

## Overview

This document outlines the modernization of the IE101 thesis template from a 2012-era LaTeX setup to a modern LuaLaTeX-based system with native Unicode and Vietnamese support.

## Key Changes

### 1. **Engine: pdfLaTeX → LuaLaTeX**

- **Before:** pdfLaTeX with vntex and vieextsizes packages for Vietnamese support
- **After:** LuaLaTeX with native Unicode support

**Why?**

- LuaLaTeX has built-in UTF-8 support without workarounds
- Enables modern font technologies via fontspec
- Better handling of complex scripts and diacritical marks
- More maintainable and future-proof

### 2. **Vietnamese Language Support**

- **Before:** `\usepackage[utf8]{vntex}` - a 2010 workaround for Vietnamese in pdfLaTeX
- **After:** Polyglossia with Vietnamese support
  ```latex
  \usepackage{fontspec}
  \usepackage{polyglossia}
  \setdefaultlanguage{vietnamese}
  \setotherlanguage{english}
  ```

**Why?**

- vntex is deprecated and no longer actively maintained
- Polyglossia is the modern standard for LuaLaTeX language support (superior to babel for extended languages)
- fontspec provides proper Unicode font configuration via OpenType fonts
- Polyglossia automatically handles Vietnamese-specific typography and hyphenation
- Works seamlessly with LuaLaTeX's native Unicode capabilities

### 3. **Font Sizes: Removed vieextsizes.sty**

- **Before:** Required `\usepackage[13pt]{vieextsizes}` with complex font scaling via magnification
- **After:** Native support for all standard sizes (10pt, 11pt, 12pt, 13pt+)

**Why?**

- Modern LaTeX distributions support extended font sizes natively
- vieextsizes was a workaround for an 13-year-old limitation
- No more font magnification hacks needed
- Cleaner, more predictable typography

### 4. **Graphics Handling**

- **Before:** `\usepackage[pdftex]{graphicx}`
- **After:** `\usepackage{graphicx}` (no pdftex option needed)

**Why?**

- LuaLaTeX handles PDF output natively
# Modernization & Optimization Plan (reproducible)

This document records a reproducible, step-by-step plan for modernizing and optimizing the thesis LaTeX codebase. It contains the rationale for each change, exact commands to perform the changes and verify them, and guidelines for committing and rolling back edits.

Goals
- Modernization: move to an actively maintained toolchain (LuaLaTeX, fontspec, polyglossia) and remove legacy workarounds (vntex, vieextsizes, vmargin).
- Optimization: simplify the build, reduce redundant package loads, improve maintainability, and prepare a small template for contributors.

Prerequisites (environment)
- TeX Live 2020+ (TeX Live 2025 recommended) with LuaLaTeX available.
- `xindy` for glossaries (optional — fallback to makeindex exists).
- `pygments` if you use `minted` (installed by `pip install Pygments`).
- `git` for branching/commits.

High-level strategy
1. Create a working branch for each major change (example: `feat/modernize-class`, `feat/consolidate-preamble`, `chore/move-hyperref`, `chore/makefile-updates`).
2. Make small, reviewable commits: one logical change per commit (class edits, template addition, Makefile update, docs update, legacy file relocation).
3. Verify after each commit by building the PDF and running a minimal test suite (see verification below).
4. Keep legacy files in a `deprecated/` folder, with short headers explaining why they were kept.

Detailed step-by-step plan (with reasons and commands)

Step 0 — Branch and baseline build
- Why: ensure we have a reproducible starting point and know the current build behavior.
- Commands:

```bash
git checkout -b feat/modernize-class
# Verify current build
make pdf
```

Step 1 — Move to LuaLaTeX + fontspec + polyglossia (class-level change)
- Why: native Unicode/Vietnamese support, modern font handling, remove vntex.
- Files: `thesis.cls` (primary), minimal changes to `thesis.tex` only to remove redundant packages.
- Changes:
   - Add `\usepackage{fontspec}` at top of class.
   - Add `\usepackage{polyglossia}` and set `\setdefaultlanguage{vietnamese}` and `\setotherlanguage{english}`.
   - Remove `\usepackage[utf8]{vntex}` and `\usepackage[13pt]{vieextsizes}` if present.
- Commands:

```bash
# Edit thesis.cls
git add thesis.cls
git commit -m "feat(class): use fontspec + polyglossia for Unicode/Vietnamese"
# Build
lualatex --shell-escape -interaction=nonstopmode thesis.tex
```

Step 2 — Consolidate common packages into `thesis.cls`
- Why: reduce duplication, make `thesis.tex` a minimal template that users can edit safely.
- Files: `thesis.cls` (add common packages), `thesis.tex` (remove duplicate `\usepackage{...}` lines).
- Suggested packages to centralize: `paralist`, `tabularx`, `multirow`, `tocloft`, `hypcap`, `blindtext`, `eqparbox`, `calc`, `float`.
- Commands:

```bash
# Make changes
git add thesis.cls thesis.tex
git commit -m "chore(class/doc): consolidate common packages into class and simplify thesis.tex"
# Verify build
lualatex --shell-escape -interaction=nonstopmode thesis.tex
```

Step 3 — Modernize code highlighting and image handling
- Why: prefer `minted` (Pygments) for richer syntax highlighting; LuaLaTeX handles image formats directly, so `epstopdf` is usually unnecessary.
- Changes:
   - Keep `minted` and remove `listings` from the class.
   - Remove `epstopdf` from class; document how to handle legacy EPS files (convert with `epstopdf` or leave TeX Live to handle it).
- Commands:

```bash
git add thesis.cls
git commit -m "chore(class): prefer minted (Pygments); remove listings and epstopdf"
```

Step 4 — Move `hyperref` load earlier in the class
- Why: some class macros (e.g., those using `\texorpdfstring` or `\texorpdfstring` in titles) expect hyperref to be available; moving it earlier avoids errors.
- Change: place `\usepackage{hyperref}` immediately after `\LoadClass{...}` and before any macros that use it.
- Commands:

```bash
git add thesis.cls
git commit -m "chore(class): load hyperref early so class macros can use hyperref commands"
```

Step 5 — Small UX improvements in `thesis.cls`
- Why: suppress common harmless warnings and make the class friendlier to end users.
- Examples:
   - Set a safe `\headheight` value to avoid `fancyhdr` warnings.
   - Document required build flags in comments (e.g., `--shell-escape` for minted).
- Commands:

```bash
git add thesis.cls
git commit -m "chore(class): set headheight and add build notes"
```

Step 6 — Add a minimal `thesis-template.tex` for contributors
- Why: give users a drop-in minimal example showing metadata macros, build instructions, and a clean starting point.
- Commands:

```bash
git add thesis-template.tex
git commit -m "feat(template): add minimal thesis-template.tex demonstrating modern class usage"
```

Step 7 — Update Makefile and automation
- Why: provide a robust `make pdf` target that runs LuaLaTeX, builds glossaries, runs BibTeX/Biber as appropriate, and repeats LaTeX passes.
- Recommended `Makefile` sequence (example):

```makefile
pdf:
	lualatex --shell-escape -interaction=nonstopmode thesis.tex
	makeglossaries thesis || true
	bibtex thesis || true
	lualatex --shell-escape -interaction=nonstopmode thesis.tex
	lualatex --shell-escape -interaction=nonstopmode thesis.tex
```

Commit the Makefile change with a clear message.

Step 8 — Preserve and archive legacy files
- Why: keep the historical files for reference or rollback, but remove them from the active class search path.
- Action: move `vieextsizes.sty`, `vnextsizes.sty`, and any `vntex` copies into `deprecated/` and add a header indicating why they were preserved.
- Commands:

```bash
mkdir -p deprecated
git mv vieextsizes.sty deprecated/ || cp vieextsizes.sty deprecated/
git add deprecated/*
git commit -m "chore(deprecated): move legacy size/language packages to deprecated/"
```

Step 9 — Update documentation
- Why: ensure the README/MODERNIZATION.md explains the new workflow and reproduces the steps for future maintainers.
- Action: update `MODERNIZATION.md` with the plan (this document), and add a `CONTRIBUTING.md` with branch/commit guidelines and build steps.
- Commands:

```bash
git add MODERNIZATION.md CONTRIBUTING.md
git commit -m "docs: update modernization guide and contributing instructions"
```

Step 10 — Verification and CI
- Why: automated verification prevents regressions and ensures reproducibility.
- Local verification checklist (run after each commit):
   - `lualatex --shell-escape -interaction=nonstopmode thesis.tex` (no fatal errors)
   - `makeglossaries thesis` (verify glossaries; install xindy for `vietnamese` if needed)
   - `bibtex thesis` or `biber thesis` depending on chosen backend
   - Check final `thesis.pdf` for correct fonts, hyphenation, and expected content

- CI suggestion: add a GitHub Actions workflow that runs the full build on push to a branch and on PRs. Example steps:
   - Set up TeX Live on the runner (a Docker image or apt-get install texlive-full)
   - Run `lualatex --shell-escape ...`, `makeglossaries`, `bibtex`/`biber`, re-run `lualatex` twice
   - Upload `thesis.pdf` as an artifact

Reasons summary
- LuaLaTeX + fontspec + polyglossia: modern Unicode handling, robust Vietnamese support, simpler configuration.
- Consolidation: fewer surprises for contributors and faster iteration (less duplication).
- `minted` over `listings`: richer highlighting and language support via Pygments.
- Moving `hyperref` early: solves subtle macro availability issues when the class defines title macros that call hyperref helpers.

Rollback guidance
- If a change causes a problem, revert the logical commit(s) with `git revert <commit>` or reset the branch locally and re-apply smaller patches.

Checklist before merging to `main`/`master`
- All commits are small and have descriptive messages.
- `make pdf` succeeds (or CI passes) with no fatal errors.
- Glossaries and bibliography build successfully or the README documents how to complete those steps.
- Legacy files are preserved in `deprecated/` with a short rationale.

Appendix — Quick reproduction commands

```bash
# Clone and switch to your feature branch
git checkout -b feat/modernize-class

# Make changes per steps above, commit often
git add <files>
git commit -m "<clear message>"

# Local verification
lualatex --shell-escape -interaction=nonstopmode thesis.tex
makeglossaries thesis || true
bibtex thesis || true
lualatex --shell-escape -interaction=nonstopmode thesis.tex
lualatex --shell-escape -interaction=nonstopmode thesis.tex
```

---

Document status
- This file documents the canonical modernization + optimization plan and should be updated as changes land.  
- Last update: 2025-12-03 (branch: `feat/optimizationCodebase`).
