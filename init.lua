--[[ Table of contents:
-- <1>  General and UI configs
-- <2>  Colors, Fonts, ...
-- <3>  Text, tab and indent related
-- <4>  Visual mode related
-- <5>  Tabpages, windows and buffers
-- <6>  Status line
-- <7>  Editing mappings
-- <8>  Integrated terminal settings
-- <9>  Spell checking
-- <10> Software developement related
-- <11> Helper functions
-- <12> Plugins
--]]

-----------------------------------------
-- <1>  General and UI configs
-----------------------------------------
vim.o.hlsearch = true
vim.wo.number = true
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-----------------------------------------
-- <2>  Colors, Fonts, ...
-----------------------------------------
-----------------------------------------
-- <3>  Text, tab and indent related
-----------------------------------------
-----------------------------------------
-- <4>  Visual mode related
-----------------------------------------
-----------------------------------------
-- <5>  Tabpages, windows and buffers
-----------------------------------------
-----------------------------------------
-- <6>  Status line
-----------------------------------------
-----------------------------------------
-- <7>  Editing mappings
-----------------------------------------
-- Move lines of text using ctrl+alt+h/j/k/l.
--nnoremap <m-s-j> mz:m+<cr>`z
--nnoremap <m-s-k> mz:m-2<cr>`z
--vnoremap <m-s-j> :m'>+<cr>`<my`>mzgv`yo`z
--vnoremap <m-s-k> :m'<-2<cr>`>my`<mzgv`yo`z
--nnoremap <m-s-l> >>
--nnoremap <m-s-h> <<
--vnoremap <m-s-l> >gv4l
--vnoremap <m-s-h> <gv4h

-- Allow paste and undo in insert and visual mode.
vim.keymap.set('v', '<c-u>', '<esc>u')
vim.keymap.set('i', '<c-u>', '<esc>ua')
vim.keymap.set('i', '<c-v>', '<c-g>u<esc>pa<c-g>u')

-- Make Y yank to end of line (much like C and D).
vim.keymap.set('n', 'Y', 'y$', { silent = true })

-- Allow undoing changes after reopenning a file.
--set undofile
--set undolevels=1000
--set undoreload=10000
--
---- Auto expand brackets.
--inoremap {<cr> {<cr><c-g>u}<esc>O
--inoremap (<cr> (<cr><c-g>u)<esc>O
-----------------------------------------
-- <8>  Integrated terminal settings
-----------------------------------------
-----------------------------------------
-- <9>  Spell checking
-----------------------------------------
-----------------------------------------
-- <10> Software developement related
-----------------------------------------
-----------------------------------------
-- <11> Helper functions
-----------------------------------------
-----------------------------------------
-- <12> Plugins
-----------------------------------------
