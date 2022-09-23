local highlight = vim.api.nvim_set_hl
local M = {}

local function starry_load()
  vim.g.starry_italic_functions = false
  vim.g.starry_italic_comments  = true
  vim.g.starry_italic_string    = true
  vim.g.starry_italic_keywords  = true
  vim.g.starry_italic_variables = true

  vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
      highlight(0, "IlluminatedWord", { link = "PmenuSel" })
      highlight(0, "IlluminatedWordText", { link = "PmenuSel" })
      highlight(0, "IlluminatedWordRead", { link = "PmenuSel" })
    end,
  })

  local custom = function()
    local fix_conflicts_colors = {
      Normal = {
        fg = "none",
        bg = "none",
      },
      SignColumn = {
        bg = "none",
      },
      CursorLine = {
        bg = "none",
      },
      ColorColumn = {
        bg = "#FFE6F7",
      },
      NonText = {
        fg = "#FFE6F7",
      },
      IndentBlanklineChar = {
        fg = "#FFE6F7",
      },
    }

    for hl, col in pairs(fix_conflicts_colors) do
      highlight(0, hl, col)
    end
  end

  return {
    custom = custom(),
    call = require("user.colorscheme_config.starry.utils").setup(),
  }
end

function M.setup()
  starry_load()
end

return M
