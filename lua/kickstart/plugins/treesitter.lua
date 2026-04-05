-- Neovim 0.12+ has built-in treesitter highlighting, indent, and folding.
-- nvim-treesitter's master branch (the old all-in-one plugin) is archived and
-- crashes on 0.12 because its query predicates conflict with the new runtime.
-- The main branch is a rewrite: parser/query installation only.
-- Everything else (highlighting, indent, folding) is now handled natively.
-- IMPORTANT: The main branch requires `tree-sitter-cli` to compile parsers.
-- Install it with: brew install tree-sitter-cli
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup {}

      -- Install parsers
      require('nvim-treesitter').install {
        'bash',
        'c',
        'cpp',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'css',
        'styled',
        'python',
        'javascript',
        'typescript',
        'kotlin',
        'java',
        'hcl',
        'terraform',
        'json',
        'astro',
      }

      -- Enable treesitter highlighting and auto-install missing parsers.
      -- Adapted from https://github.com/nvim-treesitter/nvim-treesitter/discussions/8546
      -- Caveat: on first run, if the install dir doesn't exist yet, a restart is needed
      -- for runtimepath to pick it up. After that, new parsers load immediately.
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end

          if vim.treesitter.language.add(lang) then
            vim.treesitter.start(args.buf)
          elseif vim.tbl_contains(require('nvim-treesitter').get_available(), lang) then
            require('nvim-treesitter').install({ lang }):await(function()
              if vim.treesitter.language.add(lang) then
                vim.treesitter.start(args.buf)
              end
            end)
          end
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
