# AstroNvim & tmux Shortcuts Cheat Sheet

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

## tmux Shortcuts (Default)

### Prefix Key
- **Prefix**: `Ctrl+b` (default)

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

### Pane Management
| Key | Action |
|-----|--------|
| `prefix + %` | Split horizontally |
| `prefix + "` | Split vertically |
| `prefix + o` | Switch pane |
| `prefix + arrow` | Navigate panes |
| `prefix + q` | Show pane numbers |
| `prefix + x` | Kill pane |
| `prefix + z` | Zoom pane |
| `prefix + space` | Toggle layouts |
| `prefix + {` | Move pane left |
| `prefix + }` | Move pane right |
| `prefix + !` | Convert pane to window |

### Copy Mode
| Key | Action |
|-----|--------|
| `prefix + [` | Enter copy mode |
| `q` | Exit copy mode |
| `Space` | Start selection |
| `Enter` | Copy selection |
| `prefix + ]` | Paste buffer |

### Resize Panes
| Key | Action |
|-----|--------|
| `prefix + Ctrl+arrow` | Resize pane |
| `prefix + Alt+1` | Even horizontal |
| `prefix + Alt+2` | Even vertical |
| `prefix + Alt+3` | Main horizontal |
| `prefix + Alt+4` | Main vertical |
| `prefix + Alt+5` | Tiled |

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

## Custom tmux Config Suggestion

Add to `modules/home-manager/tmux.nix` for vim-like navigation:
```nix
extraConfig = ''
  # Vim-like pane navigation
  bind h select-pane -L
  bind j select-pane -D
  bind k select-pane -U
  bind l select-pane -R

  # Better splits
  bind | split-window -h
  bind - split-window -v
'';
```

## Tips
- **AstroNvim**: Use `<Leader>` (Space) for most commands
- **Which-key**: Press `<Leader>` and wait to see available keymaps
- **tmux**: Use `prefix + ?` to see all keybindings
- **Copy Mode**: In tmux, use vi mode with `setw -g mode-keys vi`