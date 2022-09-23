local M = {}

local overrides_default = function()
  vim.g.starry_contrast        = true
  vim.g.starry_borders         = true
  vim.g.starry_darker_contrast = true
  vim.g.starry_deep_black      = true
  vim.g.starry_set_hl          = true
  vim.g.starry_daylight_switch = true

  local function starry()
    local dracula_pallete = {
      TelescopeSelection = {
        bg = "#3b4252",
      },
      TelescopePromptBorder = {
        fg = "#3b4252",
        bg = "#3b4252",
      },
      TelescopePromptNormal = {
        fg = "#eceff4",
        bg = "#3b4252",
      },
      TelescopePromptCounter = {
        fg = "#eceff4",
      },
      TelescopePromptTitle = {
        fg = "#282a36",
        bg = "#ff79c6",
      },
      TelescopePreviewTitle = {
        fg = "#282a36",
        bg = "#50fa7b",
      },
      TelescopeResultsTitle = {
        fg = "#1e222b",
        bg = "#ff5555",
      },
      TelescopePreviewBorder = {
        fg = "#1e222b",
        bg = "#1e222b",
      },
      TelescopeResultsBorder = {
        fg = "#1e222b",
        bg = "#1e222b",
      },
      TelescopePreviewNormal = {
        bg = "#1e222b",
      },
      TelescopeResultsNormal = {
        bg = "#1e222b",
      },
    }

    for hl, col in pairs(dracula_pallete) do
      vim.api.nvim_set_hl(0, hl, col)
    end
  end

  return starry()
end

function M.setup()
  overrides_default()
end

return M
