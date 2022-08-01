local neorg_ok, neorg = pcall(require, "neorg")

if not neorg_ok then
  return
end

neorg.setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          notes = "~/.notes",
        },
      },
    },
  },
}
