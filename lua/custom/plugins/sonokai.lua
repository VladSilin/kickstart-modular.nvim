return {
  'sainnhe/sonokai',
  lazy = false,
  enabled = true,
  priority = 1000,
  config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    vim.g.sonokai_enable_italic = true
    vim.g.sonokai_style = 'atlantis'
    vim.cmd.colorscheme 'sonokai'
  end,
}
