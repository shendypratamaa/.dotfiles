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
  max_jobs = 40,
}

return packer.startup(function(use)
  -- Plugin Here
  use { 'lewis6991/impatient.nvim', commit = '' }
  use { 'wbthomason/packer.nvim', commit = '' }
  use { 'nvim-lua/popup.nvim', commit = '' }
  use { 'nvim-lua/plenary.nvim', commit = '' }

  -- Lsp
  use { 'neovim/nvim-lspconfig', commit = '' }
  use { 'williamboman/mason.nvim', commit = '' }
  use { 'williamboman/mason-lspconfig.nvim', commit = '' }
  use { 'WhoIsSethDaniel/mason-tool-installer.nvim', commit = '' }
  use { 'jose-elias-alvarez/nvim-lsp-ts-utils', commit = '' }
  use { 'jose-elias-alvarez/null-ls.nvim', commit = '255b7c' }
  use { 'jose-elias-alvarez/typescript.nvim', commit = '' }
  use { 'SmiteshP/nvim-navic', commit = '' }
  use { 'b0o/SchemaStore.nvim', commit = '' }
  use { 'folke/lua-dev.nvim', commit = '' }
  use { 'MaxMEllon/vim-jsx-pretty', commit = '' }
  use { 'glepnir/lspsaga.nvim', branch = 'main', commit = '' }
  use { 'ray-x/lsp_signature.nvim', commit = '' }
  use { 'kristijanhusak/vim-js-file-import', run = 'npm install', commit = '' }
  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end,
    commit = '',
  }

  -- Performance
  use { 'dstein64/vim-startuptime', commit = '' }
  use { 'nathom/filetype.nvim', commit = '' }

  -- Cmp
  use { 'hrsh7th/nvim-cmp', commit = '' }
  use { 'hrsh7th/cmp-nvim-lsp', commit = '' }
  use { 'hrsh7th/cmp-buffer', commit = '' }
  use { 'hrsh7th/cmp-path', commit = '' }
  use { 'hrsh7th/cmp-cmdline', commit = '' }
  use { 'hrsh7th/cmp-emoji', commit = '' }
  use { 'hrsh7th/cmp-calc', commit = '' }
  use { 'L3MON4D3/LuaSnip', commit = '' }
  use { 'saadparwaiz1/cmp_luasnip', commit = '' }
  use { 'ray-x/cmp-treesitter', commit = '' }
  use { 'rafamadriz/friendly-snippets', commit = '' }
  use { 'onsails/lspkind.nvim', commit = '' }

  -- Colorscheme
  use { 'RRethy/nvim-base16', commit = '' }
  use { 'shaunsingh/nord.nvim', commit = '' }

  -- Utils
  use { 'numToStr/Comment.nvim', commit = '' }
  use { 'lewis6991/gitsigns.nvim', commit = '' }
  use { 'nvim-lualine/lualine.nvim', commit = '' }
  use { 'windwp/nvim-autopairs', commit = '' }
  use { 'mbbill/undotree', commit = '' }
  use { 'antoinemadec/FixCursorHold.nvim', commit = '' }
  use { 'ThePrimeagen/harpoon', commit = '' }
  use { 'karb94/neoscroll.nvim', commit = '' }
  use { 'nacro90/numb.nvim', commit = '' }
  use { 'folke/which-key.nvim', commit = '' }
  use { 'norcalli/nvim-colorizer.lua', commit = '' }
  use { 'romgrk/barbar.nvim', commit = '' }
  use { 'ggandor/leap.nvim', commit = '' }
  use { 'folke/todo-comments.nvim', commit = '' }
  use { 'folke/trouble.nvim', commit = '' }
  use { 'abecodes/tabout.nvim', commit = '' }
  use { 'chentoast/marks.nvim', commit = '' }
  use { 'goolord/alpha-nvim', commit = '' }
  use { 'christoomey/vim-tmux-navigator', commit = '' }
  use { 'Pocco81/true-zen.nvim', commit = '' }
  use { 'lukas-reineke/indent-blankline.nvim', commit = '' }
  use { 'tyru/open-browser.vim', commit = '' }
  use { 'akinsho/toggleterm.nvim', commit = '' }
  use { 'kevinhwang91/nvim-hlslens', commit = '' }
  use { 'simrat39/symbols-outline.nvim', commit = '' }
  use { 'moll/vim-bbye', commit = '' }
  use { 'tpope/vim-repeat', commit = '' }
  use {
    'bennypowers/nvim-regexplainer',
    requires = {
      'nvim-treesitter/nvim-treesitter',
      'MunifTanjim/nui.nvim',
    },
    commit = '',
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
      config = function()
        require('user.devicons').setup()
      end,
    },
    tag = 'nightly',
    commit = '',
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
    commit = '',
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
    commit = '',
  }
  use {
    'anuvyklack/pretty-fold.nvim',
    config = function()
      require('user.fold').setup()
    end,
    commit = '',
  }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', commit = '' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', commit = '' }
  use { 'nvim-telescope/telescope-project.nvim', commit = 'dc9a19' }

  -- Directory route
  use { 'airblade/vim-rooter', commit = '' }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    commit = 'ba752c',
  }
  use { 'nvim-treesitter/nvim-treesitter-refactor', commit = '' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', commit = '' }
  use { 'nvim-treesitter/nvim-treesitter-context', commit = '' }
  use { 'nvim-treesitter/playground', commit = '' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring', commit = '' }
  use { 'RRethy/nvim-treesitter-textsubjects', commit = '' }
  use { 'theHamsta/nvim-treesitter-pairs', commit = '' }
  use { 'ziontee113/syntax-tree-surfer', commit = '' }
  use { 'windwp/nvim-ts-autotag', commit = '' }
  use { 'p00f/nvim-ts-rainbow', commit = '' }
  use {
    'kylechui/nvim-surround',
    tag = '*',
    config = function()
      require('nvim-surround').setup()
    end,
    commit = '',
  }

  -- API
  use {
    'NtBBloodbath/rest.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    commit = '',
  }

  -- DAP core
  use {
    'mfussenegger/nvim-dap',
    config = function()
      require('user.dap').setup()
    end,
    commit = '',
  }
  use { 'theHamsta/nvim-dap-virtual-text', commit = '' }
  use { 'rcarriga/nvim-dap-ui', commit = '' }
  use { 'nvim-telescope/telescope-dap.nvim', commit = '' }

  -- DAP utility
  use { 'jbyuki/one-small-step-for-vimkind', commit = '' }
  use { 'mxsdev/nvim-dap-vscode-js', commit = '' }
  use { 'mfussenegger/nvim-dap-python', commit = '' }

  -- DAP adapter
  use {
    'microsoft/vscode-js-debug',
    opt = true,
    run = 'npm install --legacy-peer-deps && npm run compile',
    commit = '',
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
    commit = '',
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
    commit = '',
  }
  use { 'mzlogin/vim-markdown-toc', commit = '' }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
