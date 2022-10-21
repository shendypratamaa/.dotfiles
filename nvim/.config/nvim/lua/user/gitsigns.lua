local gitsigns_ok, gitsigns = pcall(require, "gitsigns")

if not gitsigns_ok then
    return
end

local cfg = {
    trouble = true,
    signs = {
        add = {
            hl     = "GitSignsAdd",
            text   = "│",
            numhl  = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
        },
        change = {
            hl     = "GitSignsChange",
            text   = "│",
            numhl  = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
        },
        delete = {
            hl     = "GitSignsDelete",
            text   = "_",
            numhl  = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        topdelete = {
            hl     = "GitSignsDelete",
            text   = "‾",
            numhl  = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        changedelete = {
            hl     = "GitSignsChange",
            text   = "~",
            numhl  = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
        },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        interval     = 100,
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame  = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text         = true,
        virt_text_pos     = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay             = 100,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = " <author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,
    max_file_length              = 40000,
    preview_config = {
        border   = "rounded",
        style    = "minimal",
        relative = "cursor",
        row      = 0,
        col      = 1,
    },
    yadm = {
        enable = false,
    },
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
            opts        = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "gitsign next" })

        map("n", "[c", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "gisign prev" })
        map("n", "\\tf", ":Gitsigns setqflist<CR>")

        -- Actions
        map({ "n", "v" }, "\\ts", ":Gitsigns stage_hunk<CR>", { desc = "V git stage hunk"})
        map({ "n", "v" }, "\\tr", ":Gitsigns reset_hunk<CR>", { desc = "V git reset hunk"})
        map("n", "\\tsb", gs.stage_buffer, { desc = "git stage buffer"})
        map("n", "\\trb", gs.reset_buffer, { desc = "git reset buffer"})
        map("n", "\\trn", gs.undo_stage_hunk, { desc = "git undo stage hunk"})
        map("n", "\\tq", gs.preview_hunk, { desc = "git preview hunk"})
        map("n", "\\ta", gs.toggle_current_line_blame, { desc = "git blame current line"})
        map("n", "\\hd", function() gs.diffthis("~") end, { desc = "git diff this"})
        map("n", "\\td", gs.toggle_deleted, { desc = "git toggle delete"})

        -- text-object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "git select hunk text obj"})
    end,
}

gitsigns.setup(cfg)
