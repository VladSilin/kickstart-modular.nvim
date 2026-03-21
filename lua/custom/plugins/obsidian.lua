return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  event = {
    'BufReadPre ' .. vim.fn.expand '~' .. '/Library/Mobile Documents/iCloud~md~obsidian/Documents/ObsidianVault/**/*.md',
    'BufNewFile ' .. vim.fn.expand '~' .. '/Library/Mobile Documents/iCloud~md~obsidian/Documents/ObsidianVault/**/*.md',
  },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<leader>mo',
      function()
        local line = vim.api.nvim_get_current_line()
        local img = line:match '!%[%[(.-)%]%]'
        if not img then
          vim.notify('No ![[image]] on this line', vim.log.levels.WARN)
          return
        end
        local vault = vim.fn.expand '~' .. '/Library/Mobile Documents/iCloud~md~obsidian/Documents/ObsidianVault'
        local path = vault .. '/Assets/' .. img
        if vim.fn.filereadable(path) == 1 then
          vim.fn.jobstart({ 'open', path }, { detach = true })
        else
          vim.notify('Image not found: ' .. img, vim.log.levels.ERROR)
        end
      end,
      desc = 'Open image under cursor in Preview',
    },
    {
      '<leader>mp',
      '<cmd>ObsidianPasteImg<cr>',
      desc = 'Paste image from clipboard',
    },
  },
  config = function(_, opts)
    require('obsidian').setup(opts)

    local ns = vim.api.nvim_create_namespace 'obsidian_image_hint'
    vim.api.nvim_create_autocmd('CursorMoved', {
      pattern = '*.md',
      callback = function()
        vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
        local line = vim.api.nvim_get_current_line()
        if line:match '!%[%[(.-)%.png%]%]' or line:match '!%[%[(.-)%.jpg%]%]' or line:match '!%[%[(.-)%.jpeg%]%]' or line:match '!%[%[(.-)%.webp%]%]' or line:match '!%[%[(.-)%.pdf%]%]' then
          local row = vim.api.nvim_win_get_cursor(0)[1] - 1
          vim.api.nvim_buf_set_extmark(0, ns, row, 0, {
            virt_text = { { '  <leader>mo to open', 'Comment' } },
            virt_text_pos = 'eol',
          })
        end
      end,
    })
  end,
  opts = {
    disable_frontmatter = true,
    ui = {
      enable = false,
    },

    templates = {
      folder = 'Templates',
      date_format = '%Y-%m-%d-%a',
      time_format = '%H:%M',
    },
    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },

    attachments = {
      img_folder = 'Assets',
    },

    workspaces = {
      {
        name = 'ObsidianVault',
        path = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/ObsidianVault/',
      },
    },
  },
}
