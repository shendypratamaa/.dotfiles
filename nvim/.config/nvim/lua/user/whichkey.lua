local status_ok, which_key = pcall(require, "which-key")

if not status_ok then
    return
end

local wk = which_key

local cfg = {
    plugins = {
        marks     = false, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled     = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
            operators    = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions      = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows      = false, -- default bindings on <c-w>
            nav          = false, -- misc bindings to work with windows
            z            = false, -- bindings for folds, spelling and others prefixed with z
            g            = false, -- bindings for prefixed with g
        },
    },
    operators = { gc = "Comments" },
    key_labels = {
        ["<space>"] = "SPC",
        ["<cr>"]    = "RET",
        ["<tab>"]   = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator  = "➜", -- symbol used between a key and it's label
        group      = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up   = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border   = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin   = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding  = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height  = { min = 3, max = 25 }, -- min and max height of the columns
        width   = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 10, -- spacing between columns
        align   = "center", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = { "<leader>" }, -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode    = "n", -- NORMAL mode
    prefix  = "<leader>",
    buffer  = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent  = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait  = true, -- use `nowait` when creating keymaps:
}

local keybinds = {
    D = { "<cmd>:Bwipeout<CR>", "Delete Buffer" },
    s = { "<cmd>:w!<CR>:wshada!<CR>", "Save Files" },
    S = { "<cmd>StartupTime<CR>", "Startup Time" },
    q = { "<cmd>:wq!<CR>", "Quit Save" },
    h = { "<cmd>sv<CR>", "Split Horizontal" },
    v = { "<cmd>vs<CR>", "Split Vertical" },
    n = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    F = { "<cmd>Format<CR>", "Format File" },
    t = {
        name = "Telescope",
        T = {
            '<cmd>lua require("user.telescope").colorscheme_pick()<CR>',
            "Colorscheme",
        },
        f = {
            '<cmd>lua require("user.telescope").find_files()<CR>',
            "Find Files",
        },
        n = {
            '<cmd>lua require("user.telescope").find_notes()<CR>',
            "Find Notes",
        },
        b = { '<cmd>lua require("telescope.builtin").buffers()<CR>', "Buffers" },
        r = {
            '<cmd>lua require("telescope.builtin").live_grep()<CR>',
            "Live Grep",
        },
        h = {
            '<cmd>lua require("telescope.builtin").help_tags()<CR>',
            "Help Tags",
        },
        g = { "<cmd>Telescope<CR>", "Builtins Utils" },
        e = { "<cmd>TodoTelescope<CR>", "Todo Notes" },
        t = { "<cmd>Telescope bookmarks<CR>", "Bookmars Browser" },
    },
    l = {
        name = "LSP",
        h = { "<cmd>LspInfo<CR>", "Lsp Info" },
        j = { "<cmd>Mason<CR>", "Mason Info" },
        n = { "<cmd>NullLsInfo<CR>", "NullLs Info" },
    },
    u = {
        name = "Workspace Utility",
        q = {
            function()
                Toggle_qf()
            end,
            "Quick Fix List",
        },
        l = { "<cmd>Telescope quickfixhistory<CR>", "Quick Fix History" },
        w = {
            "<cmd>TroubleToggle workspace_diagnostics<CR>",
            "Workspace Diagnostics",
        },
        d = {
            "<cmd>TroubleToggle document_diagnostics<CR>",
            "Document Diagnostics",
        },
        r = { "<cmd>TroubleToggle lsp_references<CR>", "Lsp References" },
    },
}

wk.setup(cfg)
wk.register(keybinds, opts)
