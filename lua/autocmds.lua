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

function DoWithDirArg(callback)
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

-- MDX files
-- vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
--   pattern = '*.mdx',
--   command = 'set filetype=mdx',
-- })
