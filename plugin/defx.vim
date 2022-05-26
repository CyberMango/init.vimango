""" Shougo/defx.nvim plugin configurations

""" Openning, focusing and closing settings
nnoremap <silent> <a-/> :call DefxToggle()<cr>
nnoremap <silent> <c-/> :call DefxFocus('')<cr>

" Make <c-/> also work on deepin-terminal
nmap  <c-/>

""" Settings
call defx#custom#column('icon', {
    \ 'directory_icon': '>',
    \ 'opened_icon': 'v',
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
autocmd WinEnter * if &ft == 'defx' && winnr('$') == 1 | q | endif
autocmd BufWritePost * call defx#redraw()

""" Keymap settings
function! s:defx_my_settings() abort
    " Define mappings
    setlocal cursorline
    nnoremap <silent><buffer> <c-/> <c-w><c-p>
    nnoremap <silent><buffer> v V
    nnoremap <silent><buffer> <c-[> :noh<cr>:call defx#call_async_action("clear_select_all")<cr>
    nnoremap <silent><buffer><expr> <space> defx#do_action('toggle_select')
    vnoremap <silent><buffer><expr> <space> defx#do_action('toggle_select_visual')
    nnoremap <silent><buffer><expr> . defx#do_action('repeat')
    nnoremap <silent><buffer><expr> > defx#do_action('resize', defx#get_context().winwidth + 1)
    nnoremap <silent><buffer><expr> < defx#do_action('resize', defx#get_context().winwidth - 1)
    nnoremap <silent><buffer><expr> I defx#do_action("toggle_ignored_files")
    nnoremap <silent><buffer><expr> d defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> f defx#do_action('new_file')
    nnoremap <silent><buffer><expr> r defx#do_action('rename')
    nnoremap <silent><buffer><expr> <cr> defx#is_directory() ?
        \ defx#async_action("open_or_close_tree") :
        \ defx#async_action("drop")
    nnoremap <silent><buffer><expr> l defx#is_directory() ?
        \ defx#async_action("open_tree") :
        \ defx#do_action('multi', ['drop', ['call',  'DefxFocus']])
    nnoremap <silent><buffer><expr> h defx#do_action('close_tree')
    nnoremap <silent><buffer><expr> y defx#async_action("copy")
    nnoremap <silent><buffer><expr> p defx#async_action("paste")
    " TODO bug here. This wont work on an open tree (not recursively open).
    nnoremap <silent><buffer><expr> o defx#async_action("open_tree_recursive")
    " TODO there is a bug here. If the file is open in another tabpage, it
    " takes you there instead of openning it.
    nnoremap <silent><buffer><expr> i defx#async_action("drop", "split")
    nnoremap <silent><buffer><expr> gi defx#do_action('multi', [['drop', "split"], ['call',  'DefxFocus']])
    nnoremap <silent><buffer><expr> s defx#async_action("drop", "vsplit")
    nnoremap <silent><buffer><expr> gs defx#do_action('multi', [['drop', "vsplit"], ['call',  'DefxFocus']])
    nnoremap <silent><buffer><expr> t defx#async_action("drop", "tabedit")
    nnoremap <silent><buffer><expr> T defx#do_action('multi', [['drop', "tabedit"], ['call',  'DefxFocus']])
    nnoremap <silent><buffer><expr> u defx#do_action("cd", "..")
    nnoremap <silent><buffer><expr> ct defx#do_action("cd", fnamemodify(defx#get_candidate().action__path, ":p:h"))
    nnoremap <silent><buffer><expr> cd defx#async_action("change_vim_cwd")
    nnoremap <silent><buffer><expr> cT defx#do_action("cd", getcwd())
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
function! DefxFocus(context) abort
    if bufwinid("[defx] default-0") == -1
        call DefxToggle()
    else
        Defx
    endif
endfunction

