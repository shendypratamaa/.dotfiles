local status_ok, telescope = pcall(require, "telescope")
local actions              = require("telescope.actions")
local actions_state        = require("telescope.actions.state")
local actions_layout       = require("telescope.actions.layout")
local sorters              = require("telescope.sorters")
local telescope_builtin    = require("telescope.builtin")
local previewers           = require("telescope.previewers")
local themes               = require("telescope.themes")
local Job                  = require("plenary.job")

if not status_ok then
    vim.notify(" 🤖 Telescope Error", "error", {
        title   = "Telescope Log",
        timeout = 2000,
    })
    return
end

local find = { "fd", "--type", "f", "--strip-cwd-prefix" }
local ripgrep = {
    "rg",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "--trim",
}

local with_preview = {
    previewers = true,
    layout_config = {
        prompt_position = "bottom",
    },
}

local M = {}

M.find_files = function()
    local opts = vim.deepcopy(with_preview)
    telescope_builtin.find_files(opts)
end

M.find_notes = function()
    local opts = {
        path_display = { shorten = 2 },
        prompt_title = "find notes",
        cwd = "~/.notes/",
    }
    telescope_builtin.find_files(opts)
end

M.colorscheme_pick = function()
    local opts = {
        prompt_title = "Pick Colorscheme",
    }
    local theme = themes.get_dropdown(opts)
    local load  = require("user.telescope.colorscheme_picker").setup(theme)
    return load
end

local new_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job:new({
        command = "file",
        args    = { "--mime-type", "-b", filepath },
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], "/")[1]

            if mime_type == "text" then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(
                        bufnr,
                        0,
                        -1,
                        false,
                        { "not support image preview" }
                    )
                end)
            end
        end,
    }):sync()
end

local mappings = {
    i = {
        ["\\q"]     = actions.close,
        ["<CR>"]    = actions.select_default,

        ["<C-n>"]   = actions.cycle_history_next,
        ["<C-p>"]   = actions.cycle_history_prev,

        ["<C-v>"]   = actions.select_vertical,
        ["<C-h>"]   = actions.select_horizontal,

        ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

        ["<C-j>"]   = actions.move_selection_next,
        ["<C-k>"]   = actions.move_selection_previous,

        ["<C-q>"]   = actions_layout.toggle_preview,

        ["<C-t>"]   = actions.smart_send_to_qflist + actions.open_qflist,

        ["<Down>"]  = false,
        ["<Up>"]    = false,
    },
    n = {
        ["\\q"]     = actions.close,
        ["<CR>"]    = actions.select_default,

        ["<C-n>"]   = actions.cycle_history_next,
        ["<C-p>"]   = actions.cycle_history_prev,

        ["ss"]      = actions.select_horizontal,
        ["sv"]      = actions.select_vertical,

        ["H"]       = actions.move_to_top,
        ["M"]       = actions.move_to_middle,
        ["L"]       = actions.move_to_bottom,

        ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

        ["j"]       = actions.move_selection_next,
        ["k"]       = actions.move_selection_previous,

        ["<C-q>"]   = actions_layout.toggle_preview,

        ["<C-t>"]   = actions.smart_send_to_qflist + actions.open_qflist,

        ["<Down>"]  = false,
        ["<Up>"]    = false,
    },
}

local borderchars = {
    prompt  = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
    results = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
    preview = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
}

local pickers = {
    find_files = {
        find_command = find,
    },
    buffers = {
        show_all_buffers = true,
        sort_lastused    = true,
        mappings = {
            i = {
                ["\\q"]     = "delete_buffer",

                ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            },
            n = {
                ["\\q"]     = "delete_buffer",

                ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            },
        },
    },
    quickfix = {
        trim_text = true,
    },
    quickfixhistory = {
        find_command = find,
        mappings = {
            i = {
                ["<C-o>"] = function(prompt_buf)
                    local entry = actions_state.get_selected_entry()
                    actions.close(prompt_buf)
                    vim.cmd(string.format("%schistory | copen", entry.nr))
                end,
            },
            n = {
                ["<C-o>"] = function(prompt_buf)
                    local entry = actions_state.get_selected_entry()
                    actions.close(prompt_buf)
                    vim.cmd(string.format("%schistory | copen", entry.nr))
                end,
            },
        },
    },
}

local extensions = {
    project = {
        base_dirs = {
            { "~/.code/" },
            { "~/.config/" },
        },
        hidden_files = true,
        theme        = "dropdown",
    },
    fzf = {
        fuzzy                   = true,
        override_generic_sorter = true,
        override_file_sorter    = true,
        case_mode               = "smart_case",
    },
    bookmarks = {
        selected_browser = "safari",
        url_open_command = "open",
    },
    ["ui-select"] = {
        themes.get_dropdown({
            -- even more opts
        }),
    },
}

local layout_config = {
    horizontal = {
        prompt_position = "bottom",
        preview_width = 0.6,
        results_width = 0.8,
    },
    vertical = {
        mirror = false,
    },
    width          = 0.82,
    height         = 0.75,
    preview_cutoff = 120,
}

local cfg = {
    defaults = {
        file_ignore_patterns   = { "node%_modules/.*" },
        prompt_prefix          = " ",
        selection_caret        = "▷ ",
        sorting_strategy       = "descending",
        path_display           = { "truncate" },
        vimgrep_arguments      = ripgrep,
        buffer_previewer_maker = new_maker,
        file_previewer         = previewers.vim_buffer_cat.new,
        grep_previewer         = previewers.vim_buffer_vimgrep.new,
        qflist_previewer       = previewers.vim_buffer_qflist.new,
        file_sorter            = sorters.get_fuzzy_file,
        generic_sorter         = sorters.get_generic_fuzzy_sorter,
        layout_config          = layout_config,
        borderchars            = borderchars,
        mappings               = mappings,
    },
    pickers = pickers,
    extensions = extensions,
}

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- telescope builtin
keymap("n", "]g", ":lua require('telescope.builtin').builtin()<CR>", opts)
keymap("n", "]b", ":lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "]r", ":lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "]h", ":lua require('telescope.builtin').help_tags()<CR>", opts)
keymap( "n", "]fh", ":lua require('telescope.builtin').quickfixhistory()<CR>", opts)
keymap("n", "]fc", ":lua require('telescope.builtin').commands()<CR>", opts)

-- telescope extensions
keymap( "n", "]v", ":lua require('telescope').extensions.project.project({display_type = 'full'})<CR>", opts)
keymap( "n", "]t", ":lua require('telescope').extensions.bookmarks.bookmarks()<CR>", opts)
keymap( "n", "]tw", ":lua require('telescope').extensions.notify.notify()<CR>", opts)

-- telescope custom
keymap("n", "]f", ":lua require('user.telescope').find_files()<CR>", opts)
keymap("n", "]fn", ":lua require('user.telescope').find_notes()<CR>", opts)
keymap( "n", "]tq", ":lua require('user.telescope').colorscheme_pick()<CR>", opts)

telescope.setup(cfg)

telescope.load_extension("fzf")
telescope.load_extension("harpoon")
telescope.load_extension("project")
telescope.load_extension("dap")
telescope.load_extension("bookmarks")
telescope.load_extension("ui-select")

return M
