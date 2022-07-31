vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mochacatcat

local catppuccin_ok, catppuccin = pcall(require, "catppuccin")

if not catppuccin_ok then
  return
end

catppuccin.setup {
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  transparent_background = true,
  term_colors = true,
  compile = {
    enabled = false,
    path = vim.fn.stdpath "cache" .. "/catppuccin",
  },
  styles = {
    comments = { "bold" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
    coc_nvim = false,
    lsp_trouble = false,
    cmp = true,
    lsp_saga = true,
    gitgutter = false,
    gitsigns = true,
    leap = false,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = true,
      transparent_panel = false,
    },
    neotree = {
      enabled = false,
      show_root = true,
      transparent_panel = false,
    },
    dap = {
      enabled = false,
      enable_ui = false,
    },
    which_key = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    dashboard = true,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = true,
    bufferline = false,
    markdown = false,
    lightspeed = false,
    ts_rainbow = true,
    hop = false,
    notify = true,
    telekasten = true,
    symbols_outline = true,
    mini = false,
    aerial = false,
    vimwiki = false,
    beacon = false,
  },
  color_overrides = {},
  highlight_overrides = {
    all = {
      LineNr = { fg = "#f8f8f2" },
      CursorLineNr = { fg = "#ff79c6" },
      ColorColumn = { bg = "#9e9e9e" },
    },
  },
}
