local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',

    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
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
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
  profile = {
    enable = true,
    threshold = 1,
  },
  max_jobs = 10,
}

vim.cmd [[
  autocmd BufNewFile,BufRead *.json set filetype=jsonc
]]

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use 'lewis6991/impatient.nvim'
  use 'nathom/filetype.nvim'
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use 'nvim-lua/popup.nvim' -- An implementation of the Popup API from vim in Neovim
  use 'nvim-lua/plenary.nvim' -- Useful lua functions used ny lots of plugins
  use 'dstein64/vim-startuptime'

  -- lsp
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "WhoIsSethDaniel/mason-tool-installer.nvim"

  -- use 'williamboman/nvim-lsp-installer'
  -- use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'
  use { 'glepnir/lspsaga.nvim', branch = 'main' }
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'MaxMEllon/vim-jsx-pretty'
  use 'ludovicchabant/vim-gutentags'
  use {
    'kristijanhusak/vim-js-file-import',
    run = 'npm install',
  }
  use 'b0o/SchemaStore.nvim'
  use "folke/lua-dev.nvim"

  -- cmp plugins
  use 'hrsh7th/nvim-cmp' -- The completion plugin
  use 'hrsh7th/cmp-buffer' -- buffer completions
  use 'hrsh7th/cmp-path' -- path completions
  use 'hrsh7th/cmp-cmdline' -- cmdline completions
  use 'saadparwaiz1/cmp_luasnip' -- snippet completions
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-emoji'
  use 'hrsh7th/cmp-calc'
  use 'ray-x/cmp-treesitter'
  use 'David-Kunz/cmp-npm'
  use 'L3MON4D3/LuaSnip' --snippet engine
  use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use
  use 'onsails/lspkind.nvim'

  -- colorscheme
  use 'sainnhe/gruvbox-material'
  use 'folke/tokyonight.nvim'
  use 'rebelot/kanagawa.nvim'
  use { 'catppuccin/nvim', as = 'catppuccin' }

  -- themes utils
  use 'numToStr/Comment.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'SmiteshP/nvim-navic'
  use 'windwp/nvim-autopairs'
  use 'mbbill/undotree'
  use 'antoinemadec/FixCursorHold.nvim'
  use 'ThePrimeagen/harpoon'
  use 'karb94/neoscroll.nvim'
  use 'nacro90/numb.nvim'
  use 'folke/which-key.nvim'
  use 'norcalli/nvim-colorizer.lua'
  use 'romgrk/barbar.nvim'
  use 'ggandor/lightspeed.nvim'
  use 'folke/todo-comments.nvim'
  use 'folke/trouble.nvim'
  use 'abecodes/tabout.nvim'
  use 'chentoast/marks.nvim'
  use 'goolord/alpha-nvim'
  use 'christoomey/vim-tmux-navigator'
  use 'Pocco81/true-zen.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'tyru/open-browser.vim'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
  }
  use {
    'kwkarlwang/bufjump.nvim',
    config = function()
      require('bufjump').setup {
        forward = '<C-i>',
        backward = '<C-o>',
        on_success = function()
          vim.cmd [[execute "normal! g`\"zz"]]
        end,
      }
    end,
  }

  -- tpope
  use {
    'tpope/vim-surround',
    keys = { 'c', 'd', 'y' },
    config = function()
      vim.cmd 'nmap ds       <Plug>Dsurround'
      vim.cmd 'nmap cs       <Plug>Csurround'
      vim.cmd 'nmap cS       <Plug>CSurround'
      vim.cmd 'nmap ys       <Plug>Ysurround'
      vim.cmd 'nmap yS       <Plug>YSurround'
      vim.cmd 'nmap yss      <Plug>Yssurround'
      vim.cmd 'nmap ySs      <Plug>YSsurround'
      vim.cmd 'nmap ySS      <Plug>YSsurround'
      vim.cmd 'xmap gs       <Plug>VSurround'
      vim.cmd 'xmap gS       <Plug>VgSurround'
    end,
  }

  -- Telescope
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-telescope/telescope-project.nvim'

  -- Telescope utils extended
  use 'airblade/vim-rooter'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'RRethy/nvim-treesitter-textsubjects'
  use 'nvim-treesitter/playground'
  use 'p00f/nvim-ts-rainbow'
  use 'theHamsta/nvim-treesitter-pairs'
  use 'windwp/nvim-ts-autotag'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- note taking apps
  use 'nvim-neorg/neorg'

  -- markdown
  use 'mzlogin/vim-markdown-toc'
  use { 'iamcco/markdown-preview.nvim' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
