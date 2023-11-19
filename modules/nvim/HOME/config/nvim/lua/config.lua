------------
-- global --
------------

local vim = vim

local winopts = require('popupify').default_winopts
local popupify = require('popupify').popupify

local keyopts = { silent = true }
local local_keyopts = { silent = true, buffer = true }

local function extend(a, b) return vim.tbl_extend("force", a, b) end
local function keymap(mode, lhs, desc, rhs) return vim.keymap.set(mode, lhs, rhs, extend(keyopts, { desc = desc })) end
local function termcodes(x) return vim.api.nvim_replace_termcodes(x, true, true, true) end
local feedkeys = function(key) vim.fn.feedkeys(key, 'n') end

vim.cmd.helptags('ALL')

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

-- mini.ai
local mini_ai = require('mini.ai')
mini_ai.setup({
    n_lines = 9001,
    search_method = 'cover_or_nearest'
})

-- mini.animate
local mini_animate = require('mini.animate')
local quartic = mini_animate.gen_timing.quartic
mini_animate.setup({
    cursor = {
        enable = false
    },
    scroll = {
        timing = quartic({ duration = 33.3, unit = 'total' }),
    },
    resize = {
        enable = false
    },
    open = {
        enable = false
    },
    close = {
        enable = false
    }
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

local keys = {
    ['tab'] = termcodes('<Tab>'),
    ['s-tab'] = termcodes('<S-Tab>'),
    ['c-xc-o'] = termcodes('<C-X><C-O>'),
    ['c-n'] = termcodes('<C-N>'),
    ['c-p'] = termcodes('<C-P>'),

    ['cr'] = termcodes('<CR>'),
    ['ctrl-y'] = termcodes('<C-Y>'),
    ['ctrl-y_cr'] = termcodes('<C-Y><CR>'),
}

local function tab_complete(shift)
    if vim.fn.pumvisible() == 1 then return feedkeys(shift and keys['c-p'] or keys['c-n']) end

    local line = vim.api.nvim_get_current_line()
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    local not_at_whitespace = line:sub(pos, pos):find('%s') == nil
    if (not_at_whitespace and pos > 1) then return feedkeys(keys['c-xc-o']) end

    feedkeys(shift and keys['s-tab'] or keys['tab'])
end

vim.keymap.set('i', '<Tab>', function() tab_complete(false) end, keyopts)
vim.keymap.set('i', '<S-Tab>', function() tab_complete(true) end, keyopts)

local function cr_complete()
    if vim.fn.pumvisible() == 0 then return feedkeys(keys['cr']) end
    local has_selected = vim.fn.complete_info()['selected'] ~= -1
    feedkeys(has_selected and keys['ctrl-y'] or keys['ctrl-y_cr'])
end

vim.keymap.set('i', '<CR>', cr_complete, keyopts)

-- mini.hipatterns
local mini_hipatterns = require('mini.hipatterns')

mini_hipatterns.setup({
    highlighters = {
        fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        hex_color = mini_hipatterns.gen_highlighter.hex_color(),
    },
})

-- mini.hues
local mini_hues = require('mini.hues')
local palette = {
    foreground = '#ffffff',
    background = '#000000',
    saturation = 'high'
}

mini_hues.setup(palette)

-- setup secondary bg ns
local tooltip = vim.api.nvim_create_namespace('tooltip')
local visual = vim.api.nvim_get_hl(0, { name = 'Visual' })
local highlights = vim.api.nvim_get_hl(0, {})

for name, def in pairs(highlights) do
    if not def['link'] then
        def['bg'] = visual['bg']
        def['ctermbg'] = visual['ctermbg']
    end

    vim.api.nvim_set_hl(tooltip, name, def)
end

-- uncomment to print values
--vim.print(mini_hues.make_palette(palette))

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

local au_trailspace = vim.api.nvim_create_augroup('trailspace', {})
vim.api.nvim_create_autocmd('bufwritepre', {
    group = au_trailspace,
    callback = function()
        mini_trailspace.trim()
        mini_trailspace.trim_last_lines()
    end,
})

----------------
-- navigation --
----------------

-- trouble.nvim
-- https://github.com/folke/trouble.nvim
local trouble = require('trouble');

trouble.setup {
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
}

popupify('FileType', 'Trouble', 'n', '<leader>d', 'Trouble Diagnostics', function()
    trouble.toggle('workspace_diagnostics')
end)

popupify('FileType', 'Trouble', 'n', '<leader>t', 'Trouble Todo', function()
    trouble.toggle('todo')
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
    winopts_fn = winopts,
})

local lgrep = { exec_empty_query = false }
local lgrep_continue = { exec_empty_query = false, continue_last_search = true }

keymap('n', '/', 'grep', function() fzf.lgrep_curbuf(lgrep) end)
keymap('n', '?', 'grep continued', function() fzf.lgrep_curbuf(lgrep_continue) end)
keymap('n', '<C-/>', 'project grep', function() fzf.live_grep_native(lgrep) end)
keymap('n', '<C-?>', 'project grep continued', function() fzf.live_grep_native(lgrep_continue) end)
keymap('n', '<C-`>', 'buffers list', function() fzf.buffers() end)
keymap('n', '<leader>f', 'open file', function() fzf.files() end)

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

vim.api.nvim_create_autocmd('CursorMoved', {
    callback = function(ev)
        local bufnr = ev.buf
        local clients = vim.lsp.get_active_clients({ bufnr = bufnr })

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
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })

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
    feedkeys(':' .. cmd .. termcodes('<Left><Left>'))
end)

-----------
-- mason --
-----------

-- mason.nvim and mason-lspconfig.nvim
-- https://github.com/williamboman/mason.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

require('mason').setup()
require('mason-tool-installer').setup({
    ensure_installed = {
        -----------
        -- tools --
        -----------

        -- markdown
        'glow',

        ----------------
        -- formatters --
        ----------------

        -- markdown
        'prettier',

        -- sh
        -- deb: 'shfmt'

        -------------
        -- linters --
        -------------

        -- sh
        -- deb: 'shellcheck',

        -- vim
        'vint',

        ----------
        -- lsps --
        ----------

        -- bash
        'bash-language-server',

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

        -- markdown
        'marksman',

        -- rust
        'rust-analyzer',

        -- toml
        'taplo',

        -- vim
        'vim-language-server',

        -- xml, xsd, xsl, xslt, svg
        'lemminx',
    },
    auto_update = true,
})

----------------------------------------
-- stand alone formatting and linting --
----------------------------------------

-- formatter.nvim
-- https://github.com/mhartington/formatter.nvim

local function f_ft(ft, method)
    return require('formatter.filetypes.' .. ft)[method]
end

require('formatter').setup {
    filetype = {
        -- prettier
        markdown = { f_ft('markdown', 'prettier') },
        yaml = { f_ft('yaml', 'prettier') },
        -- fish
        fish = { f_ft('fish', 'fishindent') },
        -- sh
        sh = { f_ft('sh', 'shfmt') }
    }
}

-- call lsp formatter if provided, else call formatter.nvim
-- ... for gq
function Formatexpr()
    local lnum = vim.v.lnum;
    local count = vim.v.count;

    local clients = vim.lsp.get_active_clients({ bufnr = 0 })

    -- check if lsp client offers format and quit early
    for _, client in ipairs(clients) do
        if client.server_capabilities.documentFormattingProvider then
            vim.lsp.formatexpr({})
            return
        end
    end

    -- else run formatter.nvim
    return require("formatter.format").format("", "", lnum, (lnum + count + 1), { lock = true })
end

vim.o.formatexpr = "v:lua.Formatexpr()"

-- ... on save
local format = vim.api.nvim_create_augroup('FormatOnWrite', {})
vim.api.nvim_create_autocmd('BufWritePre', {
    group = format,
    callback = function(ev)
        local bufnr = ev.buf

        local clients = vim.lsp.get_active_clients({ bufnr = bufnr })

        -- check if lsp client offers format and quit early
        for _, client in ipairs(clients) do
            if client.server_capabilities.documentFormattingProvider then
                vim.lsp.buf.format({ bufnr = bufnr })
            end
        end

        -- else run formatter.nvim
        require("formatter.format").format("", "", 1, "$", { lock = true })
    end
})

-- nvim-lint
-- https://github.com/mfussenegger/nvim-lint
require('lint').linters_by_ft = {
    vim = { 'vint' }
}

local lint = vim.api.nvim_create_augroup('Lint', {})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    group = lint,
    callback = function()
        require('lint').try_lint()
    end,
})

---------
-- lsp --
---------

-- nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig
local lspconfig = require('lspconfig')
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspConfig', {}),
    callback = function(ev)
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }

        vim.keymap.set('n', 'gd', function() trouble.toggle('lsp_definitions') end, keyopts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gi', function() trouble.toggle('lsp_implementations') end, keyopts)
        -- gq stock calls formatexpr when set
        vim.keymap.set('n', 'gt', function() trouble.toggle('lsp_type_definitions') end, keyopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', 'gR', function() trouble.toggle('lsp_references') end, keyopts)
        vim.keymap.set('n', 'g.', function() fzf.lsp_code_actions() end, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
    end,
})

lspconfig.bashls.setup({
    settings = {
        bashIde = {
            includeAllWorkspaceSymbols = true
        }
    }
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
    update_in_insert = true,
    severity_sort = true,
})

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-line-number-instead-of-having-icons-in-sign-column
for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
    vim.fn.sign_define("DiagnosticSign" .. diag, {
        text = "",
        texthl = "DiagnosticSign" .. diag,
        linehl = "",
        numhl = "DiagnosticSign" .. diag,
    })
end

--------------------------------------
-- other languages-specific support --
--------------------------------------

----------------------------------
-- external tooling integration --
----------------------------------

-- fugitive
-- https://github.com/tpope/vim-fugitive
popupify('FileType', { 'fugitive', 'git', 'gitcommit' }, 'n', '<leader>g', 'Fugitive',
    function()
        vim.cmd.Git()
    end, function()
        vim.keymap.set('n', 'cc', function()
            -- temporary fix for 'press enter'
            vim.o.cmdheight = 1
            vim.cmd.Git('commit')
            vim.o.cmdheight = 0
        end, local_keyopts)
    end)

-- vim-osc52
-- https://github.com/ojroques/nvim-osc52
require('osc52').setup({
    silent = true
})

local function copy(lines, _)
    require('osc52').copy(table.concat(lines, '\n'))
end

local function paste()
    return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
end

vim.g.clipboard = {
    name = 'osc52',
    copy = {
        ['+'] = copy,
        ['*'] = copy
    },
    paste = {
        ['+'] = paste,
        ['*'] = paste
    },
}

-- vim-tmux-navigation
-- https://github.com/christoomey/vim-tmux-navigator
vim.cmd [[
    let g:tmux_navigator_preserve_zoom = 1
]]

--------------
-- epilogue --
--------------

mini_clue.ensure_buf_triggers()
