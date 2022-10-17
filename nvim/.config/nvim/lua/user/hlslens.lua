local hlslens_ok, hlslens = pcall(require, "hlslens")

if not hlslens_ok then
    return
end

local opts = { silent = true }
local keymap = vim.keymap.set
local hl = vim.api.nvim_set_hl

keymap( "n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
keymap( "n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
keymap( "n", "*", [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], opts)
keymap( "n", "#", [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], opts)
keymap( "n", "g*", [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], opts)
keymap( "n", "g#", [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], opts)
keymap( "x", "*", [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], opts)
keymap( "x", "#", [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], opts)

local cfg = {
    calm_down = true,
    nearest_only = false,
    nearest_float_when = "auto",
    override_lens = function(render, posList, nearest, idx, relIdx)
        local sfw = vim.v.searchforward == 1
        local indicator, text, chunks
        local absRelIdx = math.abs(relIdx)
        if absRelIdx > 1 then
            indicator = ("%d%s"):format(
                absRelIdx,
                sfw ~= (relIdx > 1) and "▲" or "▼"
            )
        elseif absRelIdx == 1 then
            indicator = sfw ~= (relIdx == 1) and "▲" or "▼"
        else
            indicator = ""
        end

        local lnum, col = unpack(posList[idx])
        if nearest then
            local cnt = #posList
            if indicator ~= "" then
                text = ("[%s %d/%d]"):format(indicator, idx, cnt)
            else
                text = ("[%d/%d]"):format(idx, cnt)
            end
            chunks = { { " ", "Ignore" }, { text, "HlSearchLensNear" } }
        else
            text = ("[%s %d]"):format(indicator, idx)
            chunks = { { " ", "Ignore" }, { text, "HlSearchLens" } }
        end
        render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
    end,
    hl(0, "HlSearchLens", { bg = "#2c4c6b", fg = "#ffffff" }),
    hl(0, "HlSearchLensNear", { bg = "#81a1c1", fg = "#eceff4" }),
}

hlslens.setup(cfg)
