-- kickstart/plugins/edge: Another Neovim theme, offering a clean and minimalistic color scheme designed to reduce eye strain.
--
return {
  {
    'sainnhe/edge',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.edge_enable_italic = true
      vim.g.edge_style = 'aura'

      -- Set the colorscheme
      vim.cmd.colorscheme 'edge'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
