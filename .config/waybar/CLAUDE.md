# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal [Waybar](https://github.com/Alexays/Waybar) configuration for a Hyprland (Wayland) desktop. It is not a software project with a build system — it's three config files that Waybar reads directly at runtime:

- [config.jsonc](config.jsonc) — module layout and behavior (JSONC: JSON with `//` comments allowed)
- [style.css](style.css) — GTK CSS styling for the bar and its modules
- [macchiato.css](macchiato.css) — Catppuccin Macchiato color palette, defined as GTK `@define-color` variables and `@import`-ed at the top of `style.css`

## Applying changes

Waybar hot-reloads `style.css` automatically on save. Changes to `config.jsonc` require restarting Waybar to take effect, e.g.:

```sh
killall waybar && waybar &
```

There is no linter or test suite. Validate `config.jsonc` by checking Waybar starts without errors (`waybar` run from a terminal will print parse errors to stdout/stderr), and validate `style.css` by checking the bar renders as expected after reload.

## Architecture notes

- **Module structure**: `config.jsonc` defines `modules-left`, `modules-center` (currently empty/commented out), and `modules-right`, each an ordered array of module names. Every named module then has its own top-level config block (format strings, icons, click actions, etc.) elsewhere in the same file — order in the arrays controls bar layout, the blocks control behavior.
- **Styling hooks**: Waybar exposes each module to CSS via a `#modulename` selector (e.g. `#clock`, `#battery`), and `.modules-left` / `.modules-center` / `.modules-right` for the containing groups. `style.css` uses these to color and space individual modules; state-based classes like `#battery.charging` or `#workspaces button.focused` style specific states.
- **Color palette indirection**: Never hardcode colors in `style.css` — reference the `@define-color` names from `macchiato.css` (e.g. `@rosewater`, `@base`, `@green`) so the whole theme stays swappable from one file. A few one-off colors (`#ffffff`, `#f53c3c`) are used directly for things like the blinking low-battery warning and hover underlines, outside the palette.
