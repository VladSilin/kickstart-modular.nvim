-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- *** VIM CARRYOVER SETTINGS ***

-- allow backspacing over everything in insert mode
vim.opt.backspace = { 'indent', 'eol', 'start' }

vim.opt.history = 50 -- keep 50 lines of command line history
vim.opt.ruler = true -- show the cursor position all the time
vim.opt.incsearch = true -- do incremental searching

-- Tab settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Set advanced autocomplete
vim.opt.wildmenu = true

-- *DNW* Do not highlight searches
-- vim.opt.nohlsearch = true

-- *DNW* Show number of matches in search
-- vim.opt.shortmess = 'S'

-- Autosave buffers
vim.opt.autowriteall = true

-- Keep buffer undo history
vim.opt.hidden = true

-- Swap File Location Setup
vim.opt.swapfile = true
vim.opt.directory = os.getenv 'HOME' .. '/tmp'

-- Prevent lag when switching between modes
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 5

-- netrw (File Tree Browser) Config
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 20

--
--
--
-- *** NEOVIM SETTINGS ***

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- vim.opt.listchars = { tab = '- ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Enable true colours for edge colorscheme
vim.opt.termguicolors = true

-- Disable netrw when opening a directory
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- NOTE: Disabled in favour of Treesitter folding below
-- Enable Markdown folding
-- vim.g.markdown_folding = 1
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'markdown',
--   callback = function()
--     vim.opt_local.foldlevel = 99
--   end,
-- })

-- Enable Treesitter folding
-- See https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
--vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'
-- The first line of the fold will be syntax highlighted, rather than all one colour
vim.opt.foldtext = ''
vim.opt.foldcolumn = '0'

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.opt.foldnestmax = 4

-- Set to 2 due to
--   Optional, configure additional syntax highlighting / extmarks.
--   This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
-- In https://github.com/epwalsh/obsidian.nvim, but causes strange ``` hiding behaviour
vim.opt.conceallevel = 2

-- vim: ts=2 sts=2 sw=2 et
