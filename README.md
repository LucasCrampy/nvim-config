# Modernized Multi-Profile Neovim Configuration

This repository contains a highly modular, multi-profile Neovim configuration designed for software development, advanced mathematical/physics calculations, and academic writing. It features automated macOS light/dark theme tracking, a modern floating TUI, interactive Jupyter-style data science tools, custom template-based project generators, and a dedicated mathematics reference system.

---

## 📂 Directory Structure

The setup is fully modularized and structured for easy extensibility:

```text
~/.config/nvim/
├── init.lua                  # Bootstrap; loads configs, plugins, and keybinds
├── math_guide.md             # In-editor Mathematics & packages guide (accessible via :MathGuide)
├── lua/
│   ├── config/
│   │   ├── commands.lua      # Custom user commands (e.g., LazyGit)
│   │   ├── keys.lua          # Keymap bindings & Which-Key menu registrations
│   │   ├── lazy.lua          # lazy.nvim plugin bootstrapper
│   │   ├── profiles.lua      # Environment switching logic (Code, Math, Writing)
│   │   ├── settings.lua      # Core editor preferences (numbers, colors, netrw)
│   │   └── templates.lua     # TUI file/project templates generator (:NewFile)
│   └── plugins/
│       ├── catppuccin.lua    # Catppuccin theme family config
│       ├── conforming.lua    # Autoformatting setup
│       ├── dressing.lua      # TUI picker/input dialog overhauls
│       ├── gruvbox.lua       # Gruvbox theme family config
│       ├── lsp-mason.lua     # Native LSP config & server auto-installer
│       ├── lualine.lua       # Stylized statusline showing active profiles
│       ├── molten.lua        # Jupyter cell REPL for Python buffers
│       ├── noice.lua         # Centered command line inputs & sleek UI notifications
│       ├── rosepine.lua      # Rose Pine theme family config
│       ├── theme-manager.lua # Synchronous theme switching and state-saver
│       └── zenmode.lua       # Distraction-free writing layout
```

---

## 👤 Profile Environments

Toggle between profiles instantly using `<leader>pp` (or `:Profile`). The current active profile is displayed with a custom badge in your statusline (e.g., `💻 Code`, `🧮 Mathematics`, `✍️ Writing`).

### 1. 💻 Code Profile (Default)
Optimized for standard software development.
*   **LSP Integrations**: Active diagnostics and autocompletion for standard programming languages.
*   **Keymaps & Settings**: Clean keyboard workspace. Spell-check and writing specific bindings are hidden.

### 2. 🧮 Mathematics Profile
Tailored for math, physics, engineering analysis, and calculations.
*   **Interactive REPL (`molten-nvim`)**: Run Python inline via cell structures, evaluate matrices, equations, and view variables.
*   **Plotting Support**: Renders inline Matplotlib charts inside floating windows directly in your terminal.
*   **MATLAB Integration**: Active `matlab_ls` for editing `.m` scripts.
*   **LaTeX Autosnippets**: Automatically binds highly advanced calculus, differential equations, and physics macros in LaTeX math zones.

### 3. ✍️ Writing Profile
Designed for authoring academic reports, Markdown documents, and LaTeX articles.
*   **Distraction-Free UI (`zen-mode.nvim`)**: Centered text column, hidden line numbers, and statusline removal.
*   **Typography Settings**: Enabled spell check (`set spell`), soft wrapping, and visual line breaks.
*   **Dynamic Spell-Checking Keymaps**: Registers the `<leader>s` keymap group specifically for spell checks, next/previous error navigation, and corrections.
*   **LSP Grammar Server (`ltex-ls`)**: Provides offline, on-the-fly grammatical corrections inside LaTeX and Markdown buffers.

---

## 🚀 Template-Based File & Project Creation

Initialize new files and directories quickly using `<leader>n` (or `:NewFile`). The menu dynamically groups templates based on your active profile:

*   **Mathematics Templates** (Created inside `~/math-vim/`):
    *   **Python Math Script**: Generates `~/math-vim/[class-folder]/[name]-[date].py`. If no name is provided, falls back to `~/math-vim/[class-folder]/[date].py`. The script pre-populates with standard packages:
        ```python
        import numpy as np
        import sympy as sp
        import matplotlib.pyplot as plt
        from scipy import integrate, optimize, linalg
        # SymPy symbols (x, y, z, t) and function symbols (f, g, h) are pre-declared.
        ```
    *   **MATLAB Script**: Generates `~/math-vim/[class-folder]/[name]-[date].m` pre-populated with environments controls (`clear; clc; close all;`).
*   **Writing Templates** (Created inside `~/writing-vim/`):
    *   **Standalone LaTeX Document**: Generates `~/writing-vim/[project-folder]/[name]-[date].tex` with standard article preamble.
    *   **Full LaTeX Project (Multi-file)**: Creates a structured directory with `main.tex` (including BibTeX citation configurations), a `references.bib` bibliography file, and a `.gitignore` to keep compilation logs clean.
    *   **Academic Markdown Essay**: Generates `~/writing-vim/[project-folder]/[name]-[date].md` with PDF compilation metadata/YAML front matter.

*Any generated file is automatically loaded into the active editor buffer.*

---

## 📐 In-Editor Mathematics Reference Guide

Open the comprehensive mathematics snippet and python package guide directly in Neovim using:
*   **Command**: `:MathGuide`
*   **Keymap**: `<leader>mg`

It contains instructions, LaTeX triggers, and code recipes for **Linear Algebra**, **Differential Equations**, and **Calculus (1-4)** using SymPy, NumPy, and SciPy.

---

## 🎨 Theme Management & Modern UI

### System Dark/Light Tracking
The `theme-manager.lua` plugin monitors your OS's light/dark mode status on a 1-second interval:
*   **Dark Mode**: Applies Gruvbox Dark, Catppuccin Mocha, or Rose Pine Moon.
*   **Light Mode**: Applies Gruvbox Light, Catppuccin Latte, or Rose Pine Dawn.

### Interactive Theme Picker
Use `<leader>pt` (or `:Theme`) to select a theme family. Switching your family preserves your preferences across OS mode updates and restarts (saved in `~/.local/state/nvim/active_theme`).

### Floating TUI Overhaul (`noice.nvim` + `nvim-notify`)
Command line inputs appear as sleek, centered floating cards. Floating popups and notifications slide in smoothly in the corner. nvim-notify features a solid hex black background fallback (`#000000`) for seamless rendering.

---

## ⌨️ Zero-Memorization Keymap Quick Reference

Press `<Space>` and wait half a second. Which-Key will slide up showing all available prefixes. Keymaps are structured logically under single-character prefix groups:

### Global Core Actions
| Shortcut | Mode | Action | Profile Context |
|---|---|---|---|
| `<leader>w` | Normal | Write (Save) Active File | Global (instant, zero delay) |
| `<leader>q` | Normal | Quit Current Window | Global |
| `<leader>e` | Normal | Toggle File Explorer Sidebar | Global |
| `<leader>n` | Normal | Create New File/Project from Template | Global |
| `<leader>z` | Normal | Toggle Zen Mode (Distraction-free) | Global |

### `p` - [P]rofiles & Themes
| Shortcut | Mode | Action |
|---|---|---|
| `<leader>pp` | Normal | Switch Environment Profile (Code, Math, Writing) |
| `<leader>pt` | Normal | Switch Active Theme Family (Gruvbox, Catppuccin, Rose Pine) |

### `f` - [F]ind / Search (Telescope)
| Shortcut | Mode | Action |
|---|---|---|
| `<leader>ff` | Normal | Find Files (Fuzzy File Finder) |
| `<leader>fg` | Normal | Live Grep (Search text inside all project files) |
| `<leader>fb` | Normal | Browse Open Buffers |
| `<leader>fh` | Normal | Search Help Tags |

### `t` - [T]erminals & Git
| Shortcut | Mode | Action |
|---|---|---|
| `<leader>tt` | Normal | Toggle Floating Terminal |
| `<leader>tg` | Normal | Open LazyGit Terminal |

### `c` - [C]ode & LSP
| Shortcut | Mode | Action |
|---|---|---|
| `<leader>ca` | Normal | Open LSP Code Actions |
| `<leader>cd` | Normal | View Line Diagnostics |
| `<leader>cf` | Normal | Format Active Buffer |

### `m` - [M]athematics & REPL
| Shortcut | Mode | Action |
|---|---|---|
| `<leader>mi` | Normal | Initialize Molten Jupyter Kernel |
| `<leader>me` | Normal | Evaluate Line or Operator under Cursor |
| `<leader>me` | Visual | Evaluate Highlighted Code Selection |
| `<leader>mo` | Normal | Show REPL Cell Output Window |
| `<leader>mh` | Normal | Hide REPL Cell Output Window |
| `<leader>md` | Normal | Delete Current Cell Output |
| `<leader>mg` | Normal | Open Mathematics & Packages Reference Guide |

### `s` - [S]pellcheck & Writing (Writing Profile Only)
| Shortcut | Mode | Action |
|---|---|---|
| `<leader>st` | Normal | Toggle Spell Check |
| `<leader>sn` | Normal | Go to Next Spelling Error |
| `<leader>sp` | Normal | Go to Previous Spelling Error |
| `<leader>ss` | Normal | Show Correct Spelling Suggestions |
| `<leader>sa` | Normal | Auto-correct Last Word and return cursor |
