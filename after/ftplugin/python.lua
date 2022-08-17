--TODO ask in a forum if this is the best way to concatenate new paths to path.
vim.api.nvim_set_option_value('path', vim.o.path .. ',/usr/lib/python*/**', {scope = 'local'})
vim.api.nvim_set_option_value('path', vim.o.path .. ',~/.local/lib/**/site-packages/**', {scope = 'local'})

-- Run ipython with <leader>ti
vim.keymap.set('n', '<leader>ti', '<c-w>s:terminal<cr>iipython<cr><c-l>', {silent = true, buffer = true})

-- Run main with :make. See output again with :copen. Exists for compatability with cpp commands.
vim.api.nvim_set_option_value('makeprg', 'python3 main.py', {scope = 'local'})

-- Run current file with <F5> in a split window.
vim.keymap.set('n', '<f5>', '<c-w>s4<c-w>-:terminal<space>python3<space>%<cr>i', {buffer = true})
-- Run main file in a split window with ctrl-f5.
vim.keymap.set('n', '<f29>', '<c-w>s4<c-w>-:terminal<space>python3<space>main.py<cr>i', {buffer = true})
