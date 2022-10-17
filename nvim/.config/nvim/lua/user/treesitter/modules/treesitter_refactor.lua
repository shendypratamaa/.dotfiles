local refactor = {
    highlight_definitions = {
        enable = true,
        clear_on_cursor_move = true,
        highlight_current_scope = {
            enable = true,
        },
    },
    smart_rename = {
        enable = false,
        keymaps = {
            smart_rename = "grr",
        },
    },
    navigation = {
        enable = true,
        keymaps = {
            goto_definition = "gnd",
            list_definitions = "gnD",
            list_definitions_toc = "gO",
            goto_next_usage = "-",
            goto_previous_usage = "=",
        },
    },
}

return {
    refactor = refactor,
}
