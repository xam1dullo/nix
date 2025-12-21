# AstroNvim & tmux Shortcuts Cheat Sheet

## 🚀 Quick Start

### Your Setup
- **AstroNvim Leader**: `Space` (press Space to see all commands)
- **tmux Prefix**: `Option+S` (then press another key)
- **Both support**: Mouse navigation, Vim keybindings

### Most Used Commands (Memorize These!)

**AstroNvim:**
- `Space + ff` → Find files
- `Space + fw` → Find word (grep)
- `Space + e` → File explorer
- `Space + gg` → Git (lazygit)
- `gd` → Go to definition
- `K` → Hover docs
- `]b` / `[b` → Next/Previous buffer

**tmux:**
- `Option+S + h/j/k/l` → Navigate panes (Vim style!)
- `Option+S + |` → Split horizontal
- `Option+S + -` → Split vertical
- `Option+S + r` → Reload config
- `Option+S + ?` → Show all keybindings

---

## AstroNvim Keybindings

### Leader Key
- **Leader**: `Space` (default)

### Essential Navigation
| Key | Action | Mode |
|-----|--------|------|
| `h,j,k,l` | Move left/down/up/right | Normal |
| `gg` | Go to first line | Normal |
| `G` | Go to last line | Normal |
| `0` | Start of line | Normal |
| `$` | End of line | Normal |
| `w` | Next word | Normal |
| `b` | Previous word | Normal |
| `%` | Jump to matching bracket | Normal |

### Buffer Management (from astrocore.lua)
| Key | Action |
|-----|--------|
| `]b` | Next buffer |
| `[b` | Previous buffer |
| `<Leader>bd` | Close buffer from tabline |
| `<Leader>c` | Close buffer |
| `<Leader>C` | Force close buffer |

### Window Management
| Key | Action |
|-----|--------|
| `<C-w>v` | Split window vertically |
| `<C-w>s` | Split window horizontally |
| `<C-w>h/j/k/l` | Navigate windows |
| `<C-w>q` | Close window |
| `<C-w>=` | Equal window sizes |

### File Explorer (Neo-tree)
| Key | Action |
|-----|--------|
| `<Leader>e` | Toggle file explorer |
| `<Leader>o` | Focus file explorer |
| `a` | Add file/folder |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy |
| `x` | Cut |
| `p` | Paste |

### Telescope (Fuzzy Finder)
| Key | Action |
|-----|--------|
| `<Leader>ff` | Find files |
| `<Leader>fw` | Find word (grep) |
| `<Leader>fb` | Find buffers |
| `<Leader>fh` | Find help |
| `<Leader>fo` | Find oldfiles |
| `<Leader>fc` | Find commands |
| `<Leader>fm` | Find marks |
| `<Leader>fr` | Find registers |
| `<Leader>fk` | Find keymaps |

### LSP Features (from astrolsp.lua)
| Key | Action |
|-----|--------|
| `gD` | Go to declaration |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `gI` | Go to implementation |
| `gr` | Find references |
| `gl` | Show diagnostics |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<Leader>la` | Code actions |
| `<Leader>lr` | Rename symbol |
| `<Leader>lf` | Format code |
| `<Leader>li` | LSP info |
| `<Leader>uY` | Toggle semantic tokens |

### Git Integration
| Key | Action |
|-----|--------|
| `<Leader>gg` | Open lazygit |
| `<Leader>gt` | Open terminal git |
| `]g` | Next git hunk |
| `[g` | Previous git hunk |
| `<Leader>gl` | Git blame line |
| `<Leader>gp` | Preview git hunk |
| `<Leader>gh` | Reset git hunk |
| `<Leader>gs` | Stage git hunk |
| `<Leader>gS` | Stage buffer |
| `<Leader>gu` | Unstage git hunk |
| `<Leader>gd` | Diff this |

### Terminal
| Key | Action |
|-----|--------|
| `<Leader>tf` | Toggle floating terminal |
| `<Leader>th` | Toggle horizontal terminal |
| `<Leader>tv` | Toggle vertical terminal |
| `<Leader>tl` | Toggle lazygit |
| `<Leader>tn` | Toggle node |
| `<Leader>tp` | Toggle python |
| `<F7>` | Toggle terminal |
| `<C-'>` | Toggle terminal |

### Code Completion (nvim-cmp)
| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<C-n>` | Next completion item |
| `<C-p>` | Previous completion item |
| `<CR>` | Confirm completion |
| `<Tab>` | Next item/snippet jump |
| `<S-Tab>` | Previous item/snippet jump |
| `<C-e>` | Cancel completion |
| `<C-d>` | Scroll docs down |
| `<C-f>` | Scroll docs up |

### Session Management
| Key | Action |
|-----|--------|
| `<Leader>Ss` | Save session |
| `<Leader>Sl` | Load session |
| `<Leader>Sd` | Delete session |
| `<Leader>Sf` | Search sessions |
| `<Leader>S.` | Load current directory session |

### UI Toggles
| Key | Action |
|-----|--------|
| `<Leader>ua` | Toggle autopairs |
| `<Leader>ub` | Toggle background |
| `<Leader>uc` | Toggle autocompletion |
| `<Leader>uC` | Toggle color column |
| `<Leader>ud` | Toggle diagnostics |
| `<Leader>ug` | Toggle signcolumn |
| `<Leader>uG` | Toggle global statusline |
| `<Leader>ui` | Toggle indent guides |
| `<Leader>ul` | Toggle statusline |
| `<Leader>uL` | Toggle codelens |
| `<Leader>un` | Toggle line numbers |
| `<Leader>uN` | Toggle notifications |
| `<Leader>up` | Toggle paste mode |
| `<Leader>ur` | Toggle relative numbers |
| `<Leader>us` | Toggle spell check |
| `<Leader>uS` | Toggle conceal |
| `<Leader>ut` | Toggle tabline |
| `<Leader>uu` | Toggle URL highlight |
| `<Leader>uw` | Toggle wrap |
| `<Leader>uy` | Toggle syntax |

### Debugging (DAP)
| Key | Action |
|-----|--------|
| `<Leader>db` | Toggle breakpoint |
| `<Leader>dB` | Conditional breakpoint |
| `<Leader>dc` | Continue |
| `<Leader>dC` | Run to cursor |
| `<Leader>dg` | Get session |
| `<Leader>di` | Step into |
| `<Leader>do` | Step over |
| `<Leader>dO` | Step out |
| `<Leader>dp` | Pause |
| `<Leader>dr` | Toggle REPL |
| `<Leader>ds` | Start session |
| `<Leader>dt` | Terminate |
| `<Leader>dw` | Widgets |

### Package Manager
| Key | Action |
|-----|--------|
| `<Leader>pm` | Open Mason |
| `<Leader>pM` | Mason update |
| `<Leader>pa` | Update plugins |
| `<Leader>pA` | Update all (plugins + Mason) |
| `<Leader>pi` | Install plugins |
| `<Leader>ps` | Plugin status |
| `<Leader>pS` | Plugin sync |
| `<Leader>pu` | Update plugins |
| `<Leader>pU` | Update plugin (unstable) |

## tmux Shortcuts (Your Configuration)

### Prefix Key
- **Prefix**: `Option+S` (Meta-s / M-s) - Your custom prefix!

### Session Management
| Key | Action |
|-----|--------|
| `prefix + s` | List sessions |
| `prefix + $` | Rename session |
| `prefix + d` | Detach from session |
| `prefix + (` | Previous session |
| `prefix + )` | Next session |

### Window Management
| Key | Action |
|-----|--------|
| `prefix + c` | Create window |
| `prefix + w` | List windows |
| `prefix + n` | Next window |
| `prefix + p` | Previous window |
| `prefix + 0-9` | Switch to window number |
| `prefix + ,` | Rename window |
| `prefix + &` | Kill window |

### Pane Management (Vim-like!)
| Key | Action |
|-----|--------|
| `prefix + \|` | Split horizontally (opens in current dir) |
| `prefix + -` | Split vertically (opens in current dir) |
| `prefix + h/j/k/l` | Navigate panes (Vim style!) |
| `prefix + H/J/K/L` | Resize panes (hold for repeat) |
| `prefix + x` | Kill pane |
| `prefix + z` | Zoom pane |
| `prefix + space` | Toggle layouts |
| `prefix + {` | Move pane left |
| `prefix + }` | Move pane right |
| `prefix + !` | Convert pane to window |

### Copy Mode (Vi mode enabled!)
| Key | Action |
|-----|--------|
| `prefix + [` | Enter copy mode |
| `q` | Exit copy mode |
| `v` | Start visual selection |
| `y` | Copy selection and exit |
| `r` | Toggle rectangle selection |
| `prefix + ]` | Paste buffer |

### Window Navigation
| Key | Action |
|-----|--------|
| `prefix + C-h` | Previous window |
| `prefix + C-l` | Next window |
| `prefix + r` | Reload config |

### Other Commands
| Key | Action |
|-----|--------|
| `prefix + ?` | List key bindings |
| `prefix + :` | Command prompt |
| `prefix + t` | Show time |
| `prefix + i` | Display info |

## Quick tmux Commands

```bash
# Sessions
tmux new -s name          # New session
tmux ls                    # List sessions
tmux attach -t name        # Attach to session
tmux kill-session -t name  # Kill session

# Windows
tmux new-window -n name    # New window
tmux select-window -t num  # Select window

# Panes
tmux split-window -h       # Split horizontal
tmux split-window -v       # Split vertical
tmux kill-pane            # Kill pane
```

## Quick Reference - Most Used Commands

### AstroNvim Daily Workflow
```
Space + ff    → Find files (Telescope)
Space + fw    → Find word (grep)
Space + e     → Toggle file explorer
Space + gg    → Open lazygit
Space + tf    → Floating terminal
Space + c     → Close buffer
]b / [b       → Next/Previous buffer
gd            → Go to definition
K             → Hover documentation
Space + lf    → Format code
```

### tmux Daily Workflow
```
Option+S + h/j/k/l  → Navigate panes
Option+S + |        → Split horizontal
Option+S + -        → Split vertical
Option+S + r        → Reload config
Option+S + [        → Copy mode (then v to select, y to copy)
Option+S + C-h/l    → Switch windows
```

## Tips
- **AstroNvim**: Press `<Leader>` (Space) and wait to see all available keymaps (which-key)
- **tmux**: Press `Option+S + ?` to see all keybindings
- **Copy Mode**: In tmux, use `v` to start selection, `y` to copy (vi mode enabled)
- **Mouse**: Both AstroNvim and tmux support mouse - click to navigate!
- **Quick Help**: 
  - AstroNvim: `:Telescope keymaps` or press Space and wait
  - tmux: `Option+S + ?` for keybindings help