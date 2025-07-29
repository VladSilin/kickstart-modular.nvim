return {
  'olimorris/codecompanion.nvim',
  enabled = true,
  opts = {
    strategies = {
      chat = {
        adapter = 'copilot',
      },
      inline = {
        adapter = 'copilot',
        -- accept_change = {
        --   modes = { n = 'ccy' },
        --   description = 'Accept the suggested change',
        -- },
        -- reject_change = {
        --   modes = { n = 'ccn' },
        --   description = 'Reject the suggested change',
        -- },
      },
    },
  },
  init = function()
    vim.keymap.set({ 'n', 'v' }, '<Leader>ccc', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.keymap.set('v', '<Leader>ccv', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })

    vim.keymap.set({ 'n', 'v' }, '<Leader>cci', '<cmd>CodeCompanion<cr>', { noremap = true, silent = true })

    vim.keymap.set({ 'n', 'v' }, '<Leader>cca', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd [[cab cc CodeCompanion]]
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
