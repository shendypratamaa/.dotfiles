local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
local ts_textobject         = require("user.treesitter.modules.treesitter_textobject")
local ts_playground         = require("user.treesitter.modules.treesitter_playground")
local ts_refactor           = require("user.treesitter.modules.treesitter_refactor")
local ts_comment            = require("user.treesitter.modules.treesitter_comment")
local ts_rainbow            = require("user.treesitter.modules.treesitter_rainbow")
local ts_autotag            = require("user.treesitter.modules.treesitter_autotag")

if not status_ok then
    vim.notify(" 🤖 Treesitter Not Working", "Error", {
        title = "Treesitter Log",
        timeout = 2000,
    })
    return
end

local parser_installed = {
    "lua",
    "typescript",
    "javascript",
    "python",
    "css",
    "http",
    "json",
    "jsonc",
    "html",
    "sql",
    "tsx",
    "markdown",
    "yaml",
    "norg",
    "query",
    "regex",
    "swift",
}

local incremental_selection = {
    enable = true,
    keymaps = {
        init_selection = "\\g",
        node_incremental = "\\ga",
        scope_incremental = "\\ge",
        node_decremental = "\\gd",
    },
}

local cfg = {
    ensure_installed = parser_installed,
    sync_install = false,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
    },
    incremental_selection = incremental_selection,
    autotag = ts_autotag.autotag,
    rainbow = ts_rainbow.rainbow,
    context_commentstring = ts_comment.comment,
    refactor = ts_refactor.refactor,
    playground = ts_playground.playground,
    textobjects = {
        select = ts_textobject.select,
        swap = ts_textobject.swap,
        move = ts_textobject.move,
        lsp_interop = ts_textobject.lsp_interop,
    },
}

treesitter.setup(cfg)

require("user.treesitter.plugins.treesitter_context")
