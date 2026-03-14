return {
  enabled = true,
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'stevearc/oil.nvim',
  },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    dashboard.leader = vim.g.mapleader or '\\'

    dashboard.section.header.val = {
      [[                                       ]],
      [[    ▄   ▄███▄   ████▄     ▄   ▄█ █▀▄▀█ ]],
      [[     █  █▀   ▀  █   █      █  ██ █ █ █ ]],
      [[ ██   █ ██▄▄    █   █ █     █ ██ █ ▄ █ ]],
      [[ █ █  █ █▄   ▄▀ ▀████  █    █ ▐█ █   █ ]],
      [[ █  █ █ ▀███▀           █  █   ▐    █  ]],
      [[ █   ██                  █▐        ▀   ]],
      [[                         ▐             ]],
      [[                                       ]],
    }
    local cursor_position = 2
    local search_files_button = dashboard.button(dashboard.leader .. 'sf', ' Search Files')
    search_files_button.opts.cursor = cursor_position
    local search_grep_button = dashboard.button(dashboard.leader .. 'sg', '󱈆 Search by Grep')
    search_grep_button.opts.cursor = cursor_position
    local configure_nvim_button = dashboard.button(dashboard.leader .. 'sn', ' Configure Neovim')
    configure_nvim_button.opts.cursor = cursor_position
    local browse_dir_button = dashboard.button('-', ' Browse Directory', '<cmd>Oil --float<CR>')
    browse_dir_button.opts.cursor = cursor_position
    local edit_file_button = dashboard.button('e', ' New File', '<cmd>ene <CR>')
    edit_file_button.opts.cursor = cursor_position
    local quit_button = dashboard.button('q', '󰩈 Quit', '<cmd>qa<CR>')
    quit_button.opts.cursor = cursor_position

    dashboard.section.buttons.val = {
      search_files_button,
      search_grep_button,
      configure_nvim_button,
      browse_dir_button,
      edit_file_button,
      quit_button,
    }

    local hints = require 'custom.hints'

    -- Pick a random subset each launch
    local num_hints = 3
    math.randomseed(os.time())
    local pool = { unpack(hints) }
    local selected = {}
    for _ = 1, math.min(num_hints, #pool) do
      local i = math.random(#pool)
      table.insert(selected, table.remove(pool, i))
    end

    -- Find the longest hint to center the header within the block
    local max_width = 0
    for _, hint in ipairs(selected) do
      max_width = math.max(max_width, vim.fn.strdisplaywidth(hint))
    end

    local header_text = '─── Remember ───'
    local header_width = vim.fn.strdisplaywidth(header_text)
    local pad = math.floor((max_width - header_width) / 2)
    local centered_header = string.rep(' ', math.max(pad, 0)) .. header_text

    local hint_lines = { centered_header, '' }
    for _, hint in ipairs(selected) do
      table.insert(hint_lines, hint)
    end

    dashboard.section.hints = {
      type = 'text',
      val = hint_lines,
      opts = {
        position = 'center',
        hl = 'Comment',
      },
    }

    dashboard.opts.layout = {
      { type = 'padding', val = 2 },
      dashboard.section.header,
      { type = 'padding', val = 2 },
      dashboard.section.buttons,
      { type = 'padding', val = 2 },
      dashboard.section.hints,
      { type = 'padding', val = 1 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)
  end,
  init = function()
    vim.api.nvim_create_autocmd('VimEnter', {
      desc = 'Open Alpha startup screen when nvim runs with directory argument',
      group = vim.api.nvim_create_augroup('OpenAlphaOnEnterWithDirArg', { clear = true }),
      callback = function()
        require('autocmds').DoWithDirArg(function()
          vim.cmd 'Alpha'
          vim.cmd 'bd 1'
        end)
      end,
    })
  end,
}
