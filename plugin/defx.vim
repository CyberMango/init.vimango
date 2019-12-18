""" Shougo/defx.nvim plugin configurations

""" Openning, focusing and closing settings
" TODO decide if the shortcuts will use '/' or '\'
nnoremap <silent> <a-/> :call DefxToggle()<cr>
" TODO do that the default size wont be restored on resume.
nnoremap <silent> <c-/> :call DefxFocus()<cr>

" Make <c-/> also work on deepin-terminal
nmap  <c-/>

""" Settings
call defx#custom#column('icon', {
    \ 'directory_icon': '⮞',
    \ 'opened_icon': '⮟',
    \ 'root_icon': ' ',
    \ })

call defx#custom#column('filename', {
    \ 'min_width': 25,
    \ 'max_width': 50,
    \ })

call defx#custom#column('mark', {
    \ 'readonly_icon': 'R',
    \ 'selected_icon': '✓',
    \ })

""" Auto actions
autocmd FileType defx call s:defx_my_settings()
autocmd BufWritePost * call defx#redraw()

""" Keymap settings
function! s:defx_my_settings() abort
    " Define mappings
    setlocal cursorline
    nnoremap <silent><buffer> <c-/> <c-w><c-p>
    nnoremap <silent><buffer> v V
    nnoremap <silent><buffer><expr> > defx#do_action('resize', defx#get_context().winwidth + 1)
    nnoremap <silent><buffer><expr> < defx#do_action('resize', defx#get_context().winwidth - 1)
    nnoremap <silent><buffer><expr> d defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> f defx#do_action('new_file')
    nnoremap <silent><buffer><expr> . defx#do_action('repeat')
    nnoremap <silent><buffer><expr> r defx#do_action('rename')
    nnoremap <silent><buffer><expr> <cr> defx#is_directory() ?
        \ defx#async_action("open_or_close_tree") :
        \ defx#async_action("drop")
    nnoremap <silent><buffer><expr> l defx#is_directory() ?
        \ defx#async_action("open_tree") :
        \ defx#do_action('multi', ['drop', ['call',  'Defx_focus']])
    nnoremap <silent><buffer><expr> <space> defx#do_action('toggle_select')
    vnoremap <silent><buffer><expr> <space> defx#do_action('toggle_select_visual')
    nnoremap <silent><buffer><expr> h defx#is_opened_tree() ?
        \ defx#do_action('close_tree') :
        \ Nothing()
    nnoremap <silent><buffer><expr> y defx#async_action("copy")
    nnoremap <silent><buffer><expr> p defx#async_action("paste")
    " TODO change to trash bin remove when you config it system-wise
    nnoremap <silent><buffer><expr> d defx#async_action("remove")
    nnoremap <silent><buffer><expr> s defx#async_action("drop", "split")
endfunc

""" Supporting functions
"TODO realise why this function doesnt work!!!!
function Defx_open() abort
    if defx#is_directory()
        call defx#async_action("open_tree")
        return 1
    else
        call defx#async_action("drop")
        return 0
    endif
endfunc

" Open/close defx with my preferred settings.
function DefxToggle() abort
    Defx -toggle -show-ignored-files -split='vertical' -direction='topleft' -winwidth=24
endfunction

" Toggle defx focus without resizing the window to winwidth.
function! DefxFocus() abort
    if bufwinid("[defx] default-0") == -1
        call DefxToggle()
    else
        Defx
    endif
endfunction

