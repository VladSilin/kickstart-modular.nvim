-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- See this post for icon meanings: https://www.reddit.com/r/neovim/comments/1ao5e01/an_unknown_block_icon_with_neotree_in_neovim/

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<C-n>', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  init = function()
    -- local auto_open_group = vim.api.nvim_create_augroup('vimrc', { clear = true })

    -- Open on enter when nvim started with no args
    -- vim.api.nvim_create_autocmd('VimEnter', {
    --   group = auto_open_group,
    --   callback = function()
    --     if vim.fn.argc() == 0 then
    --       vim.cmd 'Neotree reveal'
    --     end
    --   end,
    -- })

    -- Open on enter when nvim started with directory arg
    -- vim.api.nvim_create_autocmd('VimEnter', {
    --   group = auto_open_group,
    --   callback = function()
    --     if vim.fn.argc(-1) == 1 then
    --       local stat = vim.loop.fs_stat(vim.fn.argv(0))
    --       if stat and stat.type == 'directory' then
    --         vim.cmd.cd(vim.fn.argv(0))
    --         vim.cmd 'Neotree reveal'
    --       end
    --     end
    --   end,
    -- })

    -- TODO: Close all windows when exiting while on neo-tree window
    -- TODO: Figure out what the icons to the right mean
  end,
  opts = {
    close_if_last_window = true,
    filesystem = {
      window = {
        mappings = {
          ['<C-n>'] = 'close_window',
        },
      },
    },
  },
}
