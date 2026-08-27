vim.o.wrap = true

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.o.completeopt = 'menuone,noselect,fuzzy,nosort'

vim.opt.clipboard:append('unnamed')
vim.opt.clipboard:append('unnamedplus')

-- Neovim has weird clipboard detection preferences
-- https://github.com/neovim/neovim/blob/8ab511bba524bcd5b5913d1b1205b5e4fe3f7210/runtime/autoload/provider/clipboard.vim#L219-L268
if vim.env.WSL_INTEROP then
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe'
        },
        paste = {
            ['+'] = { 'powershell.exe', '-nologo', '-noprofile', '-c', '[console]::out.write($(get-clipboard -raw).tostring().replace("`r", ""))' },
            ['*'] = { 'powershell.exe', '-nologo', '-noprofile', '-c', '[console]::out.write($(get-clipboard -raw).tostring().replace("`r", ""))' }
        },
        cache_enabled = 0
    }
elseif vim.env.TMUX then
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
                min = vim.diagnostic.severity.WARN,
                max = vim.diagnostic.severity.ERROR
            },
        },
        underline = {
            severity = {
                min = vim.diagnostic.severity.HINT,
                max = vim.diagnostic.severity.ERROR
            }
        },
        virtual_lines = false,
        virtual_text = false
    })
end)

local diag_diags = nil
local diag_offset_y = nil
local diag_winid = nil

create_autocmd(
    { 'CursorMoved', 'CursorMovedI', 'InsertCharPre', 'DiagnosticChanged', 'VimResized', 'WinScrolled' },
    'Handle Diagnostic Float',
    function(ev)
        -- screencol()/screenrow() are buggy
        local winid = vim.api.nvim_get_current_win()
        local curpos = vim.api.nvim_win_get_cursor(winid)

        local screenpos = vim.fn.screenpos(winid, curpos[1], curpos[2] + 1)
        local screencol = screenpos['curscol'] - 1
        local screenrow = screenpos['row'] - 1

        local diags = vim.diagnostic.get(0, { lnum = curpos[1] - 1 })

        local offset_x = (screencol < vim.o.columns / 2) and 0 or vim.o.columns
        local offset_y = (screenrow < vim.o.lines / 2) and vim.o.lines or 0

        -- diag window open
        if diag_winid and vim.api.nvim_get_current_win ~= diag_winid then
            -- diags changed event, vim resized, vim scrolled, no diags, diags changed check
            if ev.event == 'DiagnosticChanged' or ev.event == 'VimResized' or offset_y ~= diag_offset_y or not #diags or not vim.deep_equal(diags, diag_diags) then
                pcall(vim.api.nvim_win_close, diag_winid, true)
                diag_diags = nil
                diag_offset_y = nil
                diag_winid = nil
            end
        end

        -- diag window closed and has diags
        if not diag_winid and #diags then
            diag_diags = diags
            diag_offset_y = offset_y
            _, diag_winid = vim.diagnostic.open_float({
                --vim.lsp.util.open_floating_preview.Opts
                focusable = false,
                relative = 'editor',
                max_width = vim.o.columns,
                offset_x = offset_x,
                offset_y = offset_y,
                close_events = {},
                -- vim.diagnostic.Opts.Float
                scope = 'line',
                border = 'single',
                source = 'if_many',
            })
        end
    end
)

vim.g.loaded_matchit = 1
