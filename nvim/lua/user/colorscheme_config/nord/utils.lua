local M = {}

-- FIX: different colors
-- nord X base16-nord
-- still have different colors from background inactive into floating borders

local function nord_telescope_theme()
  local TelescopePrompt = {
    TelescopeSelection = {
      bg = '#434c5e',
    },
    TelescopePromptBorder = {
      fg = '#3b4252',
      bg = '#3b4252',
    },
    TelescopePromptNormal = {
      fg = '#eceff4',
      bg = '#3b4252', -- this one
    },
    TelescopeMatching = {
      fg = '#eceff4',
      bg = '#81a1c1',
    },
    TelescopePromptTitle = {
      fg = '#eceff4',
      bg = '#b48ead',
    },
    TelescopePreviewTitle = {
      fg = '#eceff4',
      bg = '#a3be8c',
    },
    TelescopeResultsTitle = {
      fg = '#eceff4',
      bg = '#d08770',
    },
    TelescopePreviewBorder = {
      fg = '#2e3440',
    },
    TelescopeResultsBorder = {
      fg = '#2e3440',
    },
  }
  for hl, col in pairs(TelescopePrompt) do
    vim.api.nvim_set_hl(0, hl, col)
  end
end

function M.setup()
  nord_telescope_theme()
end

return M
