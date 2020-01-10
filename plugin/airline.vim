
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Theme
let g:airline_theme='base16_gruvbox_dark_hard'

" airline symbols
"let g:airline_left_sep = '▙'
"let g:airline_right_sep = '▜'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_close_button = 0

"let g:airline#extensions#tabline#left_sep = '▙'
"let g:airline#extensions#tabline#right_sep = '▜'
" Show tab numbers
let g:airline#extensions#tabline#tab_nr_type = 1

let g:airline#extensions#tabline#left_alt_sep = '╲'
let g:airline#extensions#tabline#right_alt_sep = '╲'

" Dont show the useless 'tab' label on the left of the tabline.
let g:airline#extensions#tabline#show_tab_type = 0

" Coc
let g:airline#extensions#coc#enabled = 0
