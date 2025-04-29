-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- *** VIM CARRYOVER SETTINGS ***

vim.keymap.set('n', 'gb', ':ls<cr>:b<space>', { desc = 'List buffers and start typing to open' })
vim.keymap.set('n', 'gdb', ':ls<cr>:bd<space>', { desc = 'List buffers and start typing to delete' })
vim.keymap.set('n', 'gvb', ':ls<cr>:vert sb<space>', { desc = 'List buffers and start typing to open in vertical split' })

-- Delete buffer without touching window split
-- (May not work)
if vim.fn.exists ':Bd' == 0 then
  vim.api.nvim_create_user_command('Bd', 'bp|bd #', {})
end

-- Copy to clipboard easily
vim.api.nvim_set_keymap('n', '<Leader>y', '"*y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>p', '"*p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>Y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>P', '"+p', { noremap = true, silent = true })

-- Terminal Command Setup
local term_buf = nil
local term_win = nil

function TermToggle(height)
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.cmd 'hide'
  else
    vim.cmd 'botright new'
    local new_buf = vim.api.nvim_get_current_buf()
    vim.cmd('resize ' .. height)
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
      -- go to terminal buffer
      vim.cmd('buffer ' .. term_buf)
      -- cleanup new buffer
      vim.cmd('bd ' .. new_buf)
    else
      vim.cmd 'terminal'
      term_buf = vim.api.nvim_get_current_buf()
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.wo.signcolumn = 'no'
    end
    vim.cmd 'startinsert!'
    term_win = vim.api.nvim_get_current_win()
  end
end

-- Terminal Toggle Keymaps
vim.keymap.set('n', '<Leader>t', ':lua TermToggle(10)<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<Leader>t', '<Esc>:lua TermToggle(10)<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<Leader>t', '<C-\\><C-n>:lua TermToggle(10)<CR>', { noremap = true, silent = true })

--
--
-- *** NEOVIM SETTINGS ***

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Oil
vim.keymap.set('n', '-', '<cmd>Oil --float<CR>', { desc = 'Open parent directory in oil' })

-- vim: ts=2 sts=2 sw=2 et
