-- Global
_G.tbl_contains = vim.tbl_contains
_G.tbl_extend = vim.tbl_extend

_G.add = vim.pack.add

-- Mini.nvim
add({ 'https://github.com/nvim-mini/mini.nvim' })

_G.MiniMisc = require('mini.misc')

_G.now = function(f) MiniMisc.safely('now', f) end
_G.later = function(f) MiniMisc.safely('later', f) end
_G.now_if_args = vim.fn.argc(-1) > 0 and _G.now or _G.later
_G.on_event = function(ev, f) MiniMisc.safely('event:' .. ev, f) end
_G.on_filetype = function(ft, f) MiniMisc.safely('filetype:' .. ft, f) end

--- |vim.api.nvim_create_autocmd| wrapper that breaks opts.{desc, callback} out, and wraps callback in pcall
--- @param event string|string[]
--- @param desc string
--- @param callback function
--- @param opts? table
_G.create_autocmd = function(event, desc, callback, opts)
    opts = tbl_extend('force', opts or {}, {
        desc = desc,
        callback = function(ev)
            local success, result = pcall(callback, ev)

            if not success then
                vim.notify(result, vim.log.levels.ERROR)
            end
        end,
        group = vim.api.nvim_create_augroup(desc, { clear = false })
    })
    return vim.api.nvim_create_autocmd(event, opts)
end

_G.on_packchanged = function(plugin_name, kinds, desc, callback)
    create_autocmd('PackChanged', desc,
        function(ev)
            local name, kind = ev.data.spec.name, ev.data.kind
            if not (name == plugin_name and tbl_contains(kinds, kind)) then return end
            if not ev.data.active then vim.cmd.packadd(plugin_name) end
            callback(ev.data)
        end
    )
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

-- Keymap
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
