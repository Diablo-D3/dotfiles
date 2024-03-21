------------
-- global --
------------

local vim = vim

local keyopts = { silent = true }
local local_keyopts = { silent = true, buffer = true }
local augroup = vim.api.nvim_create_augroup('init', {})

local function keymap(mode, lhs, desc, rhs, opts)
    return vim.keymap.set(mode, lhs, rhs,
        vim.tbl_extend("force", vim.tbl_extend("force", keyopts, { desc = desc }), opts or {})
    )
end

local function keycode(key) return vim.keycode(key) end
local function feedkeys(key) return vim.fn.feedkeys(key, 'n') end

vim.cmd.helptags('ALL')

-- options
vim.o.swapfile = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true
vim.o.gdefault = true

-- if in fish, use sh instead
if (not not vim.o.shell:match('fish$')) then
    vim.o.shell = "sh"
end

-- terminal
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.cmd.startinsert()
    end,
})

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = 'term://*',
    callback = function()
        vim.cmd.startinsert()
    end
})

vim.api.nvim_create_autocmd('BufLeave', {
    pattern = 'term://*',
    callback = function()
        vim.cmd.stopinsert()
    end
})
-- osc52 clipboard
vim.g.clipboard = {
    name = 'OSC 52',

    copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
        ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
        ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
}

vim.opt.clipboard:append('unnamedplus')

-- override ftplugin/rust.vim textwidth
vim.g.rust_recommended_style = 0

vim.api.nvim_create_autocmd('CmdlineLeave', {
    group = augroup,
    callback = function(ev)
        local mods = { silent = true, noautocmd = true, keepalt = true, keeppatterns = true }

        -- split args
        local args = {}
        for arg in vim.fn.getcmdline():gmatch('%S+') do
            table.insert(args, arg)
        end

        local orig_filetype = vim.bo[ev.buf]

        -- match call for :help
        if string.match(args[1] or '', '^h[elp]+$') then
            local tag

            -- process args for tag
            if (#args > 1) then
                local tagpat = args[2]

                local help_buf = vim.api.nvim_create_buf(false, true)
                vim.bo[help_buf].buftype = 'help'
                local tags = vim.api.nvim_buf_call(help_buf, function()
                    return vim.fn.taglist(tagpat)
                end)
                vim.api.nvim_buf_delete(help_buf, { force = true })

                if (#tags > 0) then
                    tag = tags[1]
                else
                    -- use real help to emit error message
                    pcall(vim.cmd.help, args[2])
                    return
                end
            else
                tag = {}
                tag.cmd = '/*help*'
                tag.filename = vim.o.helpfile
            end

            local filename = vim.fn.fnameescape(tag.filename)

            vim.api.nvim_buf_call(ev.buf, function()
                vim.cmd.edit({ args = { filename }, mods = mods })

                vim.bo.buftype = 'nofile'
                vim.bo.buflisted = false
                vim.bo.bufhidden = 'wipe'
                vim.bo.filetype = 'help'

                local has_ts = pcall(vim.treesitter.start, 0)
                if not has_ts then vim.bo.syntax = 'help' end

                local cache_hlsearch = vim.v.hlsearch
                -- Make a "very nomagic" search to account for special characters in tag
                local search_cmd = string.gsub(tag.cmd, '^/', '\\V')
                vim.fn.search(search_cmd)
                vim.v.hlsearch = cache_hlsearch

                -- vim.cmd('normal! zt')
                vim.fn.feedkeys('zt', 'nxt')
            end)

            -- :closehelp unless already in help
            if orig_filetype ~= 'help' then
                vim.api.nvim_create_autocmd('BufAdd', {
                    group = augroup,
                    once = true,
                    callback = function()
                        vim.cmd.helpclose({ mods = mods })
                    end
                })
            end
        end
    end
})

-- keybinds
vim.g.mapleader = ' '

keymap({ 'x', 'n' }, ';', 'Command mode', ':', { silent = false })
keymap({ 'x', 'n' }, ':', 'Repeat f or t', ';', { silent = false })

keymap('n', '<leader>q', 'Close window', function() vim.api.nvim_win_close(0, true) end)
keymap('n', '<leader>v', 'Split view', function() vim.cmd.split() end)

------------------------
-- base functionality --
------------------------

-- autosplit.nvim
-- https://github.com/ii14/autosplit.nvim
vim.cmd [[
    set splitright

    let g:autosplit_loaded = 1
    au WinNew * lua require('autosplit')()
]]

-- mini.nvim
-- https://github.com/echasnovski/mini.nvim

-- mini.basics
require('mini.basics').setup({})

vim.o.signcolumn = 'no'

-- mini.extra
local mini_extra = require('mini.extra')
mini_extra.setup({})

-- mini.ai
local mini_ai = require('mini.ai')
mini_ai.setup({
    n_lines = 9001,
    search_method = 'cover_or_nearest'
})

-- mini.bracketed
require('mini.bracketed').setup({})

-- mini.bufremove
local mini_bufremove = require('mini.bufremove')
mini_bufremove.setup({})
vim.keymap.set('n', '<C-w>', function() mini_bufremove.wipeout(0, false) end, keyopts)

-- mini.clue
local mini_clue = require('mini.clue')
mini_clue.setup({
    triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
    },

    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        mini_clue.gen_clues.builtin_completion(),
        mini_clue.gen_clues.g(),
        mini_clue.gen_clues.marks(),
        mini_clue.gen_clues.registers(),
        mini_clue.gen_clues.windows(),
        mini_clue.gen_clues.z(),
    },
})

-- mini.comment
require('mini.comment').setup({})

-- mini.complete
require('mini.completion').setup({
    delay = { completion = 4294967295 }
})

local function tab_complete(shift)
    if (vim.fn.pumvisible() == 1) then return feedkeys(shift and keycode('<C-P>') or keycode('<C-N>')) end

    local line = vim.api.nvim_get_current_line()
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    local not_at_whitespace = line:sub(pos, pos):find('%s') == nil
    if (not_at_whitespace and pos > 1) then return feedkeys(keycode('<C-X><C-O>')) end

    feedkeys(shift and keycode('<S-Tab>') or keycode('<Tab>'))
end

keymap('i', '<Tab>', '<Tab>', function() tab_complete(false) end)
keymap('i', '<S-Tab>', '<S-Tab>', function() tab_complete(true) end)

local function cr_complete()
    if (vim.fn.pumvisible() == 0) then return feedkeys(keycode('<CR>')) end
    local has_selected = vim.fn.complete_info()['selected'] ~= -1
    feedkeys(has_selected and keycode('<C-Y>') or keycode('<C-Y><CR>'))
end

keymap('i', '<CR>', '<CR>', cr_complete)

-- mini.hipatterns
local mini_hipatterns = require('mini.hipatterns')

mini_hipatterns.setup({
    highlighters = {
        fixme      = { pattern = { '[Ff][Ii][Xx][Mm][Ee]' }, group = 'DiagnosticError' },
        hack       = { pattern = { '[Hh][Aa][Cc][Kk]' }, group = 'DiagnosticWarn' },
        todo       = { pattern = { '[Tt][Oo][Dd][Oo]' }, group = 'DiagnosticInfo' },
        note       = { pattern = { '[Nn][Oo][Tt][Ee]', }, group = 'DiagnosticHint' },
        rust_error = { pattern = { 'error!' }, group = 'DiagnosticError' },
        rust_warn  = { pattern = { 'dbg!', 'debug!', 'warn!' }, group = 'DiagnosticWarn' },
        rust_info  = { pattern = { 'todo!', 'unimplemented!', 'info!' }, group = 'DiagnosticInfo' },

        hex_color  = mini_hipatterns.gen_highlighter.hex_color(),
    },
})

-- mini.indentscope
local mini_indentscope = require('mini.indentscope')
mini_indentscope.setup({
    draw = {
        delay = 0,
        animation = mini_indentscope.gen_animation.none()
    },
    options = {
        try_as_border = true
    },
    symbol = '│'
})

-- mini.statusline
local mini_statusline = require('mini.statusline')
mini_statusline.setup({
    content = {
        active = function()
            local diagnostics_f = function()
                local ce = #(vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.ERROR }))
                local cw = #(vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.WARN }))
                local ci = #(vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.INFO }))
                local ch = #(vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.HINT }))

                local e = (ce > 0) and 'E' .. ce .. ' ' or ''
                local w = (cw > 0) and 'W' .. cw .. ' ' or ''
                local i = (ci > 0) and 'I' .. ci .. ' ' or ''
                local h = (ch > 0) and 'H' .. ch .. ' ' or ''

                return vim.trim(e .. w .. i .. h)
            end

            local mode, mode_hl = mini_statusline.section_mode({ trunc_width = 1 })
            local diagnostics   = diagnostics_f()
            local filename      = '%t'
            local fileinfo      = vim.bo.filetype
            local location      = '%l:%v'

            return mini_statusline.combine_groups({
                { hl = mode_hl,                 strings = { mode } },
                { hl = 'MiniStatuslineDevinfo', strings = { diagnostics } },
                '%<', -- Mark general truncate point
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                '%=', -- End left alignment
                { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                { hl = mode_hl,                  strings = { location } },
            })
        end
    },
    use_icons = false,
    set_vim_settings = true,
})

vim.o.laststatus = 3
vim.o.cmdheight = 0

-- mini.surround
require('mini.surround').setup({})

-- mini.trailspace
local mini_trailspace = require('mini.trailspace')
mini_trailspace.setup({})

vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup,
    callback = function()
        mini_trailspace.trim()
        mini_trailspace.trim_last_lines()
    end,
})

-- edgy.nvim
-- https://github.com/folke/edgy.nvim
local edgy = require('edgy')
edgy.setup({
    options = {
        right = {
            size = function()
                local half = vim.o.columns / 2
                return math.floor(half <= 120 and half or 120)
            end,
        },
    },
    animate = {
        enabled = false
    },
    wo = {
        winbar = false
    },
    right = {
        'Trouble',
        'fzf',
        'NeogitStatus'
    }
})

vim.opt_local.fillchars:append({
    vert = '\u{2595}',
    horiz = '\u{2581}',
    horizup = '\u{1FB7F}',
    horizdown = '\u{2581}',
    vertleft = '\u{2595}',
    vertright = '\u{2595}',
    verthoriz = '\u{1FB7F}',
})

-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = 'Trouble',
--     callback = function()
--         vim.opt_local.fillchars:append('vert:x')
--     end,
-- })

-----------
-- mason --
-----------

-- mason.nvim and mason-lspconfig.nvim
-- https://github.com/williamboman/mason.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

require('mason').setup()
require('mason-tool-installer').setup({
    ensure_installed = {
        ----------
        -- lsps --
        ----------

        -- c/c++
        'clangd',

        -- css, less, scss
        'css-lsp',

        -- html,
        'html-lsp',

        -- json
        'json-lsp',

        -- lua
        'lua-language-server',

        -- rust
        'rust-analyzer',

        -- toml
        'taplo',

        -- vim
        'vim-language-server',

        -- xml, xsd, xsl, xslt, svg
        'lemminx',

        ----------------
        -- formatters --
        ----------------

        -- markdown
        'prettier',
        'markdownlint',

        -- sh
        -- deb: 'shfmt'

        -------------
        -- linters --
        -------------

        -- sh
        -- deb: 'shellcheck',

        -- vim
        'vint',

        -----------
        -- tools --
        -----------
    },
    auto_update = true,
})

require('mason-tool-installer').clean()

---------
-- lsp --
---------

-- nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig
local lspconfig = require('lspconfig')
vim.api.nvim_create_autocmd('LspAttach', {
    group = augroup,
    callback = function(ev)
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }

        vim.keymap.set('n', 'g.', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    end,
})

lspconfig.clangd.setup({})

lspconfig.cssls.setup({})

lspconfig.html.setup({})

lspconfig.jsonls.setup({})

lspconfig.marksman.setup({})

lspconfig.taplo.setup({})

lspconfig.vimls.setup({})

lspconfig.lemminx.setup({})

-- neodev.nvim
-- https://github.com/folke/neodev.nvim
require('neodev').setup({})

-- Setup luals for non-neovim after neodev
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = "Disable",
            },
            diagnostics = {
                neededFileStatus = {
                    ["codestyle-check"] = "Any"
                }
            }
        }
    }
})

-- fidget.nvim
-- https://github.com/j-hui/fidget.nvim
require('fidget').setup({})

-- lsp_lines.nvim
-- https://git.sr.ht/~whynothugo/lsp_lines.nvim
require('lsp_lines').setup({})

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = {
        only_current_line = true,
        highlight_whole_line = false,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarning',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
        }
    },
    update_in_insert = true,
    severity_sort = true,
})

----------------
-- treesitter --
----------------

-- nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter-refactor
-- https://github.com/nvim-treesitter/nvim-treesitter-context
-- https://gitlab.com/HiPhish/rainbow-delimiters.nvim
require('nvim-treesitter.install').update({
    with_sync = true
})

require('nvim-treesitter.configs').setup({
    auto_install = true,
    highlight = {
        enable = true
    }
})

vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    callback = function(ev)
        local bufnr = ev.buf
        local clients = vim.lsp.get_clients({ bufnr = bufnr })

        for _, client in ipairs(clients) do
            if client.server_capabilities.documentHighlightProvider then
                vim.lsp.buf.clear_references()
                vim.lsp.buf.document_highlight()
                return
            end
        end

        if vim.b['ts_highlight'] then
            require('nvim-treesitter-refactor.highlight_definitions').clear_usage_highlights(bufnr)
            require('nvim-treesitter-refactor.highlight_definitions').highlight_usages(bufnr)
        end
    end,
})

keymap('n', 'gr', 'Rename', function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    for _, client in ipairs(clients) do
        if client.server_capabilities.renameProvider then
            vim.lsp.buf.rename()
            return
        end
    end

    if vim.b['ts_highlight'] then
        require('nvim-treesitter-refactor.smart_rename').smart_rename(0)
        return
    end

    local cmd = '%s/' .. vim.fn.expand('<cword>') .. '//g'
    feedkeys(':' .. cmd .. keycode('<Left><Left>'))
end)

----------------
-- navigation --
----------------

-- trouble.nvim
-- https://github.com/folke/trouble.nvim
local trouble = require('trouble');

trouble.setup({
    auto_open = false,
    auto_close = true,
    action_keys = {
        jump = {},
        jump_close = '<cr>',
    },

    -- remove icons
    icons = false,
    fold_open = 'v',
    fold_closed = '>',
    indent_lines = false,
    signs = {
        error = 'E',
        warning = 'W',
        hint = 'H',
        information = 'I'
    },
    use_diagnostic_signs = false
})

keymap('n', '<leader>d', 'Diagnostics', function()
    trouble.open('workspace_diagnostics')
end)

keymap('n', 'gd', 'Declaration', function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    for _, client in ipairs(clients) do
        if client.server_capabilities.declarationProvider then
            vim.lsp.buf.declaration()
            return
        end
    end

    for _, client in ipairs(clients) do
        if client.server_capabilities.definitionProvider then
            trouble.open('lsp_definitions')
            return
        end
    end

    require('nvim-treesitter-refactor.navigation').goto_definition(0, function()
        feedkeys('gd')
    end)
end)

keymap('n', 'gD', 'Definitions', function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    for _, client in ipairs(clients) do
        if client.server_capabilities.definitionProvider then
            trouble.open('lsp_definitions')
            return
        end
    end

    feedkeys('gD')
end)

keymap('n', 'gt', 'Type Definitions', function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    for _, client in ipairs(clients) do
        if client.server_capabilities.typeDefinitionProvider then
            trouble.open('lsp_type_definitions')
            return
        end
    end

    -- don't do gt = goto next tab page
end)

keymap('n', 'gR', 'LSP References', function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    for _, client in ipairs(clients) do
        if client.server_capabilities.referencesProvider then
            trouble.open('lsp_references')
            return
        end
    end

    -- don't do gR = virtual replace mode
end)

keymap('n', 'gi', 'LSP Implementations', function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    for _, client in ipairs(clients) do
        if client.server_capabilities.implementationProvider then
            trouble.open('lsp_implementations')
            return
        end
    end

    -- don't do gi = insert text
end)

-- fzf-lua
-- https://github.com/ibhagwan/fzf-lua
local fzf = require('fzf-lua')

fzf.setup({
    fzf_opts = {
        ['--color'] = '16,fg+:15,bg+:-1,prompt:-1,hl+:10,query:2',
        ['--layout'] = 'reverse-list'
    },
    buffers = {
        prompt = '> ',
        no_header = true,
        no_header_i = true,
        fzf_opts = {
            ['--info'] = 'hidden'
        },
        winopts = {
            preview = {
                hidden = 'hidden'
            }
        },
    },
    grep = {
        prompt = '> ',
        no_header = true,
        no_header_i = true,
        fzf_cli_args = '--with-nth=4..',
        fzf_opts = {
            ['--info'] = 'hidden'
        },
        winopts = {
            preview = {
                hidden = 'hidden'
            }
        },
    },
    files = {
        prompt = '> ',
        fzf_opts = {
            ['--scheme'] = 'path',
            ['--info'] = 'hidden'
        },
        winopts = {
            preview = {
                hidden = 'hidden'
            }
        },
        cwd_prompt = false
    },
    winopts = {
        split = "belowright vnew"
    },
})

local lgrep = { exec_empty_query = false }
local lgrep_continue = { exec_empty_query = false, continue_last_search = true }

local function edgy_wrap(fn)
    local win = edgy.get_win()
    if (win ~= nil) then
        --win:hide()
        fn()
        --win:show()
    end
end

keymap('n', '/', 'grep', function() fzf.lgrep_curbuf(lgrep) end)
keymap('n', '?', 'grep continued', function() fzf.lgrep_curbuf(lgrep_continue) end)
keymap('n', '<C-/>', 'project grep', function() fzf.live_grep_native(lgrep) end)
keymap('n', '<C-?>', 'project grep continued', function() fzf.live_grep_native(lgrep_continue) end)
keymap('n', '<C-`>', 'buffers list', function() fzf.buffers() end)

----------------------------------
-- external tooling integration --
----------------------------------

-- conform.nvim
-- https://github.com/stevearc/conform.nvim

require('conform').setup({
    formatters_by_ft = {
        -- prettier
        markdown = { 'prettier' },
        yaml = { 'prettier' },
        -- fish
        fish = { 'fish_indent' },
        -- shfmt
        sh = { 'shfmt' },
    },
    format_on_save = {
        lsp_fallback = true
    },
})

vim.o.formatexpr = 'v:lua.require\'conform\'.formatexpr()'

-- nvim-lint
-- https://github.com/mfussenegger/nvim-lint
local lint = require('lint')
lint.linters_by_ft = {
    md = { 'markdownlint' },
    sh = { 'shellcheck' },
    vim = { 'vint' }
}

local shellcheck = lint.linters.shellcheck
shellcheck.args = vim.list_extend({ "-x" }, shellcheck.args)

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    group = augroup,
    callback = function()
        require('lint').try_lint()
    end,
})

-- neogit
-- https://github.com/NeogitOrg/neogit
local neogit = require('neogit')
neogit.setup({
    kind = 'split',
    disable_hint = true,
    graph_style = 'unicode',
    integrations = {
        diffview = true,
        fzf_lua = true
    }
})

keymap('n', '<leader>g', 'open neogit', function() neogit.open() end)

-- diffview
-- https://github.com/sindrets/diffview.nvim
require('diffview').setup()

-- vim-tmux-navigation
-- https://github.com/christoomey/vim-tmux-navigator
vim.cmd [[
    let g:tmux_navigator_preserve_zoom = 1
]]

--------------
-- epilogue --
--------------

mini_clue.ensure_buf_triggers()
