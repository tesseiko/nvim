if true then
  return {}
end

vim.g.vimwiki_list = {
  {
    path = "~/vimwiki/src/",
    syntax = "markdown",
    ext = ".md",
  },
}
vim.g.vimwiki_ext2syntax = {
  [".md"] = "markdown",
  [".markdown"] = "markdown",
  [".mdown"] = "markdown",
}
vim.g.vimwiki_folding = "syntax"
