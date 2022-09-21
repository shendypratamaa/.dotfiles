---@diagnostic disable: missing-parameter
local status_ok, telescope = pcall(require, 'telescope')

if not status_ok then
  return
end

local actions = require 'telescope.actions'
local sorters = require 'telescope.sorters'
local telescope_builtin = require 'telescope.builtin'
local previewers = require 'telescope.previewers'
local trouble = require 'trouble.providers.telescope'

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

local M = {}

local no_preview = {
  previewer = false,
  show_line = false,
  shorten_path = true,
  layout_config = {
    prompt_position = 'bottom',
  },
}

M.find_files_custom = function()
  local opts = vim.deepcopy(no_preview)
  telescope_builtin.find_files(opts)
end

M.colorscheme_pick = function()
  local theme = require('telescope.themes').get_dropdown({ prompt_title = 'Pick Colorscheme 🎨'})
  local opts = require('user.telescope.colorscheme_picker').setup(theme)
  return opts
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
    prompt_prefix = '  ',
    selection_caret = ' ',
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    buffer_previewer_maker = new_maker,
    file_sorter = sorters.get_fuzzy_file,
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    path_display = { 'shorten' },
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
        ['\\q'] = actions.close,
        ['<Down>'] = actions.move_selection_next,
        ['<Up>'] = actions.move_selection_previous,
        ['<CR>'] = actions.select_default,
        ['<C-h>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,
        ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
        ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
        [']e'] = trouble.open_with_trouble,
      },
      n = {
        ['\\q'] = actions.close,
        ['q'] = actions.close,
        ['<CR>'] = actions.select_default,
        ['ss'] = actions.select_horizontal,
        ['sv'] = actions.select_vertical,
        ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
        ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
        ['j'] = actions.move_selection_next,
        ['k'] = actions.move_selection_previous,
        ['H'] = actions.move_to_top,
        ['M'] = actions.move_to_middle,
        ['L'] = actions.move_to_bottom,
        ['<Down>'] = actions.move_selection_next,
        ['<Up>'] = actions.move_selection_previous,
        [']e'] = trouble.open_with_trouble,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
    },
  },
  extensions = {
    project = {
      base_dirs = {
        { '~/.code/js/' },
        { '~/.code/vite-react-js/' },
        { '~/.dotfiles' },
      },
      hidden_files = true,
      theme = 'dropdown',
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
    },
     bookmarks = {
      selected_browser = 'safari',
      url_open_command = 'open',
    },
  },
}

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', ']te', ':TodoTelescope<CR>', opts)
keymap('n', ']f', ":lua require('telescope.builtin').find_files()<CR>", opts)
keymap('n', ']b', ":lua require('telescope.builtin').buffers()<CR>", opts)
keymap('n', ']r', ":lua require('telescope.builtin').live_grep()<CR>", opts)
keymap('n', ']h', ":lua require('telescope.builtin').help_tags()<CR>", opts)
keymap('n', ']g', ':Telescope<CR>', opts)
keymap('n', ']t', ':Telescope bookmarks<CR>', opts)
keymap('n', ']v', ":lua require('telescope').extensions.project.project{ display_type = 'full'}<CR>", opts)
keymap('n', ']tw', ":lua require('telescope').extensions.notify.notify()<CR>", opts)

-- Custom Telescope
keymap('n', ']ff', ":lua require('user.telescope').find_files_custom()<CR>", opts)
keymap('n', ']tq', ':lua require("user.telescope").colorscheme_pick()<CR>', opts)

telescope.load_extension 'fzf'
telescope.load_extension 'harpoon'
telescope.load_extension 'project'
telescope.load_extension 'dap'
telescope.load_extension 'bookmarks'

return M
