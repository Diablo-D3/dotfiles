vim.o.wrap = true

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.o.completeopt = 'menuone,noselect,fuzzy,nosort'

vim.opt.clipboard:append('unnamed')
--vim.opt.clipboard:append('unnamedplus')

-- Neovim has weird clipboard detection preferences
-- https://github.com/neovim/neovim/blob/8ab511bba524bcd5b5913d1b1205b5e4fe3f7210/runtime/autoload/provider/clipboard.vim#L219-L268
if vim.env.TMUX then
    vim.g.clipboard = 'tmux'
else
    vim.g.clipboard = 'osc52'
end

vim.o.swapfile = false
vim.o.undofile = false

vim.opt.foldenable = false

vim.cmd.colorscheme('root-loops')

later(function()
    vim.diagnostic.config({
        signs = {
            priority = 9999,
            severity = {
                min = 'WARN',
                max = 'ERROR'
            },
        },
        underline = {
            severity = {
                min = 'HINT',
                max = 'ERROR'
            }
        },
        virtual_lines = false,
        virtual_text = {
            current_line = true,
            severity = {
                min = 'ERROR',
                max = 'ERROR'
            }
        }
    })
end)

vim.g.loaded_matchit = 1
