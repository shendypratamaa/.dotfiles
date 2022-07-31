local options = {
  syntax = "on",
  exrc = true,
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
  guifont = "monospace:h17",
  guicursor = "",
}

vim.opt.shortmess:append "c"
vim.g.cursorhold_updatetime = 100
vim.opt.shada = "'0,f0" -- remove marks when open vim

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd [[
  let g:rooter_patterns = ['.git', 'package.json', '!node_modules']
]]

vim.cmd [[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]]

vim.cmd [[
  fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endfun
  augroup neovim_rocks
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
  augroup END
]]

vim.cmd [[
  augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
  augroup END
]]

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "NvimTree" then
      require("bufferline.state").set_offset(31, "FileTree")
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*",
  callback = function()
    if vim.fn.expand("<afile>"):match "NvimTree" then
      require("bufferline.state").set_offset(0)
    end
  end,
})

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]]
vim.cmd [[set nocompatible ]]
