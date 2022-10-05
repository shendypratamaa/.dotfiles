local select = {
  enable    = true,
  lookahead = true,
  keymaps   = {
    ["af"]  = "@function.outer",
    ["if"]  = "@function.inner",
    ["ac"]  = "@class.outer",
    ["ic"]  = "@class.inner",
  },
  selection_nodes        = {
    ["@parameter.outer"] = "v",
    ["@function.outer"]  = "V",
    ["@class.outer"]     = "<c-v>",
  },
  include_surrounding_whitespace = true,
}

local swap = {
  enable          = true,
  swap_next       = {
    ["<leader>a"] = "@parameter.inner",
  },
  swap_previous   = {
    ["<leader>A"] = "@parameter.inner",
  },
}

local move = {
  enable              = true,
  set_jumps           = true,
  goto_next_start     = {
    ["]m"]            = "@function.outer",
    ["]]"]            = "@class.outer",
  },
  goto_next_end       = {
    ["]M"]            = "@function.outer",
    ["]["]            = "@class.outer",
  },
  goto_previous_start = {
    ["[m"]            = "@function.outer",
    ["[["]            = "@class.outer",
  },
  goto_previous_end   = {
    ["[M"]            = "@function.outer",
    ["[]"]            = "@class.outer",
  },
}

local lsp_interop = {
  enable               = true,
  border               = "none",
  peek_definition_code = {
    ["<leader>df"]     = "@function.outer",
    ["<leader>dF"]     = "@class.outer",
  },
}

return  {
  select      = select,
  swap        = swap,
  move        = move,
  lsp_interop = lsp_interop
}
