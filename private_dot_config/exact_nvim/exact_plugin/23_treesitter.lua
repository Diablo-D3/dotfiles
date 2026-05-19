now_if_args(function()
    add({
        'https://github.com/nvim-treesitter/nvim-treesitter',
        'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    })

    on_packchanged('nvim-treesitter', { 'update' }, ':TSUpdate',
        function()
            vim.cmd.TSUpdate()
        end
    )

    _G.nvim_treesitter = require('nvim-treesitter')

    create_autocmd('FileType', 'nvim-treesitter setup',
        function(ev)
            local match = vim.treesitter.language.get_lang(ev.match)

            local avail = nvim_treesitter.get_available()
            local ins = nvim_treesitter.get_installed()

            if (tbl_contains(avail, match) and not tbl_contains(ins, match)) then
                nvim_treesitter.install(match):wait(30000)
                ins = nvim_treesitter.get_installed()
            end

            if (tbl_contains(ins, match)) then
                vim.treesitter.start(ev.buf)
                vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo[0][0].foldmethod = 'expr'
                vim.bo.indentexpr = 'v:lua.require(\'nvim-treesitter\').indentexpr()'
            end
        end
    )

    -- Originally from https://github.com/ngynkvn/gotmpl.nvim, which seems to be abandoned
    -- Includes changes from:
    -- ngynkvn/gotmpl.nvim#1 from eggplannt: "fixed edge cases and moved query to inline lua"
    -- ngynkvn/gotmpl.nvim#2 from pddshk: "merge scm file into already loaded with '; extends'"
    -- Further modifications are mine
    vim.treesitter.query.add_directive('inject-go-tmpl!', function(_, _, bufnr, _, metadata)
        local fname = vim.api.nvim_buf_get_name(bufnr + 0):match("(.+).tmpl$")
        local ft = vim.filetype.match({ buf = bufnr + 0, filename = fname })

        if not ft then
            return
        end

        metadata['injection.language'] = ft
    end, {})

    -- override .tmpl to be "gotmpl" and not "template"
    vim.filetype.add({
        extension = {
            tmpl = 'gotmpl',
        },
    })

    vim.treesitter.query.set('gotmpl', 'injections', [[
        ; extends
        ((text) @injection.content
            (#inject-go-tmpl!)
            (#set! injection.combined)
            (#set! injection.include-children))
        ]]
    )
end)
