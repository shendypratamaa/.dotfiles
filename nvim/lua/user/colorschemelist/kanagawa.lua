-- NOTE: floating window from navigator highlighting weird, red color dominated functionName()
-- KANAGAWA
local kaganagawa_available, kanagawa = pcall(require, "kanagawa")
if not kaganagawa_available then
  return
end

kanagawa.setup {
  undercurl = true,
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  variablebuiltinStyle = { italic = true },
  specialReturn = true, -- special highlight for the return keyword
  specialException = true, -- special highlight for exception handling keywords
  transparent = true, -- do not set background color
  dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  globalStatus = false, -- adjust window separators highlight for laststatus=3
  colors = {},
  overrides = {},
}
