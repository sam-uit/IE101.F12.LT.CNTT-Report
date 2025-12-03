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
- pdftex option is implicit and no longer needed
- Cleaner configuration

### 5. **Margin Management**

- **Before:** `\usepackage{vmargin}` with explicit `\setmarginsrb` command
- **After:** `\usepackage[margin=35mm]{geometry}`

**Why?**

- geometry package is the modern standard for page layout
- More flexible and easier to configure
- Better compatibility with other packages
- Cleaner syntax

### 6. **Encoding Configuration**

- **Before:** Explicit `\usepackage[utf8]{inputenc}` scattered in different files
- **After:** Implicit UTF-8 in LuaLaTeX (no declaration needed)

**Why?**

- LuaLaTeX assumes UTF-8 by default
- No need for explicit encoding declarations
- Reduces configuration complexity

### 7. **Build System**

- **Before:** `pdflatex --shell-escape thesis.tex`
- **After:** `lualatex --shell-escape thesis.tex`

**Why?**

- Aligns with the new engine
- Enables modern package features
- Better minted/syntax highlighting support

## Migration Benefits

✅ **Cleaner Code**: Removed 2-3 workaround packages  
✅ **Better Unicode Support**: Native UTF-8 handling  
✅ **Modern Vietnamese**: Proper language support via babel  
✅ **Flexible Font Sizing**: No more magnitude hacks  
✅ **Future-Proof**: Uses actively maintained packages  
✅ **Easier Maintenance**: Standard approaches instead of workarounds  

## Files Modified

1. **thesis.cls**
   - Updated header comments with version 2.0
   - Removed vieextsizes import
   - Removed vntex import
   - Added babel and fontspec
   - Replaced vmargin with geometry
   - Updated hyperref configuration
   - Removed pdftex from graphicx

2. **thesis.tex**
   - Updated header to reflect LuaLaTeX usage
   - Removed commented-out vntex import
   - Added comment about native UTF-8 support

3. **Makefile**
   - Changed from `pdflatex` to `lualatex`

## Building the Document

```bash
# Standard build
make pdf

# Clean up generated files
make clean

# Format code (if tex-fmt is installed)
make fmt
```

## System Requirements

- LuaLaTeX (TeX Live 2020 or later recommended)
- Modern TeX distribution (MiKTeX or TeX Live)
- Standard packages (babel, fontspec, geometry)

### Install on macOS
```bash
brew install texlive
# Or use MacTeX: https://www.tug.org/mactex/
```

### Install on Linux (Ubuntu/Debian)
```bash
sudo apt-get install texlive-full
```

### Install on Windows
- Download MiKTeX: https://miktex.org/
- Or TeX Live: https://www.tug.org/texlive/

## Backward Compatibility

The document structure and content remain unchanged. The modernization is purely technical:
- Same visual output (layout, typography)
- Same chapter/section structure
- Same bibliography format
- Same table and figure styling

## Notes

- The vieextsizes.sty and vntex packages are still in the repository for reference/history
- Future work could remove these deprecated files if they're no longer needed
- The template now uses Polyglossia for language support (better for LuaLaTeX than babel)
- Font selection can be customized via fontspec for different aesthetic requirements

## Why Polyglossia instead of Babel/XeLaTeX?

**Polyglossia vs Babel:**
- Polyglossia is specifically designed for LuaLaTeX (and XeLaTeX)
- Babel traditionally supports pdfLaTeX; modern babel has LuaLaTeX support but Polyglossia is more mature for extended languages
- Polyglossia has comprehensive Vietnamese language support including proper hyphenation and typography
- Better integration with modern Unicode systems

**Why LuaLaTeX instead of XeLaTeX:**

- LuaLaTeX is actively developed and is the recommended modern engine
- Slightly better compatibility with existing LaTeX ecosystem
- Better performance in many cases
- Both work well with fontspec and Polyglossia, so either is viable
- LuaLaTeX was chosen as it's the future direction of LaTeX development

## Future Improvements

Potential enhancements for future versions:

1. Add alternative font configurations (serif/sans-serif options)
2. Create separate templates for different document types
3. Add support for additional languages (Chinese, Thai, etc.)
4. Implement modern template options system
5. Consider migration to modern bibliography backends (biber)
5. Add dark mode support for PDF viewers

---

**Modernization Date**: December 2025  
**Branch**: feat/modernizeLaTex
