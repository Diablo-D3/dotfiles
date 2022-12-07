------------
-- global --
------------

local keyopts = { noremap = true, silent = true }

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

local View = require('trouble.view')
local setup = View.setup
View.setup = function(...)
    setup(...)
    require('autosplit')()
end

-- spaceless.nvim
-- https://github.com/lewis6991/spaceless.nvim
require('spaceless').setup()

-- stabilize.nvim
-- https://github.com/luukvbaal/stabilize.nvim
require('stabilize').setup()

-----------------------------
-- themes and highlighting --
-----------------------------

-- tokyonight.nvim
-- https://github.com/folke/tokyonight.nvim
vim.cmd("colorscheme tokyonight")

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
        lualine_x = {},
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
    auto_close = false,

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
    nnoremap <leader>t <cmd>TroubleToggle todo<cr>
    nnoremap gr        <cmd>TroubleToggle lsp_references<cr>
]]

local troubleopts = { skip_group = true, jump = true }
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

vim.keymap.set('n', '/', function() fzf.lgrep_curbuf({
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
                -- Remapped later in LSP buffers
                smart_rename = "<leader>r"
            }
        },

        navigation = {
            enable = true,
            keymaps = {
                -- Remapped later in LSP buffers
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
-- https://github.com/neovim/nvim-lspconfig.git,master
local lspfmt = vim.api.nvim_create_augroup('LspFormatting', {})

local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
    vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr')

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>c', function() fzf.lsp_code_actions() end, bufopts)
    -- gr / lsp.buf.references handled by trouble
    vim.keymap.set('n', 'gq', function() vim.lsp.buf.format { async = true } end, bufopts)

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

local cap_snippets = vim.lsp.protocol.make_client_capabilities()
cap_snippets.textDocument.completion.completionItem.snippetSupport = true

require('lspconfig').bashls.setup {
    on_attach = on_attach
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
    capabilities = cap_snippets,
}

require('lspconfig').eslint.setup {
    on_attach = on_attach,
}

require('lspconfig').taplo.setup {
    on_attach = on_attach,
}

require('lspconfig').sumneko_lua.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
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

require('lspconfig').vimls.setup {
    on_attach = on_attach
}

require('lspconfig').yamlls.setup {
    on_attach = on_attach
}

require('lspconfig').lemminx.setup {
    on_attach = on_attach
}

-- lsp_signature
-- https://github.com/ray-x/lsp_signature.nvim
require('lsp_signature').setup({
    hint_enable = false,
})

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
vim.keymap.set('n', '<leader>g', "<Cmd>Git ++curwin<CR>", keyopts)

-- vim-osc52
-- https://github.com/ojroques/nvim-osc52
require('osc52').setup {}

local function copy(lines, _)
    require('osc52').copy(table.concat(lines, '\n'))
end

local function paste()
    return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
end

vim.g.clipboard = {
    name = 'osc52',
    copy = { ['+'] = copy, ['*'] = copy },
    paste = { ['+'] = paste, ['*'] = paste },
}

-- vim-tmux-navigation
-- https://github.com/christoomey/vim-tmux-navigator
vim.cmd [[
    let g:tmux_navigator_preserve_zoom = 1
    nnoremap <silent> <C-Space> :TmuxNavigatePrevious<cr>
    tnoremap <silent> <C-Space> :TmuxNavigatePrevious<cr>
]]
