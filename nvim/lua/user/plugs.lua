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
  max_jobs = 25,
}

return packer.startup(function(use)
  -- Plugin Here

  -- Package
  use { 'wbthomason/packer.nvim', commit = '6afb67460283f0e990d35d229fd38fdc04063e0a' }

  -- Lua development
  use { 'nvim-lua/plenary.nvim', commit = '62dc2a7acd2fb2581871a36c1743b29e26c60390' }
  use { 'nvim-lua/popup.nvim', commit = 'b7404d35d5d3548a82149238289fa71f7f6de4ac' }
  use { 'folke/lua-dev.nvim', commit = '8f94b49b982ec4e7644f1e5004ec33c98903d32a' }

  -- Lsp
  use { 'neovim/nvim-lspconfig', commit = '51775b12cfbf1b6462c7b13cd020cc09e6767aea' }
  use { 'williamboman/mason.nvim', commit = 'ac9a089ac7ca5c2c748433e71f5c7daff8cdc5ad' }
  use { 'williamboman/mason-lspconfig.nvim', commit = 'b70dedab5ceb5f3f84c6bc9ceea013292a14f8dc' }
  use { 'WhoIsSethDaniel/mason-tool-installer.nvim', commit = '617f3a105a67f840e6f706b1b0d80e86773ba004' }
  use { 'jose-elias-alvarez/null-ls.nvim', commit = '255b7c' }
  use { 'jose-elias-alvarez/typescript.nvim', commit = 'fc02517dbec65143d4d414ed6b66bbf5405c0c20' }
  use { 'SmiteshP/nvim-navic', commit = '202312e93869213c574d200a40eafeff4b4caec2' }
  use { 'b0o/SchemaStore.nvim', commit = 'a5fbd83d2b9b778518203e25167c05580add6b31' }
  use { 'glepnir/lspsaga.nvim', branch = 'main', commit = 'c2ef0115fb917460daf5c76fe3ad3a9357213b54' }
  use { 'ray-x/lsp_signature.nvim', commit = 'e65a63858771db3f086c8d904ff5f80705fd962b' }
  use { 'j-hui/fidget.nvim', commit = '492492e7d50452a9ace8346d31f6d6da40439f0e' }
  use { 'simrat39/symbols-outline.nvim', commit = '6a3ed24c5631da7a5d418bced57c16b32af7747c' }
  use { 'RRethy/vim-illuminate', commit = 'b5452627d6ef9c04a27ac4edde0b00aa3a50f60f' }
  use { 'kristijanhusak/vim-js-file-import', run = 'npm install', commit = 'ac583be8d81b86bae7064d39ad23d78d3f0aff0e' }
  use { 'ludovicchabant/vim-gutentags', commit = "b77b8fabcb0b052c32fe17efcc0d44f020975244" }

  -- Performance
  use { 'lewis6991/impatient.nvim', commit = 'b842e16ecc1a700f62adb9802f8355b99b52a5a6' }
  use { 'dstein64/vim-startuptime', commit = '0dcecdf0823d668e291dbd571d6bb9086584357f' }
  use { 'nathom/filetype.nvim', commit = 'b522628a45a17d58fc0073ffd64f9dc9530a8027' }

  -- Completion
  use { 'hrsh7th/nvim-cmp', commit = '913eb8599816b0b71fe959693080917d8063b26a' }
  use { 'hrsh7th/cmp-nvim-lsp', commit = 'affe808a5c56b71630f17aa7c38e15c59fd648a8' }
  use { 'hrsh7th/cmp-buffer', commit = '3022dbc9166796b644a841a02de8dd1cc1d311fa' }
  use { 'hrsh7th/cmp-path', commit = '447c87cdd6e6d6a1d2488b1d43108bfa217f56e1' }
  use { 'hrsh7th/cmp-cmdline', commit = 'c66c379915d68fb52ad5ad1195cdd4265a95ef1e' }
  use { 'hrsh7th/cmp-emoji', commit = '19075c36d5820253d32e2478b6aaf3734aeaafa0' }
  use { 'hrsh7th/cmp-calc', commit = 'f7efc20768603bd9f9ae0ed073b1c129f63eb312' }
  use { 'onsails/lspkind.nvim', commit = 'f46e3b5528e73347dc0678277460e5cea2a52b6a' }
  use { 'ray-x/cmp-treesitter', commit = 'c2886bbb09ef6daf996a258db29546cc1e7c12a7' }
  use { 'saadparwaiz1/cmp_luasnip', commit = 'a9de941bcbda508d0a45d28ae366bb3f08db2e36' }

  -- Snippets
  use { 'L3MON4D3/LuaSnip', commit = 'd049b3dbefee5d0a6d0bfbd913dfaa89ded0457f' }
  use { 'rafamadriz/friendly-snippets', commit = '2be79d8a9b03d4175ba6b3d14b082680de1b31b1' }

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', commit = 'ba752cee137986882e4f0faa0cc81e810ab28371'}
  use { 'nvim-treesitter/nvim-treesitter-refactor', commit = '75f5895cc662d61eb919da8050b7a0124400d589' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', commit = 'e63c2ff8e38fad77299dd74e14c7c9360e1b3181' }
  use { 'nvim-treesitter/nvim-treesitter-context', commit = '3148205c72a535af0493fec7c90a12344ac2f90d' }
  use { 'nvim-treesitter/playground', commit = 'bcfab84f98a33f2ad34dda6c842046dca70aabf6' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring', commit = '4d3a68c41a53add8804f471fcc49bb398fe8de08' }
  use { 'RRethy/nvim-treesitter-textsubjects', commit = 'ed026cfdff93b2d63d9d8cd2525481d8f002f65e' }
  use { 'theHamsta/nvim-treesitter-pairs', commit = '68a8d3d0bebc9173e862b9f8c5957b7f82cd0d60' }
  use { 'ziontee113/syntax-tree-surfer', commit = 'd6d518f48dcc4441b11ee3e6cefd48fa1e09568a' }
  use { 'windwp/nvim-ts-autotag', commit = 'fdefe46c6807441460f11f11a167a2baf8e4534b' }
  use { 'p00f/nvim-ts-rainbow', commit = 'fad8badcd9baa4deb2cf2a5376ab412a1ba41797' }
  use { 'abecodes/tabout.nvim', commit = 'be655cc7ce0f5d6d24eeaf8b36e82693fd2facca' }
  use { 'mfussenegger/nvim-treehopper', commit = "674e9f28815eb9bff1bb11d1f557e4221df05b32" }

  -- Marks
  use { 'ThePrimeagen/harpoon', commit = 'f4aff5bf9b512f5a85fe20eb1dcf4a87e512d971' }
  use { 'chentoast/marks.nvim', commit = 'b27cbb78e9082229590b396d3ae4fe07f1aeafe0' }

  -- Fold text

  -- Buffer
  use { 'ghillb/cybu.nvim', commit = '43b68850ac370c583e95ff136f65b144859470dc'}
  use { 'moll/vim-bbye', commit = '25ef93ac5a87526111f43e5110675032dbcacf56' }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', commit = '30e2dc5232d0dd63709ef8b44a5d6184005e8602' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', commit = '65c0ee3d4bb9cb696e262bca1ea5e9af3938fc90' }
  use { 'nvim-telescope/telescope-project.nvim', commit = 'dc9a1977d159e3feb98774729f5c30584e2b700a' }
  use { 'nvim-telescope/telescope-dap.nvim', commit = 'b4134fff5cbaf3b876e6011212ed60646e56f060' }
  use { 'dhruvmanila/telescope-bookmarks.nvim', commit = 'a357ecbfa9aaff607a9bf864ad4ad78255df30d8' }
  use { 'nvim-telescope/telescope-ui-select.nvim', commit = '62ea5e58c7bbe191297b983a9e7e89420f581369' }

  -- Note taking apps
  use { 'nvim-neorg/neorg', tag = '0.0.12' }

  -- Color
  use { 'norcalli/nvim-colorizer.lua', commit = '36c610a9717cc9ec426a07c8e6bf3b3abcb139d6' }

  -- Colorscheme
  use { 'shaunsingh/nord.nvim', commit = '209e9b394879e80beeed7fb923a8bec239b7b327' }
  use { 'ray-x/starry.nvim', commit = '1660f1a4c26d2c35d010c4012ea206b36df82901' }
  use { 'rebelot/kanagawa.nvim', commit = "dda1b8c13e0e7588c014064e5e8baf7f2953dd29" }
  use { 'catppuccin/nvim', commit = "4880f23b12901d7337d196f18680700d5db927d2" }

  -- Utility
  use { 'mbbill/undotree', commit = 'bf76bf2d1a097cda024699738286fa81fb6529ac' }
  use { 'antoinemadec/FixCursorHold.nvim', commit = '70a9516a64668cbfe59f31b66d0a21678c5e9b12' }
  use { 'tyru/open-browser.vim', commit = '80ec3f2bb0a86ac13c998e2f2c86e16e6d2f20bb' }
  use { 'kevinhwang91/nvim-hlslens', commit = '00a87287456860851bdefc934af129316dfe1c4c' }
  use { 'tpope/vim-repeat', commit = '24afe922e6a05891756ecf331f39a1f6743d3d5a' }
  use { 'bennypowers/nvim-regexplainer', commit = '0d7151ddd3ff2b2e9e8a69137b911c28fc7051a4' }
  use { 'MunifTanjim/nui.nvim', commit = 'e9889bbd9919544697d497537acacd9c67d0de99' }
  use { 'luukvbaal/stabilize.nvim', commit = 'f7c4d93d6822df1770a90b7fdb46f6df5c94052e' }
  use { 'kwkarlwang/bufjump.nvim', commit = 'a020f81bb82f758da51594a07bfcb9635a6b0f73' }
  use { 'rcarriga/nvim-notify', commit = '7a9be08986b4d98dd685a6b40a62fcba19c1ad27' }

  -- Icon
  use { 'kyazdani42/nvim-web-devicons', commit = '969728506c0175644a1d448f55e311ccdada7eaf' }

  -- Statusline
  use { 'nvim-lualine/lualine.nvim', commit = 'a52f078026b27694d2290e34efa61a6e4a690621' }

  -- Startup
  use { 'goolord/alpha-nvim', commit = '0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31' }

  -- Indent
  use { 'lukas-reineke/indent-blankline.nvim', commit = 'db7cbcb40cc00fc5d6074d7569fb37197705e7f6' }

  -- File explorer
  use { 'kyazdani42/nvim-tree.lua', commit = '3676e0b124c2a132857e2bbcf7f48f05228f1052' }

  -- Comment
  use { 'folke/todo-comments.nvim', commit = '02eb3019786d9083b93ab9457761899680c6f3ec' }
  use { 'numToStr/Comment.nvim', commit = '30d23aa2e1ba204a74d5dfb99777e9acbe9dd2d6' }

  -- Session
  -- use { "olimorris/persisted.nvim", commit = "b54b72dbded2f553b6973abf73e0a86ea1be284f" }

  -- Quickfix
  use { 'folke/trouble.nvim', commit = '929315ea5f146f1ce0e784c76c943ece6f36d786' }

  -- Code runner

  -- Git
  use { 'lewis6991/gitsigns.nvim', commit = 'f98c85e7c3d65a51f45863a34feb4849c82f240f' }

  -- Github

  -- Editing support
  use { 'karb94/neoscroll.nvim', commit = '54c5c419f6ee2b35557b3a6a7d631724234ba97a' }
  use { 'windwp/nvim-autopairs', commit = '14cc2a4fc6243152ba085cc2059834113496c60a' }
  use { 'nacro90/numb.nvim', commit = '453c50ab921fa066fb073d2fd0f826cb036eaf7b' }
  use { 'Pocco81/true-zen.nvim', commit = '98740c76254c65576ec294551028b65081053588' }

  -- Editor config
  use { 'tpope/vim-sleuth', commit = "1d25e8e5dc4062e38cab1a461934ee5e9d59e5a8" }

  -- Motion
  use { 'tpope/vim-surround', commit = "bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea" }
  use { 'ggandor/leap.nvim', commit = 'aba53d7a8870426bea89eeca6c3b265d1f94c584' }
  use { 'junegunn/vim-easy-align', commit = '12dd6316974f71ce333e360c0260b4e1f81169c3' }

  -- Keybind
  use { 'folke/which-key.nvim', commit = '6885b669523ff4238de99a7c653d47b081b5506d' }

  -- API
  use { 'NtBBloodbath/rest.nvim', commit = '33e91991efcf0ee89fa72f3fd2b3d6303cb3485e' }

  -- DAP core
  use { 'mfussenegger/nvim-dap', commit = '58d7097f0711a9b9bd86f73e0e4614b419696b84' }
  use { 'theHamsta/nvim-dap-virtual-text', commit = '2971ce3e89b1711cc26e27f73d3f854b559a77d4' }
  use { 'rcarriga/nvim-dap-ui', commit = 'ebebd429f88bcf656d4c78dec201a8be73a76156' }

  -- DAP utility
  use { 'jbyuki/one-small-step-for-vimkind', commit = '59ec6f57545a42e68995994bfa57479da5e68b74' }
  use { 'mxsdev/nvim-dap-vscode-js', commit = '32b0b9f735fc7e352194b6c9a8f540277ec83fe3' }
  use { 'mfussenegger/nvim-dap-python', commit = '358fb85b05b9c99546c0b37f5c5fb72548cffe3c' }

  -- DAP adapter
  use { 'microsoft/vscode-js-debug', opt = true, run = 'npm install --legacy-peer-deps && npm run compile', commit = '227b5b5a516663255d07fae7e9262916cb2ab05a',}

  -- Test runner
  use { 'nvim-neotest/neotest', commit = '15c0bb23431d165300507573b0ae29debd57ea29' }
  use { 'haydenmeade/neotest-jest', commit = 'cedda8ae1b5c1672e87767b61379b38c5be7a7db' }

  -- Terminal
  use { 'akinsho/toggleterm.nvim', commit = '2a787c426ef00cb3488c11b14f5dcf892bbd0bda' }
  use { 'christoomey/vim-tmux-navigator', commit = 'afb45a55b452b9238159047ce7c6e161bd4a9907' }

  -- Markdown
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
    commit = '02cc3874738bc0f86e4b91f09b8a0ac88aef8e96',
  }
  use { 'mzlogin/vim-markdown-toc', commit = '7ec05df27b4922830ace2246de36ac7e53bea1db' }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
