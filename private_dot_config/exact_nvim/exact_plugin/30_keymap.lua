-- Cursor
map(nvi, '<C-Left>', 'Move left one word',
    keys('b'))
map(nvi, '<C-Right>', 'Move right one word',
    keys('w'))
map(nvi, '<C-Up>', 'Move up one paragraph',
    keys('{'))
map(nvi, '<C-Down>', 'Move down one paragraph',
    keys('}'))

-- Selection
map(ni, '<C-S-Left>', 'Move line left',
    lua('MiniMove.move_line("left")'))
map(ni, '<C-S-Right>', 'Move line right',
    lua('MiniMove.move_line("right")'))
map(ni, '<C-S-Up>', 'Move line up',
    lua('MiniMove.move_line("up")'))
map(ni, '<C-S-Down>', 'Move line down',
    lua('MiniMove.move_line("down")'))

map(v, '<C-S-Left>', 'Move selection left',
    lua('MiniMove.move_selection("left")'))
map(v, '<C-S-Right>', 'Move selection right',
    lua('MiniMove.move_selection("right")'))
map(v, '<C-S-Up>', 'Move selection up',
    lua('MiniMove.move_selection("up")'))
map(v, '<C-S-Down>', 'Move selection down',
    lua('MiniMove.move_selection("down")'))

-- Windows
map(nvi, '<A-Left>', 'Focus left window',
    keys('<C-w>h'))
map(nvi, '<A-Right>', 'Focus right window',
    keys('<C-w>l'))
map(nvi, '<A-Up>', 'Focus window above',
    keys('<C-w>j'))
map(nvi, '<A-Down>', 'Focus window below',
    keys('<C-w>k'))

-- Leader
map(n, '<Leader>?', 'Keymaps',
    cmd('Pick keymaps'))

-- Buffers
map(n, '<leader>bb', 'Buffers',
    cmd('Pick buffers'))
map(n, '<leader>bd', 'Delete',
    lua('MiniBufremove.delete()'))
map(n, '<leader>bD', 'Delete!',
    lua('MiniBufremove.delete(0, true)'))
map(n, '<leader>bw', 'Wipeout',
    lua('MiniBufremove.wipeout()'))
map(n, '<leader>bW', 'Wipeout!',
    lua('MiniBufremove.wipeout(0, true)'))

-- Finder/Picker
map(n, '<Leader>fe', 'Explorer',
    cmd('Pick explorer'))
map(n, '<Leader>ff', 'Files',
    cmd('Pick files'))
map(n, '<Leader>fm', 'Messages',
    lua('MiniNotify.show_history()'))

-- Language
map(n, '<Leader>la', 'Actions',
    lua('vim.lsp.buf.code_action()'))
map(n, '<Leader>ld', 'Diagnostic',
    lua('vim.diagnostic.open_float()'))
map(n, '<Leader>lD', 'Diagnostics',
    cmd('Pick diagnostic'))
map(nv, '<Leader>lf', 'Format',
    lua('Conform.format()'))
map(n, '<Leader>li', 'Implementation',
    cmd('Pick lsp scope="implementation"'))
map(n, '<Leader>lr', 'Rename',
    lua('vim.lsp.buf.rename()'))
map(n, '<Leader>lR', 'References',
    cmd('Pick lsp scope="references"'))
map(n, '<Leader>ls', 'Source definition',
    cmd('Pick lsp scope="definition"'))
map(n, '<Leader>lS', 'Source decleration',
    cmd('Pick lsp scope="declaration"'))
map(n, '<Leader>lt', 'Type definition',
    cmd('Pick lsp scope="type_definition"'))

-- Git
map(n, '<Leader>gg', 'Neogit status',
    cmd('Neogit'))

-- ft: Help
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'help',
    group = vim.api.nvim_create_augroup('help-enter', { clear = true }),
    callback = function(ev)
        map(n, '<CR>', 'Follow Help Link',
            keys('K'), { buffer = ev.buf })
    end
})
