later(function()
    add({ 'https://github.com/mfussenegger/nvim-lint' })

    _G.nvim_lint = require('lint')

    nvim_lint.linters_by_ft = {
        yaml = { 'yamllint' }
    }

    create_autocmd('BufWritePost', 'nvim-lint lint', {
        callback = function()
            nvim_lint.try_lint()
        end
    })
end)
