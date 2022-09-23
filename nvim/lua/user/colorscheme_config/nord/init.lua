local nord_ok, nord = pcall(require, "nord")

if not nord_ok then
  return
end

local M = {}

local function nord_theme_utils()
  vim.g.nord_contrast                = true
  vim.g.nord_borders                 = true
  vim.g.nord_disable_background      = true
  vim.g.nord_italic                  = true
  vim.g.nord_uniform_diff_background = false

  vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
      local highlight = vim.api.nvim_set_hl
      highlight(0, "IlluminatedWord", { link     = "Visual" })
      highlight(0, "IlluminatedWordText", { link = "Visual" })
      highlight(0, "IlluminatedWordRead", { link = "Visual" })
    end,
  })
end

local function nord_single_sources()
  nord_theme_utils()
  nord.set()
  require("user.colorscheme_config.nord.utils").setup()
end

function M.setup()
  nord_single_sources()
end

return M
