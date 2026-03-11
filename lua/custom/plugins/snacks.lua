return {
  'folke/snacks.nvim',
  keys = {
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'LazyGit' },
    { '<leader>gl', function() Snacks.lazygit.log() end, desc = 'LazyGit Log (cwd)' },
    { '<leader>gf', function() Snacks.lazygit.log_file() end, desc = 'LazyGit File Log' },
  },
  ---@type snacks.Config
  opts = {
    input = {},
    lazygit = {},
  },
}
