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

    alpha.setup(dashboard.opts)
  end,
  init = function()
    vim.api.nvim_create_autocmd('VimEnter', {
      desc = 'Open Alpha startup screen when nvim runs with directory argument',
      group = vim.api.nvim_create_augroup('OpenAlphaWhenRunWithDir', { clear = true }),
      callback = function()
        local dir = vim.fn.argv(0)
        local stat = vim.uv.fs_stat(dir)
        if stat and stat.type == 'directory' then
          vim.cmd 'Alpha'
        end
      end,
    })
  end,
}
