local utils = require "user.colorscheme_config.utils"

local M = {}

local function load_utils(theme)
  if theme == "limestone" then
    local opts = {
      Normal = {
        fg = "#2e2e2e",
        bg = "#eaeada",
      },
      TelescopePreviewNormal = {
        link = "Normal"
      },
      TelescopeResultsNormal = {
        link = "Normal"
      },
      TelescopePromptNormal  = {
        bg = "#ccccbe"
      },
      TelescopePromptBorder  = {
        fg = "#ccccbe",
        bg = "#ccccbe"
      },
      TelescopeResultsBorder = {
        fg = "#ccccbe",
        bg = "#ccccbe"
      },
      TelescopePreviewBorder = {
        fg = "#ccccbe",
        bg = "#ccccbe"
      },
      TelescopePromptTitle   = {
        bg = "#B270A2",
        fg = "#2e2e2e"
      },
      TelescopePreviewTitle  = {
        bg = "#FF8FB1",
        fg = "#2e2e2e"
      },
      TelescopeResultsTitle  = {
        bg = "#FCE2DB",
        fg = "#2e2e2e"
      },
      TelescopeSelection     = {
        link = "TelescopeResultsTitle"
      },
      TelescopePromptCounter = {
        link = "TelescopeResultsTitle"
      },
      CursorLine = {
        bg = "none"
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
