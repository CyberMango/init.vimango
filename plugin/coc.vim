"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neoclide/coc.nvim plugin configurations.

" Table of contents:
" => Vim settings
" => Usage keymaps
" => CocList
" => Autocommands
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Some servers have issues with backup files.
set nobackup
set nowritebackup

" Bigger messages display.
"TODO consider changing this.
set cmdheight=2

" Faster diagnostic messages (defaults 4000)
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Have a signs colum on the left
set signcolumn=yes

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Usage keymaps.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use tab to trigger completion and navigate.
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" ctrl-space to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to comfirm completion.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Keys for gotos.
" TODO Map gd only for languages you have an lsp for. when you find a way to
" programmatically tell if an lsp exists, change this. maybe just use
" <leader>l* for these actions.
"nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window (Or :help for vim keywords).
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Rename current word.
nmap <leader>lr <Plug>(coc-rename)

" Format selected region.
"TODO manage to use this, and consider making this l= if it works like =.
xmap <leader>lf  <Plug>(coc-format-selected)
nmap <leader>lf  <Plug>(coc-format-selected)

" Do codeAction for selected region, ex: `<leader>aap` for current paragraph.
"TODO realise how you choose the action.
xmap <leader>la  <Plug>(coc-codeaction-selected)
nmap <leader>la  <Plug>(coc-codeaction-selected)

" Do codeAction of current line.
nmap <leader>lc  <Plug>(coc-codeaction)
" Fix autofix problem of current line.
nmap <leader>lq  <Plug>(coc-fix-current)

" Create mappings for function text object (requires document symbols feature of languageserver).
"TODO this is probably like i} and a} (like di}, da}). CONFIRM this!
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"TODO understand what this does!
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer.
"TODO try this.
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer.
"TODO try this!
command! -nargs=? Fold :call CocAction('fold', <f-args>)F

" use `:OR` to organize imports of current buffer.
"TODO understand this!
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support for integration with other plugins. checkout `:h coc-status`
"TODO manage to integrate this with airline/your future *line plugin.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CocList
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"TODO try all of these!!!
"TODO decide on better mappings for these.
" Show all diagnostics
nnoremap <silent> <leader>za  :<C-u>CocList diagnostics<cr>
" Manage extensions
" TODO i might not need a shortcut for this.
nnoremap <silent> <leader>ze  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>zc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>zo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>zs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>zj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>zk  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>zp  :<C-u>CocListResume<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight symbol under cursor on CursorHold
"TODO realise what this does
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    " TODO understand this.
    autocmd FileType json setlocal formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    "TODO realise exactly what this does.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction


function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
