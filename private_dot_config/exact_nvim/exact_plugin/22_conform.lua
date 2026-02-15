later(function()
    add('stevearc/conform.nvim')

    _G.Conform = require('conform')
    Conform.setup({
        default_format_opts = {
            lsp_format = 'fallback'
        },
        format_on_save = {
            timeout_ms = 500,
        },
        formatters_by_ft = {
            yaml = { 'yamlfmt' }
        }
    })

    vim.o.formatexpr = 'v:lua.Conform.formatexpr()'
end)
