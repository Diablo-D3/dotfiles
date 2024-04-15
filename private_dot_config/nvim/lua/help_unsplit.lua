local vim = vim
local augroup = vim.api.nvim_create_augroup('help_unsplit', {})

local M = {}

function M.setup()
    vim.api.nvim_create_autocmd('CmdlineLeave', {
        group = augroup,
        callback = function(ev)
            local mods = { silent = true, noautocmd = true, keepalt = true, keeppatterns = true }

            -- split args
            local args = {}
            for arg in vim.fn.getcmdline():gmatch('%S+') do
                table.insert(args, arg)
            end

            local orig_filetype = vim.bo[ev.buf]

            -- match call for :help
            if string.match(args[1] or '', '^h[elp]+$') then
                local tag

                -- process args for tag
                if (#args > 1) then
                    local tagpat = args[2]

                    local help_buf = vim.api.nvim_create_buf(false, true)
                    vim.bo[help_buf].buftype = 'help'
                    local tags = vim.api.nvim_buf_call(help_buf, function()
                        return vim.fn.taglist(tagpat)
                    end)
                    vim.api.nvim_buf_delete(help_buf, { force = true })

                    if (#tags > 0) then
                        tag = tags[1]
                    else
                        -- use real help to emit error message
                        pcall(vim.cmd.help, args[2])
                        return
                    end
                else
                    tag = {}
                    tag.cmd = '/*help*'
                    tag.filename = vim.o.helpfile
                end

                local filename = vim.fn.fnameescape(tag.filename)

                vim.api.nvim_buf_call(ev.buf, function()
                    vim.cmd.edit({ args = { filename }, mods = mods })

                    vim.bo.buftype = 'nofile'
                    vim.bo.buflisted = false
                    vim.bo.bufhidden = 'wipe'
                    vim.bo.filetype = 'help'

                    local has_ts = pcall(vim.treesitter.start, 0)
                    if not has_ts then vim.bo.syntax = 'help' end

                    local cache_hlsearch = vim.v.hlsearch
                    -- Make a "very nomagic" search to account for special characters in tag
                    local search_cmd = string.gsub(tag.cmd, '^/', '\\V')
                    vim.fn.search(search_cmd)
                    vim.v.hlsearch = cache_hlsearch

                    -- vim.cmd('normal! zt')
                    vim.fn.feedkeys('zt', 'nxt')
                end)

                -- :closehelp unless already in help
                if orig_filetype ~= 'help' then
                    vim.api.nvim_create_autocmd('BufAdd', {
                        group = augroup,
                        once = true,
                        callback = function()
                            vim.cmd.helpclose({ mods = mods })
                        end
                    })
                end
            end
        end
    })
end

return M
