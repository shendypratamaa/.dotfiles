local rest_ok, rest = pcall(require, "rest-nvim")

if not rest_ok then
    return
end

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local cfg = {
    result_split_horizontal = false,
    result_split_in_place = false,
    skip_ssl_verification = false,
    encode_url = true,
    highlight = {
        enabled = true,
        timeout = 150,
    },
    result = {
        show_url = true,
        show_http_info = true,
        show_headers = true,
        formatters = {
            json = "jq",
            html = function(body)
                return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end,
        },
    },
    jump_to_request = false,
    env_file = ".env",
    custom_dynamic_variables = {},
    yank_dry_run = true,
}

keymap("n", "rr", "<Plug>RestNvim<CR>", opts)
keymap("n", "rx", "<Plug>RestNvimPreview<CR>", opts)
keymap("n", "rl", "<Plug>RestNvimLast<CR>", opts)

rest.setup(cfg)
