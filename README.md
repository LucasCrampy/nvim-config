# Neovim Configuration

My configuration files for neovim. Hello future me :) 

## Core Features

This setup is built on `lazy.nvim` and is designed to be simple and discoverable.

* **LSP (Language Server Protocol):** Automatic language intelligence (diagnostics, definitions) provided by `nvim-lspconfig` and `mason.nvim`.
* **Autocompletion:** Context-aware completion via `nvim-cmp`.
* **Fuzzy Finding:** Fast modal search for files, text, and buffers with `telescope.nvim`.
* **Keymap Hints:** Discoverable keybinds with `which-key.nvim`.
* **LaTeX Support:** Full-featured LaTeX environment powered by `vimtex` (for compilation and viewing with Skim) and `LuaSnip`.
* **Custom Snippets:** A local collection of LaTeX snippets loaded from the `lua/snippets/` directory.
* **Git Integration:** A simple pop-up terminal for `lazygit`.
* **Auto-formatting:** Code is automatically formatted on save using `conform.nvim`.

---

## Keymappings

Keymaps are organized into logical groups that appear in the `which-key` pop-up menu.
The leader key is `Space`.

### General Keymaps

| Key | Mode | Description |
| --- | --- | --- |
| `<leader>w` | Normal | `[W]rite File` (Save) |
| `<leader>q` | Normal | `[Q]uit Window` |
| `<leader>e` | Normal | `[E]xplorer` (Toggle File Tree) |

### Find (Telescope)

*Prefix: `<leader>f`*

| Key | Mode | Description |
| --- | --- | --- |
| `ff` | Normal | `[F]ind [F]iles` |
| `fg` | Normal | `[F]ind [G]rep` (Search for text in files) |
| `fb` | Normal | `[F]ind [B]uffers` (Switch between open files) |
| `fh` | Normal | `[F]ind [H]elp` (Search help tags) |

### Terminal / Toggles

*Prefix: `<leader>t`*

| Key | Mode | Description |
| --- | --- | --- |
| `tt` | Normal | `[T]oggle [T]erminal` (Floating terminal) |
| `tg` | Normal | `[T]oggle [G]it` (Opens LazyGit) |

### Spell Check

*Prefix: `<leader>s`*

| Key | Mode | Description |
| --- | --- | --- |
| `st` | Normal | `[T]oggle Spell Check` (On/Off) |
| `sn` | Normal | Jump to `[N]ext Error` |
| `sp` | Normal | Jump to `[P]revious Error` |
| `ss` | Normal | Show `[S]uggestions` for word under cursor |
| `sa` | Normal | `[A]uto-correct` the previous error |

### Code Actions

*Prefix: `<leader>c`*

| Key | Mode | Description |
| --- | --- | --- |
| `ca` | Normal | `[C]ode [A]ction` (Context menu from LSP) |

### nvim-cmp (Autocompletion)

| Key | Mode | Description |
| --- | --- | --- |
| `<C-Space>` | Insert | Trigger completion menu |
| `<C-b>` | Insert | Scroll documentation up |
| `<C-f>` | Insert | Scroll documentation down |
| `<C-e>` | Insert | Abort completion |
| `<CR>` | Insert | Confirm completion |

### LuaSnip (Snippets)

| Key | Mode | Description |
| --- | --- | --- |
| `jk` | Insert/Select | Expand snippet or jump to next node |
| `wq` | Insert/Select | Jump to previous node |
| `<C-j>` | Insert/Select | Go to next choice in a snippet |
| `<C-k>` | Insert/Select | Go to previous choice in a snippet |
