local kanagawa_ok, kanagawa = pcall(require, "kanagawa")
local utils                 = require("user.colorscheme_config.utils")

if not kanagawa_ok then
    return
end

local function load_utils()
    utils.border_default()
    utils.illuminate()
    utils.nontext()
end

local M = {}

local cfg = {
    undercurl            = true,
    commentStyle         = { italic = true },
    functionStyle        = { italic = true },
    keywordStyle         = { italic = true },
    statementStyle       = { bold = true },
    typeStyle            = { bold = true },
    variablebuiltinStyle = { italic = true },
    specialReturn        = true,
    specialException     = true,
    transparent          = false,
    dimInactive          = true,
    globalStatus         = true,
    terminalColors       = true,
    colors               = {},
    overrides            = {},
    theme                = "default", -- Load "default" theme or the experimental "light" theme
}

function M.setup()
    kanagawa.setup(cfg)
    load_utils()
end

return M
