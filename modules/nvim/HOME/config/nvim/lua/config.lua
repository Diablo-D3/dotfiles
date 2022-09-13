------------
-- global --
------------

local keyopts = { noremap=true, silent=true }

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

-- spaceless.nvim
-- https://github.com/lewis6991/spaceless.nvim
require('spaceless').setup()

-- stabilize.nvim
-- https://github.com/luukvbaal/stabilize.nvim
require('stabilize').setup()

-----------------------------
-- themes and highlighting --
-----------------------------

-- nightfox.nvim
-- https://github.com/EdenEast/nightfox.nvim
vim.cmd("colorscheme nightfox")

-- lualine.nvim
-- https://github.com/nvim-lualine/lualine.nvin
require('lualine').setup({
    sections = {
        lualine_b = {
            'branch', 'diff',
            {
                'diagnostics',
                symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
            }
        },
        lualine_x = { },
        lualine_y = { 'filetype' },
        lualine_z = { 'location' }
    }
})

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
    auto_close = true,

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

vim.cmd [[
    nnoremap <leader>x <cmd>TroubleToggle<cr>
    nnoremap <leader>d <cmd>TroubleToggle workspace_diagnostics<cr>
    nnoremap <leader>q <cmd>TroubleToggle quickfix<cr>
    nnoremap <leader>l <cmd>TroubleToggle loclist<cr>
    nnoremap gr        <cmd>TroubleToggle lsp_references<cr>
]]

local troubleopts = { skip_group=true, jump=true }
vim.keymap.set('n', '[q', function() trouble.next(troubleopts) end, keyopts)
vim.keymap.set('n', ']q', function() trouble.previous(troubleopts) end, keyopts)

-- fzf-lua
-- https://github.com/ibhagwan/fzf-lua
local fzf = require('fzf-lua')

fzf.setup({
    fzf_opts = { ['--info'] = 'hidden', ['--color'] = '16,fg+:15,bg+:-1,prompt:-1,hl+:10,query:2' },
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

vim.keymap.set('n', '/', function() fzf.lgrep_curbuf({ fzf_cli_args = '--with-nth 4..', exec_empty_query = false }) end, keyopts)
vim.keymap.set('n', '<leader>/', function() fzf.live_grep_native({ fzf_cli_args = '--with-nth 4..' }) end, keyopts)
vim.keymap.set('n', '<C-`>', function() fzf.buffers() end, keyopts)
vim.keymap.set('n', '<leader>f', function() fzf.files() end, keyopts)

----------------
-- treesitter --
----------------

-- nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- https://github.com/nvim-treesitter/nvim-treesitter-refactor

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

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['ac'] = '@class.outer',
                ['oc'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['af'] = '@function.outer',
                ['of'] = '@function.outer',
                ['if'] = '@function.inner',
                ['aa'] = '@parameter.outer',
                ['oa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
            },
            selection_modes = {
                ['@parameter.outer'] = 'v',
                ['@parameter.inner'] = 'v',
                ['@function.outer'] = 'V',
                ['@function.inner'] = 'V',
                ['@class.outer'] = '<c-v>',
                ['@class.inner'] = '<c-v>',
            }
        }
    },

    refactor = {
        highlight_definitions = { enable = true },

        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "<leader>r"
            }
        },

        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gd"
            }
        }
    },

    rainbow = {
        enable = true,
        extended_mode = true
    }
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
        -- css et al, md, yaml, js/ts et al, json, html, etc
        'prettier',

        -- css
        -- missing: 'stylelint',

        -- markdown
        'markdownlint',

        -- yaml
        -- deb: 'yamllint',

        -- html, xml, xhtml
        -- deb: 'tidy',

        -- toml
        'taplo',

        -- sh
        -- deb: 'shellcheck',
        -- deb: 'shfmt',

        -- vim
        'vim-language-server',
        'vint',

        -- lua
        'lua-language-server',

        -- rust
        'rust-analyzer',
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
        css = { f_ft("css", "prettier") },
        markdown = { f_ft("markdown", "prettier") },
        yaml = { f_ft("yaml", "prettier") },
        json = { f_ft("json", "prettier") },

        -- tidy
        html = { f_ft("html", "tidy") } ,

        -- shfmt
        sh = { f_ft("sh", "shfmt") },

        -- fish
        fish = { f_ft("fish", "fishindent") }

        -- lsp: lua, rust
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
    -- css = { 'stylelint' },
    markdown = { 'markdownlint' },
    yaml = { 'yamllint' },
    -- no json linter
    html = { 'tidy' },
    sh = { 'shellcheck' },
    vim = { 'vint' },
    -- lsp: lua, rust, toml
}

local yamllint = require('lint.linters.yamllint')
table.insert(yamllint.args, "-d")
table.insert(yamllint.args, "{ extends: default, rules: { braces: { max-spaces-inside: 999 }, document-start: { present: false }, line-length: { max: 120 } } }")

---------
-- lsp --
---------

-- nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig.git,master
local lspfmt = vim.api.nvim_create_augroup('LspFormatting', {})

local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
    vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr')

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gq', vim.lsp.buf.formatting, bufopts)

    -- format on save
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#sync-formatting
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = lspfmt, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = lspfmt,
            buffer = bufnr,
            callback = function()
                -- 0.8: vim.lsp.buf.format({ bufnr = bufnr })
                vim.lsp.buf.formatting_sync()
            end,
        })
    end
end

vim.cmd [[
    " https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-line-number-instead-of-having-icons-in-sign-column
    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticVirtualTextError
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticVirtualTextWarn
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineVirtualTextInfo
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticVirtualTextHint
]]

require('lspconfig').sumneko_lua.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

require('lspconfig').taplo.setup {}

-- lsp_lines
-- https://git.sr.ht/~whynothugo/lsp_lines.nvim
require('lsp_lines').setup()

-- lsp_signature
-- https://github.com/ray-x/lsp_signature.nvim
require('lsp_signature').setup({
    hint_enable = false,
})

vim.diagnostic.config({
    virtual_text = false,
})

-- rust-tools.nvim
-- https://github.com/simrat39/rust-tools.nvim
local rust_tools = require("rust-tools")

rust_tools.setup({
    server = {
        on_attach = on_attach
    }
})

--------------------------------------
-- other languages-specific support --
--------------------------------------

-- crates.nvim
-- https://github.com/Saecki/crates.nvim
require('crates').setup({
    text = {
        loading = "  Loading...",
        version = "  %s",
        prerelease = "  %s",
        yanked = "  %s yanked",
        nomatch = "  Not found",
        upgrade = "  %s",
        error = "  Error fetching crate",
    },
    popup = {
        text = {
            title = "# %s",
            pill_left = "",
            pill_right = "",
            created_label = "created        ",
            updated_label = "updated        ",
            downloads_label = "downloads      ",
            homepage_label = "homepage       ",
            repository_label = "repository     ",
            documentation_label = "documentation  ",
            crates_io_label = "crates.io      ",
            categories_label = "categories     ",
            keywords_label = "keywords       ",
            version = "%s",
            prerelease = "%s pre-release",
            yanked = "%s yanked",
            enabled = "* s",
            transitive = "~ s",
            normal_dependencies_title = "  Dependencies",
            build_dependencies_title = "  Build dependencies",
            dev_dependencies_title = "  Dev dependencies",
            optional = "? %s",
            loading = " ...",
        },
    },
    src = {
        text = {
            prerelease = " pre-release ",
            yanked = " yanked ",
        },
    },
})

----------------------------------
-- external tooling integration --
----------------------------------

-- fugitive --
-- https://github.com/tpope/vim-fugitive
vim.keymap.set('n', '<leader>g', "<Cmd>Git ++curwin<CR>", keyopts)

-- vim-oscyank
-- https://github.com/ojroques/vim-oscyank
vim.cmd [[
    let g:oscyank_term = 'default'

    autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
    let g:clipboard = {
    \   'name': 'osc52',
    \   'copy': {
    \     '+': {lines, regtype -> OSCYankString(join(lines, "\n"))},
    \     '*': {lines, regtype -> OSCYankString(join(lines, "\n"))},
    \   },
    \   'paste': {
    \     '+': {-> [split(getreg(''), '\n'), getregtype('')]},
    \     '*': {-> [split(getreg(''), '\n'), getregtype('')]},
    \   },
    \ }
]]

-- vim-tmux-navigation
-- https://github.com/christoomey/vim-tmux-navigator
vim.cmd [[
    let g:tmux_navigator_preserve_zoom = 1
    nnoremap <silent> <C-Space> :TmuxNavigatePrevious<cr>
]]
