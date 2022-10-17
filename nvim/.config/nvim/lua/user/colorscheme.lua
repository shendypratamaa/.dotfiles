local function colorscheme(theme)
    local cmd_colors = pcall(vim.cmd, "colorscheme " .. theme)
    require("user.colorscheme_config.init").setup(theme)
    require("user.lualine").setup(theme)
    return cmd_colors
end

-- WARNING: Colorscheme Terms
-- colorscheme available starry-bundle, nord, kanagawa, catppuccin 📦
-- press <leader> t T or tq] and choose colorscheme for see all options 📚

colorscheme("nord")
