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
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.wrap = false
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

-- keybinds
vim.g.mapleader = ' '

keymap({ 'x', 'n' }, ';', 'Command mode', ':', { silent = false })
keymap({ 'x', 'n' }, ':', 'Repeat f or t', ';', { silent = false })

keymap('n', '<leader>q', 'Close window', function() vim.api.nvim_win_close(0, true) end)
keymap('n', '<leader>v', 'Split view', function() vim.cmd.vsplit() end)

-- local requires
require('help_unsplit').setup()

------------------------
-- base functionality --
------------------------

-- deepwhite
-- https://github.com/Verf/deepwhite.nvim
vim.cmd.colorscheme('deepwhite')

local colors = require("deepwhite.colors").get_colors({})

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
keymap('n', '<space>w', 'wipeout buffer', function() mini_bufremove.wipeout(0, false) end, keyopts)

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

-- mini.pick
local mini_pick = require('mini.pick')
mini_pick.setup({})

keymap('n', '<leader>/', 'Global search', mini_pick.builtin.grep_live)
keymap('n', '<leader>b', 'Buffers', mini_pick.builtin.buffers)
keymap('n', '<leader>f', 'Files', mini_pick.builtin.files)

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

        vim.lsp.inlay_hint.enable(true, { bufnr = 0 })

        keymap('n', 'ga', 'LSP Code Actions', vim.lsp.buf.code_action, bufopts)
        keymap('n', '<C-k>', 'LSP Signature Help', vim.lsp.buf.signature_help, bufopts)
    end,
})
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

local function hover()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    for _, client in ipairs(clients) do
        if client.server_capabilities.hoverProvider then
            vim.lsp.buf.hover()
            return
        end

        feedkeys('K')
    end
end

keymap('n', 'K', 'Hover', hover)
keymap('n', '<space>k', 'Hover', hover)

vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    callback = function()
        vim.lsp.buf.format { async = false }
    end
})

-- diagflow.nvim
-- https://github.com/dgagn/diagflow.nvim
require('diagflow').setup({})

vim.diagnostic.config({
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

lspconfig.bashls.setup({
    settings = {
        bashIde = {
            shellcheckArguments = "-x -o all"
        }
    }
})

lspconfig.clangd.setup({})

lspconfig.cssls.setup({})

lspconfig.efm.setup({})

lspconfig.html.setup({})

lspconfig.jsonls.setup({})

lspconfig.taplo.setup({})

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
            },
            completion = {
                callSnippet = "Replace"
            }
        }
    }
})

-- fidget.nvim
-- https://github.com/j-hui/fidget.nvim
require('fidget').setup({})

----------------
-- treesitter --
----------------

-- nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter-refactor
-- https://github.com/nvim-treesitter/nvim-treesitter-context
-- https://gitlab.com/HiPhish/rainbow-delimiters.nvim
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

keymap('n', 'gd', 'Definitions', function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    for _, client in ipairs(clients) do
        if client.server_capabilities.definitionProvider then
            trouble.open('lsp_definitions')
            return
        end
    end

    feedkeys('gd')
end)

keymap('n', 'gD', 'Declaration', function()
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
        feedkeys('gD')
    end)
end)

keymap('n', 'gy', 'Type Definitions', function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    for _, client in ipairs(clients) do
        if client.server_capabilities.typeDefinitionProvider then
            trouble.open('lsp_type_definitions')
            return
        end
    end

    -- don't do gt = goto next tab page
end)

keymap('n', 'gr', 'LSP References', function()
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

----------------------------------
-- external tooling integration --
----------------------------------

-- neogit
-- https://github.com/NeogitOrg/neogit
local neogit = require('neogit')
neogit.setup({
    kind = 'tab',
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
