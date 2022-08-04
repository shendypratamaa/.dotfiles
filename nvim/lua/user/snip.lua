local luasnip_ok, ls = pcall(require, "luasnip")
local types_ok, types = pcall(require, "luasnip.util.types")

if not luasnip_ok and types_ok then
  return
end

ls.config.set_config {
  history = true,
  updateevents = "TextChanged, TextChangedI",
  enable_autosnippets = true,
  ext_ops = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-", "Error" } },
      },
    },
  },
}
