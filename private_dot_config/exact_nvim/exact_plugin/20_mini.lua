now(function()
    require('mini.basics').setup({
        options = {
            extra_ui = true,
            win_borders = 'bold'
        },
        mappings = {
        },
        autocommands = {
            relnum_in_visual_mode = true
        }
    })
end)

now(function()
    local ext3_blocklist = { scm = true, txt = true, yml = true }
    local ext4_blocklist = { json = true, yaml = true }
    require('mini.icons').setup({
        use_file_extension = function(ext, _)
            return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
        end,
        style = 'ascii'
    })

    later(MiniIcons.mock_nvim_web_devicons)
    later(MiniIcons.tweak_lsp_kind)
end)

now(function()
    require('mini.notify').setup({
        window = {
            config = {
                border = 'none'
            },
            max_width_share = 1.0
        }
    })
end)

now(function()
    local diag = vim.diagnostics
    local section_diag = function()
        local ce = #(diag.get(nil, { severity = diag.severity.ERROR }))
        local cw = #(diag.get(nil, { severity = diag.severity.WARN }))
        local ci = #(diag.get(nil, { severity = diag.severity.INFO }))
        local ch = #(diag.get(nil, { severity = diag.severity.HINT }))

        local e = (ce > 0) and 'E' .. ce .. ' ' or ''
        local w = (cw > 0) and 'W' .. cw .. ' ' or ''
        local i = (ci > 0) and 'I' .. ci .. ' ' or ''
        local h = (ch > 0) and 'H' .. ch .. ' ' or ''

        return vim.trim(e .. w .. i .. h)
    end

    local active = function()
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
        local diagnostics   = section_diag
        local filename      = '%t'
        local fileinfo      = vim.bo.filetype
        local location      = '%l:%v'

        return MiniStatusline.combine_groups({
            { hl = mode_hl,                 strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { diagnostics } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl,                  strings = { location } },
        })
    end

    require('mini.statusline').setup({
        content = { active = active },
        use_icons = false
    })
end)

-- later
later(function() require('mini.extra').setup() end)

later(function() require('mini.bracketed').setup() end)

later(function() require('mini.bufremove').setup() end)

later(function()
    local MiniClue = require('mini.clue')
    MiniClue.setup({
        window = {
            config = {
                width = 'auto',
                border = 'none'
            },
            delay = 0,
        },

        triggers = {
            { mode = { n, x }, keys = '<Leader>' },
            { mode = n,        keys = '\\' },
            { mode = n,        keys = '[' },
            { mode = n,        keys = ']' },
            { mode = i,        keys = '<C-x>' },
            { mode = { n, x }, keys = 'g' },
            { mode = { n, x }, keys = "'" },
            { mode = { n, x }, keys = '`' },
            { mode = { n, x }, keys = '"' },
            { mode = { i, c }, keys = '<C-r>' },
            { mode = n,        keys = '<C-w>' },
            { mode = n,        keys = 's' },
            { mode = { n, x }, keys = 'z' },
        },

        clues = {
            MiniClue.gen_clues.square_brackets(),
            MiniClue.gen_clues.builtin_completion(),
            MiniClue.gen_clues.g(),
            MiniClue.gen_clues.marks(),
            MiniClue.gen_clues.registers(),
            MiniClue.gen_clues.windows(),
            MiniClue.gen_clues.z(),
            {
                { mode = n, keys = '<Leader>b', desc = '+Buffer' },
                { mode = n, keys = '<Leader>f', desc = '+Fuzzy Finder' },
                { mode = n, keys = '<Leader>g', desc = '+Git' },
                { mode = n, keys = '<Leader>l', desc = '+Language' }
            },
        },
    })
end)

later(function() require('mini.cmdline').setup() end)

later(function() require('mini.comment').setup() end)

later(function()
    local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }

    local process_items = function(items, base)
        return MiniCompletion.default_process_items(items, base, process_items_opts)
    end

    require('mini.completion').setup({
        lsp_completion = {
            source_func = 'omnifunc',
            auto_setup = false,
            process_items = process_items
        }
    })

    create_autocmd('LspAttach', 'mini.completion omnifunc', {
        callback = function(ev)
            vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
        end
    })

    vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
end)

later(function() require('mini.diff').setup() end)

later(function() require('mini.files').setup() end)

later(function() require('mini.git').setup() end)

later(function()
    require('mini.keymap').setup()
    local map_multistep = MiniKeymap.map_multistep
    local map_combo = MiniKeymap.map_combo

    -- smarttab
    local tab_steps = { 'pmenu_next' }
    map_multistep(i, '<Tab>', tab_steps)

    local shifttab_steps = { 'pmenu_prev' }
    map_multistep(i, '<S-Tab>', shifttab_steps)

    map_multistep(i, '<CR>', { 'pmenu_accept' })

    -- search hl
    local escesc = function() vim.cmd('nohlsearch') end
    map_combo(nvic, '<Esc><Esc>', escesc)
end)

later(function() require('mini.move').setup() end)

later(function() require('mini.operators').setup() end)

later(function()
    require('mini.pick').setup({
        window = {
            config = function()
                return {
                    border = 'none',
                    width = vim.o.columns
                }
            end
        }
    })
end)

later(function() require('mini.surround').setup() end)
