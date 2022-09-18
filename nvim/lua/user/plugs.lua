---@diagnostic disable: missing-parameter
local packer_ok, packer = pcall(require, 'packer')

if not packer_ok then
  return
end

local fn = vim.fn
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

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end

  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
   endif
]]

packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
  profile = {
    enable = true,
    threshold = 0,
  },
  max_jobs = 10,
}

return packer.startup(function(use)
  -- Plugin Here
  use { 'lewis6991/impatient.nvim' }
  use { 'wbthomason/packer.nvim' }
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }

  -- Lsp
  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'WhoIsSethDaniel/mason-tool-installer.nvim' }
  use { 'jose-elias-alvarez/nvim-lsp-ts-utils' }
  use { 'jose-elias-alvarez/null-ls.nvim', commit = '255b7c' }
  use { 'jose-elias-alvarez/typescript.nvim' }
  use { 'SmiteshP/nvim-navic' }
  use { 'b0o/SchemaStore.nvim' }
  use { 'folke/lua-dev.nvim' }
  use { 'MaxMEllon/vim-jsx-pretty' }
  use { 'glepnir/lspsaga.nvim', branch = 'main' }
  use { 'ray-x/lsp_signature.nvim' }
  use { 'kristijanhusak/vim-js-file-import', run = 'npm install' }
  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end,
  }

  -- Performance
  use { 'dstein64/vim-startuptime' }
  use { 'nathom/filetype.nvim' }

  -- Cmp
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/cmp-emoji' }
  use { 'hrsh7th/cmp-calc' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'ray-x/cmp-treesitter' }
  use { 'rafamadriz/friendly-snippets' }
  use { 'onsails/lspkind.nvim' }

  -- Colorscheme
  use { 'RRethy/nvim-base16' }
  use { 'shaunsingh/nord.nvim' }

  -- Utils
  use { 'numToStr/Comment.nvim' }
  use { 'lewis6991/gitsigns.nvim' }
  use { 'nvim-lualine/lualine.nvim' }
  use { 'windwp/nvim-autopairs' }
  use { 'mbbill/undotree' }
  use { 'antoinemadec/FixCursorHold.nvim' }
  use { 'ThePrimeagen/harpoon' }
  use { 'karb94/neoscroll.nvim' }
  use { 'nacro90/numb.nvim' }
  use { 'folke/which-key.nvim' }
  use { 'norcalli/nvim-colorizer.lua' }
  use { 'romgrk/barbar.nvim' }
  use { 'ggandor/leap.nvim' }
  use { 'folke/todo-comments.nvim' }
  use { 'folke/trouble.nvim' }
  use { 'abecodes/tabout.nvim' }
  use { 'chentoast/marks.nvim' }
  use { 'goolord/alpha-nvim' }
  use { 'christoomey/vim-tmux-navigator' }
  use { 'Pocco81/true-zen.nvim' }
  use { 'lukas-reineke/indent-blankline.nvim' }
  use { 'tyru/open-browser.vim' }
  use { 'akinsho/toggleterm.nvim' }
  use { 'kevinhwang91/nvim-hlslens' }
  use { 'simrat39/symbols-outline.nvim' }
  use { 'moll/vim-bbye' }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
      config = function()
        require('user.devicons').setup()
      end,
    },
    tag = 'nightly',
  }
  use {
    'luukvbaal/stabilize.nvim',
    config = function()
      require('stabilize').setup {
        ignore = {
          filetype = { 'help', 'list', 'Trouble' },
          buftype = { 'quickfix', 'loclist', 'undotree', 'terminal' },
        },
        nested = nil,
      }
    end,
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
  use {
    'anuvyklack/pretty-fold.nvim',
    config = function()
      require('user.fold').setup()
    end,
  }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim' }
  use { 'nvim-telescope/telescope-file-browser.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-project.nvim', commit = 'dc9a19' }

  -- Directory route
  use { 'airblade/vim-rooter' }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    commit = 'ba752c',
  }
  use { 'nvim-treesitter/nvim-treesitter-refactor' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'nvim-treesitter/nvim-treesitter-context' }
  use { 'nvim-treesitter/playground' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  use { 'RRethy/nvim-treesitter-textsubjects' }
  use { 'theHamsta/nvim-treesitter-pairs' }
  use { 'ziontee113/syntax-tree-surfer' }
  use { 'windwp/nvim-ts-autotag' }
  use { 'p00f/nvim-ts-rainbow' }
  use {
    'kylechui/nvim-surround',
    tag = '*',
    config = function()
      require('nvim-surround').setup()
    end,
  }

  -- API
  use { 'NtBBloodbath/rest.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- DAP core
  use {
    'mfussenegger/nvim-dap',
    config = function()
      require('user.dap').setup()
    end,
  }
  use { 'theHamsta/nvim-dap-virtual-text' }
  use { 'rcarriga/nvim-dap-ui' }
  use { 'nvim-telescope/telescope-dap.nvim' }

  -- DAP utility
  use { 'jbyuki/one-small-step-for-vimkind' }
  use { 'mxsdev/nvim-dap-vscode-js' }
  use { 'mfussenegger/nvim-dap-python' }

  -- DAP adapter
  use {
    'microsoft/vscode-js-debug',
    opt = true,
    run = 'npm install --legacy-peer-deps && npm run compile',
  }

  -- NeovimTest
  use {
    'nvim-neotest/neotest',
    requires = {
      'haydenmeade/neotest-jest',
    },
    config = function()
      require('user.neotest').setup()
    end,
  }

  -- Note Taking Apps
  use { 'nvim-neorg/neorg', tag = '0.0.12' }

  -- Markdown
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  }
  use { 'mzlogin/vim-markdown-toc' }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
