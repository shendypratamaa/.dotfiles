local kanagawa_ok, kanagawa = pcall(require, "kanagawa")
local telescope = require "user.colorscheme_config.utils"

if not kanagawa_ok then
  return
end

local function telescope_load()
  local tbl_brd = telescope.telescope_border_utils()
  telescope.load_colors(tbl_brd)
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
  specialReturn        = true, -- special highlight for the return keyword
  specialException     = true, -- special highlight for exception handling keywords
  transparent          = true, -- do not set background color
  dimInactive          = true, -- dim inactive window `:h hl-NormalNC`
  globalStatus         = false, -- adjust window separators highlight for laststatus=3
  terminalColors       = true, -- define vim.g.terminal_color_{0,17}
  colors               = {},
  overrides            = {},
  theme                = "default", -- Load "default" theme or the experimental "light" theme
}

function M.setup()
  kanagawa.setup(cfg)
  telescope_load()
end

return M
