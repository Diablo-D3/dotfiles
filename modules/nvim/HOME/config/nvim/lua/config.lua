------------
-- global --
------------

local keyopts = { noremap = true, silent = true }

-- popupify
local popupify = function(ft)
    local au = vim.api.nvim_create_augroup(ft .. '_popup', {})
    vim.api.nvim_create_autocmd('FileType', {
        pattern = ft,
        group = au,
        callback = function()
            local cols = vim.o.columns
            local rows = vim.o.lines

            vim.opt_local.number = false
            vim.opt_local.relativenumber = false

            vim.api.nvim_win_set_config(0, {
                relative = 'editor',
                col = math.min(cols / 2, cols - 80),
                row = 0,
                width = math.max(cols / 2, 80),
                height = rows,
            })
        end
    })
end

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
        timing = quartic({ duration = 33.3, unit = 'total' }),
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

-- mini.basics
require('mini.basics').setup({})

-- mini.bracketed
require('mini.bracketed').setup({})

-- mini.bufremove
local mini_bufremove = require('mini.bufremove')
mini_bufremove.setup({})
vim.keymap.set('n', '<leader>w', function() mini_bufremove.wipeout(0, false) end, keyopts)

-- mini.comment
require('mini.comment').setup({})

-- mini.completion
require('mini.completion').setup({})
--https://github.com/echasnovski/mini.nvim/blob/main/doc/mini-completion.txt#L92
vim.api.nvim_set_keymap('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

local keys = {
    ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
    ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
    ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
}

_G.cr_action = function()
    if vim.fn.pumvisible() ~= 0 then
        local item_selected = vim.fn.complete_info()['selected'] ~= -1
        return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
    else
        return require('mini.pairs').cr()
    end
end

vim.api.nvim_set_keymap('i', '<CR>', 'v:lua._G.cr_action()', { noremap = true, expr = true })

-- mini.indentscope
local indentscope = require('mini.indentscope')
indentscope.setup({
    draw = {
        delay = 0,
        animation = indentscope.gen_animation.none()
    },
    symbol = "│"
})

--mini.pairs
require('mini.pairs').setup({})

-- mini.sessions
require('mini.sessions').setup({})

-- mini.statusline
local statusline = require('mini.statusline')
statusline.setup({
    content = {
        active = function()
            local diagnostics_f = function()
                local hasnt_attached_client = next(vim.lsp.buf_get_clients()) == nil
                if (vim.bo.buftype ~= '' or hasnt_attached_client) then return '' end

                local diagnostics = vim.diagnostic.get(0)
                local count = { 0, 0, 0, 0 }
                for _, diagnostic in ipairs(diagnostics) do
                    if vim.startswith(vim.diagnostic.get_namespace(diagnostic.namespace).name, 'vim.lsp') then
                        count[diagnostic.severity] = count[diagnostic.severity] + 1
                    end
                end

                local ce = count[vim.diagnostic.severity.ERROR]
                local cw = count[vim.diagnostic.severity.WARN]
                local ci = count[vim.diagnostic.severity.INFO]
                local ch = count[vim.diagnostic.severity.HINT]

                local e = (ce > 0) and "E" .. ce .. " " or ""
                local w = (cw > 0) and "W" .. cw .. " " or ""
                local i = (ci > 0) and "I" .. ci .. " " or ""
                local h = (ch > 0) and "H" .. ch .. " " or ""

                return vim.trim(e .. w .. i .. h)
            end

            local mode, mode_hl = statusline.section_mode({ trunc_width = 1 })
            local diagnostics   = diagnostics_f()
            local filename      = '%t'
            local fileinfo      = vim.bo.filetype
            local location      = '%l:%v'

            return statusline.combine_groups({
                { hl = mode_hl,                  strings = { mode } },
                { hl = 'MiniStatuslineFilename', strings = { diagnostics } },
                '%<', -- Mark general truncate point
                { hl = 'MiniStatuslineDevinfo',  strings = { filename } },
                '%=', -- End left alignment
                { hl = 'MiniStatuslineFilename', strings = { fileinfo } },
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
local trailspace = require('mini.trailspace')
trailspace.setup({})

local au_trailspace = vim.api.nvim_create_augroup('trailspace', {})
vim.api.nvim_create_autocmd("bufwritepre", {
    group = au_trailspace,
    callback = function()
        trailspace.trim()
        trailspace.trim_last_lines()
    end,
})

-----------------------------
-- themes and highlighting --
-----------------------------

-- tokyonight.nvim
-- https://github.com/folke/tokyonight.nvim
vim.cmd("colorscheme tokyonight-night")

-- nvim-colorizer
-- https://github.com/norcalli/nvim-colorizer.lua
require('colorizer').setup()

-- todo-comments.nvim
-- https://github.com/folke/todo-comments.nvim
require('todo-comments').setup()

----------------
-- navigation --
----------------

-- trouble.nvim
-- https://github.com/folke/trouble.nvim
local trouble = require('trouble');

trouble.setup {
    auto_open = false,
    auto_close = false,
    action_keys = {
        jump = {},
        jump_close = "<cr>"
    },

    -- remove icons
    icons = false,
    fold_open = "v",
    fold_closed = ">",
    indent_lines = false,
    signs = {
        error = "E",
        warning = "W",
        hint = "H",
        information = "I"
    },
    use_diagnostic_signs = false
}

vim.keymap.set('n', '<leader>d', function() trouble.toggle('workspace_diagnostics') end, keyopts)
vim.keymap.set('n', '<leader>t', function() trouble.toggle('todo') end, keyopts)

local troubleopts = { skip_group = true, jump = true }
vim.keymap.set('n', '[q', function() trouble.next(troubleopts) end, keyopts)
vim.keymap.set('n', ']q', function() trouble.previous(troubleopts) end, keyopts)

popupify("Trouble")

-- fzf-lua
-- https://github.com/ibhagwan/fzf-lua
local fzf = require('fzf-lua')

fzf.setup({
    fzf_opts = {
        ['--info'] = 'hidden',
        ['--color'] = '16,fg+:15,bg+:-1,prompt:-1,hl+:10,query:2'
    },
    buffers = {
        prompt = "> ",
    },
    grep = {
        prompt = "> ",
        no_header_i = true,
    },
    files = {
        prompt = "> ",
        fzf_opts = { ['--scheme'] = "path" },
    }
})

vim.keymap.set('n', '/', function()
    fzf.lgrep_curbuf({
        fzf_cli_args = '--with-nth 4..',
        exec_empty_query = false
    })
end, keyopts)
vim.keymap.set('n', '<leader>/', function() fzf.live_grep_native({ fzf_cli_args = '--with-nth 4..' }) end, keyopts)
vim.keymap.set('n', '<C-`>', function() fzf.buffers() end, keyopts)
vim.keymap.set('n', '<leader>f', function() fzf.files() end, keyopts)

----------------
-- treesitter --
----------------

-- nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter-refactor
-- https://github.com/nvim-treesitter/nvim-treesitter-context
-- https://github.com/HiPhish/nvim-ts-rainbow2
-- https://github.com/RRethy/nvim-treesitter-textsubjects
require('nvim-treesitter.install').update({
    with_sync = true
})

require('nvim-treesitter.configs').setup({
    auto_install = true,
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    refactor = {
        highlight_definitions = { enable = true },
        smart_rename = {
            enable = true,
            keymaps = {
                -- Remapped later in LSP buffers
                smart_rename = "<leader>r"
            }
        },
    },
    rainbow = {
        enable = true,
    },
    textsubjects = {
        enable = true,
        prev_selection = ",",
        keymaps = {
            ['.'] = 'textsubjects-smart',
            ['a;'] = 'textsubjects-container-outer',
            ['i;'] = 'textsubjects-container-inner',
        }
    },
})

vim.cmd [[
    set nofoldenable
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
]]

-----------
-- mason --
-----------

-- mason.nvim and mason-lspconfig.nvim
-- https://github.com/williamboman/mason.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

require("mason").setup()
require("mason-tool-installer").setup({
    ensure_installed = {
        -----------
        -- tools --
        -- --------

        -- markdown
        'glow',

        ----------------
        -- formatters --
        ----------------

        -- markdown
        'prettier',

        -------------
        -- linters --
        -------------

        -- markdown
        'markdownlint',

        -- sh
        -- deb: 'shellcheck',

        -- vim
        'vint',

        ----------
        -- lsps --
        ----------

        -- bash
        'bash-language-server',

        -- css, less, scss
        'css-lsp',

        -- html,
        'html-lsp',

        -- js, ts, vue, svelte
        'eslint-lsp',

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

        -- yaml
        'yaml-language-server',

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
    return require("formatter.filetypes." .. ft)[method]
end

require("formatter").setup {
    filetype = {
        -- prettier
        markdown = { f_ft("markdown", "prettier") },
        -- fish
        fish = { f_ft("fish", "fishindent") }
    }
}

vim.cmd [[
    " Remapped later in LSP buffers
    nnoremap <silent> gq <Cmd>Format<CR>

    augroup FormatterFormatting
    autocmd!
    autocmd BufWritePost * FormatWrite
    augroup END
]]

-- nvim-lint
-- https://github.com/mfussenegger/nvim-lint
require('lint').linters_by_ft = {
    -- markdown = { 'markdownlint' },
    vim = { 'vint' },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

---------
-- lsp --
---------

-- nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig
local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- K and gq are defined correctly by default

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', 'gc', function() fzf.lsp_code_actions() end, bufopts)
    vim.keymap.set('n', 'gd', function() trouble.toggle('lsp_definitions') end, keyopts)
    vim.keymap.set('n', 'gi', function() trouble.toggle('lsp_implementations') end, keyopts)
    vim.keymap.set('n', 'gt', function() trouble.toggle('lsp_type_definitions') end, keyopts)
    vim.keymap.set('n', 'gR', function() trouble.toggle('lsp_references') end, keyopts)

    -- format on save
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#sync-formatting
    local lspfmt = vim.api.nvim_create_augroup('LspFormatting', {})

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_clear_autocmds({ group = lspfmt, buffer = bufnr })
        vim.api.nvim_create_autocmd("bufwritepre", {
            group = lspfmt,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end

vim.cmd [[
    " https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-line-number-instead-of-having-icons-in-sign-column
    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticVirtualTextError
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticVirtualTextWarn
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticVirtualTextInfo
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticVirtualTextHint
]]

local cap_snippets = vim.lsp.protocol.make_client_capabilities()
cap_snippets.textDocument.completion.completionItem.snippetSupport = true

require('lspconfig').bashls.setup {
    on_attach = on_attach,
    settings = {
        bashIde = {
            includeAllWorkspaceSymbols = true
        }
    }
}

require('lspconfig').cssls.setup {
    on_attach = on_attach,
    capabilities = cap_snippets
}

require('lspconfig').html.setup {
    on_attach = on_attach,
    capabilities = cap_snippets
}

require('lspconfig').jsonls.setup {
    on_attach = on_attach,
    capabilities = cap_snippets
}

require('lspconfig').eslint.setup {
    on_attach = on_attach,
}

require('lspconfig').taplo.setup {
    on_attach = on_attach,
}

require('lspconfig').lua_ls.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT"
            },
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true)
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

require('lspconfig').vimls.setup {
    on_attach = on_attach
}

require('lspconfig').yamlls.setup {
    on_attach = on_attach
}

require('lspconfig').lemminx.setup {
    on_attach = on_attach
}

-- rust-tools.nvim
-- https://github.com/simrat39/rust-tools.nvim
local rust_tools = require("rust-tools")

rust_tools.setup({
    server = {
        on_attach = on_attach,
        settings = {
            checkonsave = {
                command = "clippy"
            }
        }
    }
})

--------------------------------------
-- other languages-specific support --
--------------------------------------

----------------------------------
-- external tooling integration --
----------------------------------

-- fugitive
-- https://github.com/tpope/vim-fugitive
vim.keymap.set('n', '<leader>g', function()
    if vim.api.nvim_buf_get_option(0, "filetype") == "fugitive" then
        vim.cmd.close()
    else
        vim.cmd.Git()
    end
end, keyopts)

popupify("fugitive")

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
    nnoremap <silent> <C-Space> :TmuxNavigatePrevious<cr>
    tnoremap <silent> <C-Space> :TmuxNavigatePrevious<cr>
]]
