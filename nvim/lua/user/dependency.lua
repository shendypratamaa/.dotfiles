local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",

    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- lsp
  use "williamboman/nvim-lsp-installer"
  use "neovim/nvim-lspconfig"
  use "jose-elias-alvarez/null-ls.nvim"
  use { "glepnir/lspsaga.nvim", branch = "main" }
  use "jose-elias-alvarez/nvim-lsp-ts-utils"
  use "MaxMEllon/vim-jsx-pretty"
  use "ludovicchabant/vim-gutentags"
  use {
    "kristijanhusak/vim-js-file-import",
    run = "npm install",
  }

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-nvim-lsp-signature-help"
  use "hrsh7th/cmp-emoji"
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- colorscheme
  use "sainnhe/gruvbox-material"
  use "folke/tokyonight.nvim"
  use "rebelot/kanagawa.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }

  -- themes utils
  use "numToStr/Comment.nvim"
  use "lewis6991/gitsigns.nvim"
  use "nvim-lualine/lualine.nvim"
  use "SmiteshP/nvim-gps"
  use "windwp/nvim-autopairs"
  use "mbbill/undotree"
  use "antoinemadec/FixCursorHold.nvim"
  use "ThePrimeagen/harpoon"
  use "karb94/neoscroll.nvim"
  use "nacro90/numb.nvim"
  use "folke/which-key.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "romgrk/barbar.nvim"
  use "ggandor/lightspeed.nvim"
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly", -- optional, updated every week. (see issue #1193)
  }
  use "abecodes/tabout.nvim"
  use "chentoast/marks.nvim"
  use "goolord/alpha-nvim"
  use "christoomey/vim-tmux-navigator"
  use "Pocco81/true-zen.nvim"

  -- tpope
  use {
    "tpope/vim-surround",
    keys = { "c", "d", "y" },
    config = function()
      vim.cmd "nmap ds       <Plug>Dsurround"
      vim.cmd "nmap cs       <Plug>Csurround"
      vim.cmd "nmap cS       <Plug>CSurround"
      vim.cmd "nmap ys       <Plug>Ysurround"
      vim.cmd "nmap yS       <Plug>YSurround"
      vim.cmd "nmap yss      <Plug>Yssurround"
      vim.cmd "nmap ySs      <Plug>YSsurround"
      vim.cmd "nmap ySS      <Plug>YSsurround"
      vim.cmd "xmap gs       <Plug>VSurround"
      vim.cmd "xmap gS       <Plug>VgSurround"
    end,
  }

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- Telescope utils extended
  use "airblade/vim-rooter"

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "nvim-treesitter/nvim-treesitter-refactor"
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "nvim-treesitter/nvim-treesitter-context"
  use "RRethy/nvim-treesitter-textsubjects"
  use "nvim-treesitter/playground"
  use "p00f/nvim-ts-rainbow"
  use "theHamsta/nvim-treesitter-pairs"
  use "windwp/nvim-ts-autotag"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- note taking apps
  use "nvim-neorg/neorg"

  -- markdown
  use "mzlogin/vim-markdown-toc"
  use { "iamcco/markdown-preview.nvim" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
