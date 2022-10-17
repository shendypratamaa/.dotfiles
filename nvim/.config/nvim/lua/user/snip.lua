local luasnip_ok, ls  = pcall(require, "luasnip")
local types_ok, types = pcall(require, "luasnip.util.types")

if not luasnip_ok and types_ok then
    return
end

require("luasnip.loaders.from_vscode").lazy_load()

local cfg = {
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

ls.config.set_config(cfg)
