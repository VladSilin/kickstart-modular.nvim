# Neovim Config

## Adding Dashboard Hints

Hints live in `lua/custom/plugins/alpha-nvim.lua` in the `hints` table. A random subset is shown on each launch.

To add a hint, append a string to the `hints` list following this format:

```
'<icon> <Category>      <key>  description  • <key>  description'
```

Rules:
- Each hint MUST start with a Nerd Font unicode icon (e.g. 󰋼, 󰡍, 󰆼, 󰁨, 󰊢)
- Use consistent spacing: icon, then category name padded to ~16 chars, then key/description pairs separated by ` • `
- Keep hints to a single line
