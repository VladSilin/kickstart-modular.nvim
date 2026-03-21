-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Save when focus lost
vim.api.nvim_create_augroup('AutoSaveOnFocusLost', { clear = true })
vim.api.nvim_create_autocmd('FocusLost', {
  group = 'AutoSaveOnFocusLost',
  command = 'silent! wa',
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local function DoWithDirArg(callback)
  local num_args = vim.fn.argc()

  if num_args < 1 then
    return
  end

  local dir = vim.fn.argv(0)
  -- Convert string[] to a single string if necessary
  if type(dir) == 'table' then
    dir = table.concat(dir, ' ')
  end

  local stat = vim.uv.fs_stat(dir)
  if stat and stat.type == 'directory' then
    callback(dir)
  end
end

vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Change working directory when running nvim with a directory argument',
  group = vim.api.nvim_create_augroup('ChangeDirOnEnterWithDirArg', { clear = true }),
  callback = function()
    DoWithDirArg(function(dir)
      vim.cmd('cd ' .. dir)
    end)
  end,
})

-- Enable line numbers
vim.opt.number = true

-- Create an augroup for toggling relative numbers
vim.api.nvim_create_augroup('numbertoggle', { clear = true })

-- Toggle relative numbers on specific events
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
  group = 'numbertoggle',
  callback = function()
    if vim.opt.number and vim.fn.mode() ~= 'i' and vim.bo.buftype ~= 'nofile' and vim.bo.buftype ~= 'nowrite' then
      vim.opt.relativenumber = true
    end
  end,
})

-- Disable relative numbers on other specific events
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  group = 'numbertoggle',
  callback = function()
    if vim.opt.number and vim.bo.buftype ~= 'nofile' and vim.bo.buftype ~= 'nowrite' then
      vim.opt.relativenumber = false
    end
  end,
})

-- Disable line numbers, gutters, etc. in scratch buffers
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    if vim.bo.buftype == 'nofile' then
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.wo.signcolumn = 'no'
    end
  end,
})

-- Enable auto-reload of files changed outside Neovim
vim.opt.autoread = true

-- Auto-reload files when focusing or entering a buffer
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  pattern = '*',
  command = 'checktime',
})

-- MDX files
-- vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
--   pattern = '*.mdx',
--   command = 'set filetype=mdx',
-- })

-- Show "gx to open" hint on lines with markdown links
local link_hint_ns = vim.api.nvim_create_namespace 'link_hint'
vim.api.nvim_create_autocmd('CursorMoved', {
  callback = function()
    vim.api.nvim_buf_clear_namespace(0, link_hint_ns, 0, -1)
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1
    local show = false
    -- Check if cursor is inside a markdown link [text](url)
    local start = 1
    while true do
      local s, e = line:find('%[.-%]%(https?://.-%)', start)
      if not s then break end
      if col >= s and col <= e then
        show = true
        break
      end
      start = e + 1
    end
    -- Check if cursor is on a bare URL
    if not show then
      start = 1
      while true do
        local s, e = line:find('https?://[%w_.~!*\'();:@&=+$,/?#%%%-]+', start)
        if not s then break end
        if col >= s and col <= e then
          show = true
          break
        end
        start = e + 1
      end
    end
    if show then
      local row = vim.api.nvim_win_get_cursor(0)[1] - 1
      vim.api.nvim_buf_set_extmark(0, link_hint_ns, row, 0, {
        virt_text = { { '  gx to open link', 'Comment' } },
        virt_text_pos = 'eol',
      })
    end
  end,
})

return { DoWithDirArg = DoWithDirArg }
