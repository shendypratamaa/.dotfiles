local status_ok, telescope = pcall(require, "telescope")

if not status_ok then
  return
end

local actions = require "telescope.actions"
local telescope_builtin = require "telescope.builtin"

vim.cmd [[
  autocmd User TelescopePreviewerLoaded setlocal wrap
]]

local M = {}

M.TelescopePrompt = {
  TelescopeSelection = {
    bg = "#313140",
  },
  TelescopeBorder = {
    bg = "#1f1f28",
  },
  TelescopeMatching = {
    fg = "#C34043",
  },
  TelescopePromptNormal = {
    bg = "#1f1f28",
  },
  TelescopePromptBorder = {
    bg = "#1f1f28",
  },
  TelescopePromptTitle = {
    fg = "#f3f3f3",
    bg = "#957FB8",
  },
  TelescopePreviewTitle = {
    fg = "#f3f3f3",
    bg = "#D27E99",
  },
  TelescopeResultsTitle = {
    fg = "#f3f3f3",
    bg = "#FFA066",
  },
}

for hl, col in pairs(M.TelescopePrompt) do
  vim.api.nvim_set_hl(0, hl, col)
end

local no_preview = {
  previewer = false,
  show_line = false,
  shorten_path = true,
  layout_config = {
    height = 0.6,
    width = 0.8,
    prompt_position = "bottom",
  },
}

M.custom_themes = function()
  local opts = vim.deepcopy(no_preview)
  telescope_builtin.find_files(opts)
end

telescope.setup {
  defaults = {
    preview = {
      mime_hook = function(filepath, bufnr, opts)
        local is_image = function(filepath)
          local image_extensions = { "png", "jpg", "svg" }
          local split_path = vim.split(filepath:lower(), ".", { plain = true })
          local extension = split_path[#split_path]
          return vim.tbl_contains(image_extensions, extension)
        end
        if is_image(filepath) then
          local term = vim.api.nvim_open_term(bufnr, {})
          local function send_output(_, data, _)
            for _, d in ipairs(data) do
              vim.api.nvim_chan_send(term, d .. "\r\n")
            end
          end
          vim.fn.jobstart({
            "catimg",
            filepath, -- Terminal image viewer command
          }, { on_stdout = send_output, stdout_buffered = true })
        else
          require("telescope.previewers.utils").set_preview_message(
            bufnr,
            opts.winid,
            "Binary cannot be previewed"
          )
        end
      end,
    },
    file_ignore_patterns = { "node%_modules/.*" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim",
    },
    prompt_prefix = "🌓 ",
    selection_caret = "🚀 ",
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    layout_config = {
      horizontal = {
        winblend = 20,
        prompt_position = "top",
        preview_width = 0.6,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    set_env = { ["COLORTERM"] = "truecolor" },
    borderchars = {
      prompt = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
      results = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
      preview = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
    },
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      },
      n = {
        ["<C-c>"] = actions.close,
        ["q"] = actions.close,

        ["<CR>"] = actions.select_default,

        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      hidden = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}

telescope.load_extension "fzf"
telescope.load_extension "file_browser"
telescope.load_extension "harpoon"

return M
