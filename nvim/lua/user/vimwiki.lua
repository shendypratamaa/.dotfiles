function vimwiki()
  vim.g.vimwiki_list = {
    {
      path = "~/.notes/",
      syntax = "markdown",
      ext = ".md",
    },
  }
end

return vimwiki()
