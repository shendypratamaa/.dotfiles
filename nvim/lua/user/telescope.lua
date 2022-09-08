---@diagnostic disable: missing-parameter
local status_ok, telescope = pcall(require, 'telescope')

if not status_ok then
  return
end

local actions = require 'telescope.actions'
local sorters = require 'telescope.sorters'
local telescope_builtin = require 'telescope.builtin'
local previewers = require 'telescope.previewers'

local Job = require 'plenary.job'
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = 'file',
    args = { '--mime-type', '-b', filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], '/')[1]
      if mime_type == 'text' then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(
            bufnr,
            0,
            -1,
            false,
            { 'not support image preview' }
          )
        end)
      end
    end,
  }):sync()
end

vim.cmd [[
  autocmd User TelescopePreviewerLoaded setlocal wrap
]]

local M = {}

local no_preview = {
  previewer = false,
  show_line = false,
  shorten_path = true,
  layout_config = {
    prompt_position = 'bottom',
  },
}

M.custom_themes = function()
  local opts = vim.deepcopy(no_preview)
  telescope_builtin.find_files(opts)
end

telescope.setup {
  defaults = {
    file_ignore_patterns = { 'node%_modules/.*' },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim',
    },
    prompt_prefix = '   ',
    selection_caret = ' ',
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    buffer_previewer_maker = new_maker,
    file_sorter = sorters.get_fuzzy_file,
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.6,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.82,
      height = 0.75,
      preview_cutoff = 120,
    },
    set_env = { ['COLORTERM'] = 'truecolor' },
    borderchars = {
      prompt = { '▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
      results = { '▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
      preview = { '▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
    },
    mappings = {
      i = {
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,

        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,

        ['<C-c>'] = actions.close,

        ['<Down>'] = actions.move_selection_next,
        ['<Up>'] = actions.move_selection_previous,

        ['<CR>'] = actions.select_default,
        ['<C-x>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,

        ['<C-u>'] = actions.preview_scrolling_up,
        ['<C-d>'] = actions.preview_scrolling_down,

        ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
        ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
      },
      n = {
        ['<C-c>'] = actions.close,
        ['q'] = actions.close,

        ['<CR>'] = actions.select_default,

        ['<C-x>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,

        ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
        ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,

        ['j'] = actions.move_selection_next,
        ['k'] = actions.move_selection_previous,
        ['H'] = actions.move_to_top,
        ['M'] = actions.move_to_middle,
        ['L'] = actions.move_to_bottom,

        ['<Down>'] = actions.move_selection_next,
        ['<Up>'] = actions.move_selection_previous,

        ['gg'] = actions.move_to_top,
        ['G'] = actions.move_to_bottom,

        ['<C-u>'] = actions.preview_scrolling_up,
        ['<C-d>'] = actions.preview_scrolling_down,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
    },
  },
  extensions = {
    file_browser = {
      theme = 'ivy',
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      hidden = true,
      mappings = {
        ['i'] = {
          -- your custom insert mode mappings
        },
        ['n'] = {
          -- your custom normal mode mappings
        },
      },
    },
    project = {
      base_dirs = {
        { '~/.code/js/' },
        { '~/.code/vite-react-js/' },
        { '~/.dotfiles' },
      },
      hidden_files = false,
      theme = 'dropdown',
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
    },
  },
}

telescope.load_extension 'fzf'
telescope.load_extension 'file_browser'
telescope.load_extension 'harpoon'
telescope.load_extension 'project'
telescope.load_extension 'dap'

return M
