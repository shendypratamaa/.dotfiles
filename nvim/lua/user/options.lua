local options = {
  syntax = "on",
  exrc = true,
  autoread = true,
  filetype = "plugin_indent_on",
  fileencoding = "utf8",
  hidden = true,
  number = true,
  virtualedit = "block",
  relativenumber = true,
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 1,
  completeopt = { "menuone", "noselect" },
  conceallevel = 0,
  hlsearch = true,
  incsearch = true,
  mouse = "a",
  pumheight = 10,
  splitright = true,
  splitbelow = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 200,
  updatetime = 300,
  writebackup = false,
  cursorline = true,
  signcolumn = "yes",
  wrap = false,
  scrolloff = 8,
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  numberwidth = 2,
  expandtab = true,
  smartindent = true,
  autoindent = true,
  smartcase = true,
  ignorecase = true,
  colorcolumn = "80",
  sidescrolloff = 8,
  guifont = "JetBrainsMono Nerd Font Mono:h12",
  guicursor = "",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- BUG: When active cant recognize recent files, fold, marks, etc
vim.o.shada = "'0,f0"
vim.opt.shortmess:append "c"
vim.g.cursorhold_updatetime = 100
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.netrw_browsex_viewer = "open"
vim.g.did_load_filetypes = 1
