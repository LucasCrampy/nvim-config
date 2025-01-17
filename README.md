# Neovim Keymaps Documentation

This document provides an overview of common keymaps, including custom and default mappings.

## General Keymaps
| Key Combination     | Mode  | Description                         |
|---------------------|-------|-------------------------------------|
| `<leader>e`         | Normal| Toggle the file explorer (`NvimTree`)|
| `<leader>w`         | Normal| Save the current file               |
| `<leader>q`         | Normal| Quit Neovim                         |

## Telescope Keymaps
| Key Combination     | Mode  | Description                         |
|---------------------|-------|-------------------------------------|
| `<leader>ff`        | Normal| Find files in the project           |
| `<leader>fg`        | Normal| Search text in files (live grep)    |
| `<leader>fb`        | Normal| Switch between open buffers         |
| `<leader>fh`        | Normal| Access Neovim help tags             |

## Tab Management
| Key Combination     | Mode  | Description                         |
|---------------------|-------|-------------------------------------|
| `<leader>tn`        | Normal| Open a new tab                      |
| `<leader>tc`        | Normal| Close the current tab               |
| `<leader>to`        | Normal| Switch to the next tab              |

## Terminal Management
| Key Combination     | Mode  | Description                         |
|---------------------|-------|-------------------------------------|
| `<leader>t`         | Normal| Open the terminal (`ToggleTerm`) |
| `<C-\>`         | Terminal| Close the terminal (`ToggleTerm`) |

## Java Compilation
| Key Combination     | Mode  | Description                         |
|---------------------|-------|-------------------------------------|
| `<leader>tr`        | Normal| Compile and run Java code           |

## nvim-cmp (Auto Completion)
| Key Combination     | Mode  | Description                         |
|---------------------|-------|-------------------------------------|
| `<C-b>`             | Insert| Scroll documentation up            |
| `<C-f>`             | Insert| Scroll documentation down          |
| `<C-Space>`         | Insert| Trigger completion menu            |
| `<C-e>`             | Insert| Abort completion                   |
| `<CR>`              | Insert| Confirm completion                 |

## Default Keymaps
| Key Combination     | Mode  | Description                         |
|---------------------|-------|-------------------------------------|
| `:w`                | Normal| Save the file                      |
| `:q`                | Normal| Quit Neovim                        |
| `:tabnew`           | Normal| Open a new tab                     |
| `:tabclose`         | Normal| Close the current tab              |
| `:tabnext`          | Normal| Go to the next tab                 |

---

### Notes
- `<leader>` is set to your preferred key (e.g., `\` or `space`).
- Ensure all plugins referenced by the keybindings are installed and configured properly.

