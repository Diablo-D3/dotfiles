------------
-- global --
------------

local keyopts = { noremap=true, silent=true }
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
    auto_open = true,
    auto_close = true,
    action_keys = {
        hover = "K"
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

-- telescope.nvim
-- https://github.com/nvim-telescope/telescope.nvim.git
local telescope = require('telescope');

telescope.setup({
    defaults = {
        mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
        }
    }
})

vim.cmd [[
    nnoremap / <cmd>Telescope current_buffer_fuzzy_find<cr>
    nnoremap <C-`> <cmd>Telescope buffers<cr>
    nnoremap <leader>f <cmd>Telescope find_files find_command=fd<cr>
    nnoremap <leader>/ <cmd>Telescope live_grep<cr>
]]

--------------------------
-- snippet and complete --
--------------------------

-- luasnip
-- https://github.com/L3MON4D3/LuaSnip.git,master
local luasnip = require('luasnip')
require("luasnip.loaders.from_vscode").lazy_load()

-- nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp.git,main
local cmp = require('cmp')

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- SuperTab for Luasnip
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            { name = 'crates' },
            { name = 'luasnip' },
            { name = 'buffer' },
        },
        {
            { name = 'buffer' },
        }),
    formatting = {
        format = function(entry, vim_item)
            -- Show type and source
            -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations
            vim_item.kind = string.format('[%s]', vim_item.kind)
            vim_item.menu = string.format('[%s]', entry.source.name)
            return vim_item
        end
    },
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

----------------
-- treesitter --
----------------

-- nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
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

---------
-- lsp --
---------

-- nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig.git,master
local lspfmt = vim.api.nvim_create_augroup('LspFormatting', {})

local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)

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

    require('illuminate').on_attach(client)
end

vim.cmd [[
    " https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-line-number-instead-of-having-icons-in-sign-column
    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticVirtualTextError
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticVirtualTextWarn
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineVirtualTextInfo
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticVirtualTextHint
]]

-- lsp_lines
-- https://git.sr.ht/~whynothugo/lsp_lines.nvim
require('lsp_lines').setup()

vim.diagnostic.config({
    virtual_text = false,
})

-- null-ls.nvim
-- https://github.com/jose-elias-alvarez/null-ls.nvim
local null_ls = require('null-ls')

local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

local disabled = { "rust" }

null_ls.setup({
    sources = {
        -- generic
        code_actions.gitsigns,
        diagnostics.trail_space,

        -- generic, excluded from lsp formatting overlap
        formatting.trim_newlines.with({ disabled_filetypes = disabled }),
        formatting.trim_whitespace.with({ disabled_filetypes = disabled }),

        -- js/ts et al, css et al, html, json, yaml, md, etc
        formatting.prettier,

        -- c, c++, c#, java, etc
        formatting.uncrustify,

        -- fish
        diagnostics.fish,
        formatting.fish_indent,

        -- html, xml
        formatting.tidy,

        -- xml
        formatting.xmllint,

        -- lua
        diagnostics.luacheck,

        -- sh
        code_actions.shellcheck,
        formatting.shfmt,

        -- yaml
        diagnostics.yamllint.with({
            extra_args = { "-d", "{ extends: default, rules: { braces: { max-spaces-inside: 999 }, document-start: { present: false }, line-length: { max: 120 } } }" },
        }),
    },

    on_attach = on_attach,
    diagnostics_format = "[#{m} (#{s})", -- msg (src)
    log_level = "trace"
})

-- rust-tools.nvim
-- https://github.com/simrat39/rust-tools.nvim

local rt = require("rust-tools")

rt.setup({
    server = {
        capabilities = capabilities,
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
    null_ls = {
        enabled = true,
        name = "crates",
    },
})

----------------------------------
-- external tooling integration --
----------------------------------

-- gitsigns.nvim
-- https://github.com/lewis6991/gitsigns.nvim
require('gitsigns').setup({
    signcolumn = false
})

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
