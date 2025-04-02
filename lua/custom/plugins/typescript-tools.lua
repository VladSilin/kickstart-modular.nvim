-- NOTE: This REQUIRES
--   npm install -g typescript
-- to work
return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      settings = {
        -- NOTE: This is required for styled-components support and also requires
        --   npm i -g @styled/typescript-styled-plugin typescript-styled-plugin
        -- (see also treesitter.lua for syntax highlighting support)
        tsserver_plugins = {
          -- for TypeScript v4.9+
          '@styled/typescript-styled-plugin',
          -- or for older TypeScript versions
          -- "typescript-styled-plugin",
        },
      },
    },
  },
}
