setlocal path+=/usr/lib/python*/**
setlocal path+=~/.local/lib/**/site-packages/**

" Allow openning ipython easily.
nnoremap <buffer><silent> <leader>ti <c-w>s:terminal<cr>iipython<cr><c-l>

" Run main with :make. See output again with :copen. Exists for compatability with cpp.
setlocal makeprg=python3\ main.py
" Run current file with <F5> in a split window.
nnoremap <buffer> <f5> <c-w>s4<c-w>-:terminal python3 %<cr>
" Run main file in a split window with ctrl-f5.
nnoremap <buffer> <f29> <c-w>s4<c-w>-:terminal python3 main.py<cr>
