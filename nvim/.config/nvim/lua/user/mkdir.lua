local fn = vim.fn

local mkdir = vim.api.nvim_create_augroup("Mkdir", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = mkdir,
    callback = function()
        local dir = fn.expand("<afile>:p:h")

        if dir:find("%l+://") == 1 then
            return
        end

        if fn.isdirectory(dir) == 0 then
            fn.mkdir(dir, "p")
            vim.notify(" 🤖 Missing directory was created at : " .. dir)
        end
    end,
})
