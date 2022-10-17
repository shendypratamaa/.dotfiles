local utils = require("user.colorscheme_config.utils")

local M = {}

local function load_utils(theme)
    if theme == "limestone" then
        local opts = {
            Normal = {
                fg = "#2e2e2e",
                bg = "#eaeada",
            },
            TelescopePreviewNormal = {
                bg = "#FFF8F3",
            },
            TelescopeResultsNormal = {
                bg = "#FFF8F3",
            },
            TelescopePromptNormal = {
                bg = "#F9F2ED",
            },
            TelescopePromptBorder = {
                fg = "#F9F2ED",
                bg = "#F9F2ED",
            },
            TelescopeResultsBorder = {
                fg = "#FFF8F3",
                bg = "#FFF8F3",
            },
            TelescopePreviewBorder = {
                fg = "#FFF8F3",
                bg = "#FFF8F3",
            },
            TelescopePromptTitle = {
                bg = "#B270A2",
                fg = "#2e2e2e",
            },
            TelescopePreviewTitle = {
                bg = "#FF8FB1",
                fg = "#2e2e2e",
            },
            TelescopeResultsTitle = {
                bg = "#FCE2DB",
                fg = "#2e2e2e",
            },
            TelescopeSelection = {
                link = "TelescopeResultsTitle",
            },
            TelescopePromptCounter = {
                fg = "#2e2e2e",
                bg = "#F9F2ED",
            },
            CursorLine = {
                bg = "none",
            },
        }

        utils.illuminate()
        utils.load_colors(opts)
    end

    if theme ~= "limestone" then
        utils.border_default()
        utils.illuminate()
        utils.nontext()
    end
end

local function starry_load()
    vim.g.starry_italic_functions   = false
    vim.g.starry_italic_comments    = true
    vim.g.starry_italic_string      = true
    vim.g.starry_italic_keywords    = true
    vim.g.starry_italic_variables   = true
    vim.g.starry_contrast           = true
    vim.g.starry_borders            = true
    vim.g.starry_darker_contrast    = true
    vim.g.starry_deep_black         = true
    vim.g.starry_set_hl             = true
    vim.g.starry_daylight_switch    = true
    vim.g.starry_disable_background = false
end

function M.setup(theme)
    starry_load()
    load_utils(theme)
end

return M
