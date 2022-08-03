local kaganagawa_available, kanagawa = pcall(require, "kanagawa")

if not kaganagawa_available then
  return
end

local default_colors = require("kanagawa.colors").setup()

local overrides = {
  LineNr = { fg = default_colors.fujiWhite },
  ColorColumn = { bg = default_colors.fujiWhite },
}

kanagawa.setup {
  undercurl = true,
  commentStyle = { italic = false },
  functionStyle = { bold = true },
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  variablebuiltinStyle = { italic = true },
  specialReturn = true, -- special highlight for the return keyword
  specialException = true, -- special highlight for exception handling keywords
  transparent = true, -- do not set background color
  dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  globalStatus = false, -- adjust window separators highlight for laststatus=3
  terminalColors = true,
  colors = {},
  overrides = overrides,
}
