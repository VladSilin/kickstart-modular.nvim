return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = 'zathura'
    -- Making zathura work on MacOS: https://github.com/lervag/vimtex/issues/2391
    vim.g.vimtex_view_zathura_use_synctex = 0

    -- From: https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt#L4671-L4713
    -- vim.o.foldmethod = 'expr'
    -- vim.o.foldexpr = 'vimtex#fold#level(v:lnum)'
    -- vim.o.foldtext = 'vimtex#fold#text()'
    -- I like to see at least the content of the sections upon opening
    -- vim.o.foldlevel = 2
  end,
}
