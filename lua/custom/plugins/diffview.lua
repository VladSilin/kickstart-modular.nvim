return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview Open' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Diffview File History' },
    { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'Diffview Branch History' },
  },
  opts = {
    keymaps = {
      view = { { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } } },
      file_panel = { { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } } },
      file_history_panel = { { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } } },
    },
  },
}
