now_if_args(function()
    add({
        source = 'nvim-treesitter/nvim-treesitter',
        hooks = { postcheckout = function() vim.cmd.TSUpdate() end }
    })

    add({
        source = 'nvim-treesitter/nvim-treesitter-textobjects',
    })

    local treesitter = require('nvim-treesitter')
    local avail = treesitter.get_available()
    local ins = treesitter.get_installed()

    create_autocmd('FileType', 'nvim-treesitter setup', {
        callback = function(ev)
            local match = vim.treesitter.language.get_lang(ev.match)

            if (tbl_contains(avail, match) and not tbl_contains(ins, match)) then
                treesitter.install(match):wait(30000)
                ins = treesitter.get_installed()
            end

            if (tbl_contains(ins, match)) then
                vim.treesitter.start()
                vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo[0][0].foldmethod = 'expr'
                vim.bo.indentexpr = 'v:lua.require(\'nvim-treesitter\').indentexpr()'
            end
        end
    })
end)
