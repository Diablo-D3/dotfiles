later(function()
    add('NeogitOrg/neogit')
    add('nvim-lua/plenary.nvim')

    local neogit = require('neogit')
    neogit.setup({
        graph_style = 'unicode',
        integrations = {
            mini_pick = true
        }
    })
end)
