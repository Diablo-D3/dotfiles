later(function()
    add({
        'http://github.com/NeogitOrg/neogit',
        'http://github.com/nvim-lua/plenary.nvim'
    })

    local neogit = require('neogit')
    neogit.setup({
        graph_style = 'unicode',
        integrations = {
            mini_pick = true
        }
    })
end)
