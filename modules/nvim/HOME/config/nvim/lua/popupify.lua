-- popupify.nvim
-- Copyright (C) 2023 Patrick McFarland <pmcfarland@adterrasperaspera.com>
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

local vim = vim
local augroup = vim.api.nvim_create_augroup('popupify', {})

local M = {}

M.wins = {}

--- Popupify's default window options: 80 column wide, full height
--- floating window with rounded border, minimal style, on right side of
--- editor. Useful if you want to match this style with plugins that don't
--- need Popupify's assistance.
---
--- @return table Same as |vim.api.nvim_open_win()| {options}
function M.default_winopts()
    local cols = vim.o.columns
    local rows = vim.o.lines

    return {
        relative = 'editor',
        style = 'minimal',
        border = 'rounded',
        col = cols,
        row = 0,
        width = 80,
        height = rows,
    }
end

--- Close popup window only if inside popup window, and perform state
--- cleanup. This is mapped by Popupify, while in the popup, as <Esc> and
--- the mapped key.
function M.close()
    local curwin = vim.api.nvim_get_current_win()
    local win = M.wins[curwin]

    if win then
        M.wins[curwin] = nil
        vim.api.nvim_win_close(curwin, true)
    end
end

--- Helper pattern to automate calling a function that creates a new
--- window and modifying it before showing the window. This handles the
--- autocmd, keymap to call and dismiss, auto-resize and auto-close steps.
--- This is useful for calling functions that do not accept a
--- options/winopts/etc argument, such as ones written in vimscript.
---
--- @param au_event    string|table       Same as |vim.api.nvim_create_autocmd()| {event}.
--- @param au_pattern  string|table       Same as |vim.api.nvim_create_autocmd()| {opts.pattern}.
--- @param km_mode     string|table       Same as |vim.keymap.set()| {mode}.
--- @param km_map      string             Same as |vim.keymap.set()| {lhs}.
--- @param km_func     string|function    Same as |vim.keymap.set()| {rhs}
--- @param km_desc     string|nil         Same as |vim.keymap.set()| {opts.desc}.
--- @param callback    function|nil       Called at end of autocmd.
--- @param win_options table|function|nil Same as |vim.api.nvim_open_win()| {options}. If function, calls and passes output. If nil, calls |default_winopts()|.
function M.popupify(au_event, au_pattern, km_mode, km_map, km_desc, km_func, callback, win_options)
    vim.keymap.set(km_mode, km_map, function()
        local curwin = vim.api.nvim_get_current_win()
        local win = M.wins[curwin]

        if (win == nil or km_map ~= win.map) then
            if (type(km_func) == "function") then
                km_func()
            else
                vim.cmd(km_func)
            end
        else
            M.close()
        end
    end, { silent = true, desc = km_desc })

    vim.api.nvim_create_autocmd(au_event, {
        pattern = au_pattern,
        group = augroup,
        callback = function()
            if #(vim.api.nvim_list_wins()) > 1 then
                local curwin = vim.api.nvim_get_current_win()

                local win = {
                    map = km_map
                }

                if (type(win_options) == "table") then
                    win.opts = vim.deepcopy(win_options)
                elseif (type(win_options) == "function") then
                    win.opts = win_options
                else
                    win.opts = M.default_winopts()
                end

                vim.api.nvim_win_set_config(curwin, win.opts)

                M.wins[curwin] = win

                if callback then callback() end
            end
        end
    })
end

-- Apply <Esc> map to buffer on enter when inside popup
vim.api.nvim_create_autocmd('BufEnter', {
    group = augroup,
    callback = function()
        local curwin = vim.api.nvim_get_current_win()
        local curbuf = vim.api.nvim_get_current_buf()

        local win = M.wins[curwin]

        if win then
            vim.keymap.set('n', '<Esc>', function()
                M.close()
            end, {
                    buffer = curbuf,
                    silent = true,
                    nowait = true,
                    desc = '<Esc>' })

            win.buf = curbuf
        end
    end
})

-- Remove <Esc> map from buffer on leave when inside popup
vim.api.nvim_create_autocmd('BufLeave', {
    group = augroup,
    callback = function()
        local curwin = vim.api.nvim_get_current_win()
        local win = M.wins[curwin]

        local curbuf = vim.api.nvim_get_current_buf()

        if win and (curbuf == win.buf) then
            vim.keymap.del('n', '<Esc>', { buffer = curbuf })

            win.buf = nil
        end
    end
})

-- Automatically close when leaving popup
vim.api.nvim_create_autocmd('WinLeave', {
    group = augroup,
    callback = function()
        local curwin = vim.api.nvim_get_current_win()
        local win = M.wins[curwin]

        if win then
            M.close()

            M.wins[curwin] = nil
        end
    end
})

-- Automatically reapply window options on resize
vim.api.nvim_create_autocmd({ 'VimResized', 'WinResized' }, {
    group = augroup,
    callback = function()
        local curwin = vim.api.nvim_get_current_win()
        local win = M.wins[curwin]

        if win then
            if (type(win.opts) == "table") then
                vim.api.nvim_win_set_config(curwin, win.opts)
            elseif (type(win.opts) == "function") then
                vim.api.nvim_win_set_config(curwin, win.opts())
            else
                vim.api.nvim_win_set_config(curwin, M.default_winopts())
            end
        end
    end
})

return M
