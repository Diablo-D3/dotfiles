now_if_args(function()
    add('neovim/nvim-lspconfig')

    vim.lsp.config('bashls', {
        settings = {
            bashIde = {
                shellcheckArguments = "-x -o all"
            }
        }
    })
    vim.lsp.enable('bashls')

    vim.lsp.enable('rumdl')

    vim.lsp.enable('taplo')
end)

now_if_args(function()
    add('folke/lazydev.nvim')

    require('lazydev').setup({
        library = {
            {
                path = '${3rd}/luv/library',
                words = { 'vim%.uv' }
            },
        }
    })

    vim.lsp.enable('lua_ls')
end)

now_if_args(function()
    add('mrcjkb/rustaceanvim')

    vim.g.rustaceanvim = {
        server = {
            on_attach = function(client, buf)
                map(n, '<Leader>la', 'Actions (Rustaceanvim)',
                    cmd('RustLsp codeAction'), { buffer = buf })

                map(n, '<Leader>ld', 'Diagnostic (Rustaceanvim)',
                    cmd('RustLsp renderDiagnostics current'), { buffer = buf })

                map(n, 'K', 'Hover (Rustaceanvim)',
                    cmd('RustLsp hover actions'), { buffer = buf })

                vim.lsp.inlay_hint.enable(true, { bufnr = buf })
            end,
            default_settings = {
                ['rust-analyzer'] = {
                    check = {
                        command = "clippy"
                    }
                }
            }
        }
    }
end)
