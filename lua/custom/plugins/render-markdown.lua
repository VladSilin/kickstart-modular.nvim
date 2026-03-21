return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown' },
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    enabled = false,
    render_modes = { 'n', 'c', 't' },
  },
  keys = {
    { '<leader>mr', '<cmd>RenderMarkdown toggle<cr>', desc = '[M]arkdown [R]ender toggle' },
  },
}
