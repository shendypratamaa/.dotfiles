local context_ok, tree = pcall(require, "treesitter-context")

if not context_ok then
    vim.notify(" 🤖 Treesitter context not working", "Error", {
        title = "Tresitter Log",
        Timeout = 2000,
    })
    return
end

local cfg = {
    enable = true,
    trim_scope = "outer",
    max_lines = 0,
    min_window_height = 0,
    patterns = {
        default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
            "case",
            "variable_declaration",
        },
        markdown = {
            "section",
        },
        json = {
            "pair",
        },
        yaml = {
            "block_mapping_pair",
        },
    },
    exact_patterns = {},
    zindex = 20,
    mode = "topline",
    separator = nil,
}

tree.setup(cfg)
