local present, alpha = pcall(require, "alpha")

if not present then
  return
end

local header = {
  type = "text",
  val = {
    [[ ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓  █████▒██▓ ██▀███  ▓█████  ]],
    [[ ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒▓██   ▒▓██▒▓██ ▒ ██▒▓█   ▀  ]],
    [[▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░▒████ ░▒██▒▓██ ░▄█ ▒▒███    ]],
    [[▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ░▓█▒  ░░██░▒██▀▀█▄  ▒▓█  ▄  ]],
    [[▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒░▒█░   ░██░░██▓ ▒██▒░▒████▒ ]],
    [[░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ ▒ ░   ░▓  ░ ▒▓ ░▒▓░░░ ▒░ ░ ]],
    [[░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ ░      ▒ ░  ░▒ ░ ▒░ ░ ░  ░ ]],
    [[   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    ░ ░    ▒ ░  ░░   ░    ░    ]],
    [[         ░    ░  ░    ░ ░        ░   ░         ░           ░     ░        ░  ░ ]],
    [[                                ░                                              ]],
  },
  opts = {
    position = "center",
    hl = "comment",
  },
}

local handle =
  io.popen 'fd -d 2 . $HOME"/.local/share/nvim/site/pack/packer/" | ghead -n -2 | wc -l | tr -d "\n" '
local plugins = handle:read "*a"
handle:close()

local thingy =
  io.popen 'echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"'
local date = thingy:read "*a"
thingy:close()

local plugin_count = {
  type = "text",
  val = "└─ 🌊 " .. plugins .. " plugins ++ ─┘",
  opts = {
    position = "center",
    hl = "comment",
  },
}

local heading = {
  type = "text",
  val = "┌─   Today is " .. date .. " ─┐",
  opts = {
    position = "center",
    hl = "comment",
  },
}

local footer = {
  type = "text",
  val = {
    " Create with 💘 https://github.com/shendypratamaa 🙋",
    " AGPL - 3.0 License 👮",
  },
  opts = {
    position = "center",
    hl = "comment",
  },
}

local fortune = require "alpha.fortune"

local marks = {
  type = "text",
  val = fortune(),
  opts = {
    position = "center",
    hl = "comment",
  },
}

local function button(sc, txt, keybind)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 5,
    width = 50,
    align_shortcut = "right",
    hl_shortcut = "RedSign",
    hl = "comment",
  }

  if keybind then
    opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

local buttons = {
  type = "group",
  val = {
    button(
      "p",
      "🍔 --> Telescope Project ",
      ":lua require('telescope').extensions.project.project{display_type ='full'}<CR>"
    ),
    button(
      "f",
      "💻 --> Find Files",
      ":lua require('telescope.builtin').find_files()<CR>"
    ),
    button("e", "📖 --> New Files", ":e newfiles<CR>"),
    button("z", "🪐 --> Configuration Zshell", ":e ~/.zshrc<cr>"),
    button(
      "d",
      "🦕 --> Configuration Dashboard",
      ":e ~/.config/nvim/lua/user/dashboard.lua<cr>"
    ),
    button("q", "👻 --> Quit Neovim", ":qa<cr>"),
  },
  opts = {
    spacing = 1,
  },
}

local section = {
  header = header,
  buttons = buttons,
  plugin_count = plugin_count,
  heading = heading,
  footer = footer,
  marks = marks,
}

local opts = {
  layout = {
    { type = "padding", val = 5 },
    section.header,
    { type = "padding", val = 1 },
    section.heading,

    section.plugin_count,
    { type = "padding", val = 1 },
    section.buttons,
    { type = "padding", val = 0 },
    section.footer,
    { type = "padding", val = 0 },
    section.marks,
  },
  opts = {
    margin = 0,
  },
}

alpha.setup(opts)

--[[    .-.__      \ .-.  ___  __                    ]]
--[[|_|  '--.-.-(   \/\;;\_\.-._______.-.            ]]
--[[(-)___     \ \ .-\ \;;\(   \       \ \           ]]
--[[ |    '---._\_((Q)) \;;\\ .-\     __(_)          ]]
--[[ |           __'-' / .--.((Q))---'    \,         ]]
--[[ |     ___.-:    \|  |   \'-'_          \        ]]
--[[ |  .-'      \ .-.\   \   \ \ '--.__     '\      ]]
--[[ |  |____.----((Q))\   \__|--\_      \     '     ]]
--[[    (-)        '-'  \_  :  \-' '--.___\          ]]
--[[     |                \  \  \       \(_)         ]]
--[[     |                 \  \  \         \,        ]]
--[[     |                  \  \  \          \       ]]
--[[     |                   \  \  \          '\     ]]
--[[     |                 \  \__|  \        '       ]]
--[[                           \_:.  \               ]]
--[[                             \ \  \              ]]
--[[                              \ \  \             ]]
