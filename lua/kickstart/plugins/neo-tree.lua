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
    { '<C-n>', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
    { '<C-s>', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  init = function()
    -- Open on enter when nvim started with directory arg or no arg
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        -- No arg
        if vim.fn.argc() == 0 then
          vim.cmd 'Neotree show'
        elseif vim.fn.argc() == 1 then
          -- No arg
          local stat = vim.uv.fs_stat(vim.fn.argv(0))
          if stat and stat.type == 'directory' then
            vim.cmd('Neotree show ' .. vim.fn.argv(0))
          end
        end
      end,
    })
  end,
  opts = {
    close_if_last_window = true,
    filesystem = {
      window = {
        mappings = {
          ['/'] = 'noop',
          ['?'] = 'noop',
          -- ['<C-n>'] = 'close_window',
        },
      },
    },
  },
}
