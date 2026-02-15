-- MiniDeps
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.uv.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/nvim-mini/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup()

_G.add, _G.now, _G.later = MiniDeps.add, MiniDeps.now, MiniDeps.later
_G.now_if_args = vim.fn.argc(-1) > 0 and now or later

-- Global
_G.tbl_contains = vim.tbl_contains
_G.tbl_extend = vim.tbl_extend

--- |vim.api.nvim_create_autocmd| wrapper that breaks opts.desc out
--- @param event string|string[]
--- @param desc string
--- @param opts? table
_G.create_autocmd = function(event, desc, opts)
    opts = tbl_extend('force', opts or {}, {
        desc = desc,
        group = vim.api.nvim_create_augroup(desc, { clear = false })
    })
    return vim.api.nvim_create_autocmd(event, opts)
end

-- Mode constants
_G.n = 'n' -- normal
_G.v = 'v' -- visual and select
_G.o = 'o' -- operator pending
_G.i = 'i' -- insert
_G.c = 'c' -- cmd
_G.s = 's' -- select
_G.x = 'x' -- visual
_G.t = 't' -- terminal
_G.nv = { n, v }
_G.ni = { n, i }
_G.nvi = { n, v, i }
_G.nvic = { n, v, i, c }

--- |vim.keymap.set()| wrapper that breaks `opts.desc` out
--- @param mode string|string[]
--- @param lhs string
--- @param desc string
--- @param rhs string|function
--- @param opts? table
_G.map = function(mode, lhs, desc, rhs, opts)
    opts = tbl_extend('force', opts or {}, { desc = desc })
    vim.keymap.set(mode, lhs, rhs, opts)
end

--- `<Cmd>rhs<CR>`
--- @param rhs string
_G.cmd = function(rhs)
    return '<Cmd>' .. rhs .. '<CR>'
end

--- `<Cmd>lua rhs<CR>`
--- @param rhs string
_G.lua = function(rhs)
    return cmd('lua ' .. rhs)
end

--- `<Cmd>exec "normal! rhs"<CR>`
--- @param rhs string
_G.keys = function(rhs)
    return cmd('exec "normal! ' .. rhs .. '"')
end
