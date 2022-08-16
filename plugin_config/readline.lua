---- Configs for readline.nvim .
-- Plugin for readline shortcuts in neovim.

local readline = require('readline')

vim.keymap.set('!', '<c-f>', '<right>')
vim.keymap.set('!', '<c-b>', '<left>')
vim.keymap.set('!', '<m-f>', readline.forward_word)
vim.keymap.set('!', '<m-b>', readline.backward_word)
vim.keymap.set('!', '<c-a>', readline.beginning_of_line)
vim.keymap.set('!', '<c-e>', readline.end_of_line)
vim.keymap.set('!', '<c-d>', '<Delete>')
vim.keymap.set('!', '<c-h>', '<bs>')
vim.keymap.set('!', '<m-bs>', readline.backward_kill_word)
vim.keymap.set('!', '<m-d>', readline.kill_word)
vim.keymap.set('!', '<c-w>', readline.unix_word_rubout)
vim.keymap.set('!', '<c-k>', readline.kill_line)
vim.keymap.set('!', '<c-u>', readline.backward_kill_line)
vim.keymap.set('c', '<c-j>', '<enter>')

