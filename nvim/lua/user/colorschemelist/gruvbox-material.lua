-- GRUVBOX_MATERIAL

vim.cmd [[
 set background=dark
]]

vim.g.gruvbox_material_background = 'soft'
vim.g.gruvbox_material_foreground = 'original'
vim.g.gruvbox_materual_enable_italic = 1
vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_cursor = 'auto'
vim.g.gruvbox_material_current_word = 'grey background'
vim.g.gruvbox_material_transparent_background = 2
vim.g.gruvbox_material_visual = 'grey background'
vim.g.gruvbox_materual_menu_selection_background = 'grey'
vim.g.gruvbox_material_sign_column_background = 'grey'
vim.g.gruvbox_material_spell_foreground = 'colored'
vim.g.gruvbox_material_ui_contrast = 'high'
vim.g.gruvbox_material_diagnostic_text_highlight = 1
vim.g.gruvbox_material_diagnostic_line_highlight = 1
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
vim.g.gruvbox_material_statusline_style = 'original'
vim.g.gruvbox_material_palette = 'mix'
vim.g.gruvbox_material_better_performance = 1

local M = {}

function M.setup()
  local TelescopePrompt = {
    TelescopeSelection = {
      bg = '#3c3836',
    },
    TelescopePreviewMatch = {
      fg = '#a39f83',
      bg = '#d27e99',
    },
    TelescopeMatching = {
      bg = '#d27222',
    },
    TelescopeBorder = {
      fg = '#282828',
    },
    TelescopePromptNormal = {
      fg = '#ffffff',
      bg = '#3b3933',
    },
    TelescopePromptBorder = {
      fg = '#3b3933',
      bg = '#3b3933',
    },
    TelescopePromptTitle = {
      fg = '#f3f3f3',
      bg = '#957FB8',
    },
    TelescopePreviewTitle = {
      fg = '#f3f3f3',
      bg = '#D27E99',
    },
    TelescopeResultsTitle = {
      fg = '#f3f3f3',
      bg = '#FFA066',
    },
  }

  for hl, col in pairs(TelescopePrompt) do
    vim.api.nvim_set_hl(0, hl, col)
  end
end

return M
