"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Table of contents:
" => General and UI configs
" => Colors, Fonts, ...
" => Text, tab and indent related
" => Visual mode related
" => Tabpages, windows and buffers
" => Status line
" => Editing mappings
" => Integrated terminal settings
" => Spell checking
" => Helper functions
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General and UI configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General and obvious
set number
set nowrap
let mapleader = ' '

" Scroll page with 1 line space.
set so=1

" Number of commands to remember.
set history=500

" Enable filetype plugins.
filetype plugin on
filetype indent on

" Search related configurations.
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <silent> <c-[> <esc>:noh<cr>

" Easy copy-paste between different vim sessions
inoremap <c-c> <nop>
vnoremap <c-c> <nop>
vnoremap <c-c>c "+y
vnoremap <c-c>x "+d
vnoremap <c-c>v "+p
nnoremap <c-c>v "+p
inoremap <c-c>v <esc>"+pa

" Show current position in file
set ruler

" Don't redraw while executing macros (good performance config)
set lazyredraw

" How vim completions work
set completeopt=longest,menuone,preview

" Set wildmenu (autocompletions in command line)
set wildmenu
set wildmode=longest,full
" Command prompt completion keystroke
set wildchar=<tab>
" How to refer to wildchar inside of mappings
set wildcharm=<c-z>

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
endif

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Allow left/right to move between lines
"set whichwrap+=<,>,h,l

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=

" wait 500 milliseconds for mappings to complete
set timeoutlen=500

" Reload vim configs when changing them
autocmd! bufwritepost $MYVIMRC source $MYVIMRC
autocmd! bufwritepost $VIMD/plugin/* source %

" Allow mouse control in normal, visual and command modes.
set mouse=nvc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors, Fonts, ...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on

set termguicolors

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Chosen colorscheme
colorscheme gruvbox8_hard
" Set background (only needed for vim).
set background=dark

" @@@@ Add this to the end of $VIMRUNTIMEPATH/syntax/syntax.vim
"let g:gruvbox_italics = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab settings
set expandtab
set smarttab
" 1 tab = 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

set autoindent

" Dont auto comment when going down a line in a comment with enter or O/o.
"TODO check if this really needs to be in an autocmd
autocmd FileType * setlocal formatoptions-=r formatoptions-=o

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Stay in visual mode after indenting
vnoremap > >gv
vnoremap < <gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabpages, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Windows
" Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Use Q to exit an unchanged window (usefull for helper windows)
nnoremap <silent> Q :q<cr>
" Disable command history (I type this way too many times wrong)
nnoremap q: :q

" Open new split panes on the bottom and on the right
set splitbelow splitright

""" Buffers
" A buffer becomes hidden when it is abandoned
set hidden

" Allow actions like :find and gf to find files in sub-directories of :pwd
set path=.,**

" Use :f, :sf and :vf as shortcuts for using :find
cnoreabbre f find
cnoreabbre sf sfind
cnoreabbre vf vert sfind
"TODO add shortcuts (not commands) for :find,:sfind and :vert sfind

" Use existing buffers in the current tab if already open.
set switchbuf=useopen

" Return to last edit position when opening files (You want this!).
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Buffer navigation (mostly done with gb. Page up/down is for a lazy mood).
nnoremap gb :ls<CR>:b<space>
nnoremap <PageUp> :bnext<cr>
nnoremap <PageDown> :bprevious<cr>
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprevious<cr>
nnoremap <leader>bs :ls<cr>:sb<space>
nnoremap <leader>bv :ls<cr>:vert sb<space>

" Closing buffers.
nnoremap <leader>bd :ls<cr>:bdelete<space>
nnoremap <silent> <leader>bo :w<cr>:tabonly<cr>:%bd<cr><c-o>:bd#<cr>

""" Tabpages
" Enable switching to last-active tab
if !exists('g:Lasttab')
    let g:Lasttab = 1
    let g:Lasttab_backup = 1
endif
autocmd! TabLeave * let g:Lasttab_backup = g:Lasttab | let g:Lasttab = tabpagenr()
autocmd! TabClosed * let g:Lasttab = g:Lasttab_backup

" Useful mappings for managing tabs
nnoremap <leader>te :tabedit<space>
nnoremap <leader>tf :tabfind<space>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove<cr>
nnoremap <leader>th :tab help<space>
nnoremap <c-pageup> :tabnext<cr>
nnoremap <c-pagedown> :tabprevious<cr>
nnoremap <silent> <Leader>tt :execute "tabn " . g:Lasttab<cr>

" Make better labels for tabpages
" Unset this if you want to use my tabline instead of airline's.
"set tabline=%!MyTabLine()

" Switch CWD to the directory of the open buffer. Global for all tabpages.
nnoremap <leader>cd :cd %:p:h<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %F\ \ Line:\ %l\ \ Column:\ %c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map 9 ^

" Move lines of text using ctrl+alt+h/j/k/l.
nnoremap <m-s-j> mz:m+<cr>`z
nnoremap <m-s-k> mz:m-2<cr>`z
vnoremap <m-s-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <m-s-k> :m'<-2<cr>`>my`<mzgv`yo`z
nnoremap <m-s-l> >>
nnoremap <m-s-h> <<
vnoremap <m-s-l> >gv4l
vnoremap <m-s-h> <gv4h

" Allow paste and undo in insert and visual mode.
vnoremap <c-u> <esc>u
inoremap <c-u> <esc>ua
inoremap <c-v> <c-g>u<esc>pa<c-g>u

" Make Y yank to end of line (much like C and D).
nnoremap Y y$

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Integrated terminal settings
" * In these mappings, s stands for shell.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
    nnoremap <silent> gs <c-w>s:terminal<cr>i
    nnoremap <leader>ts :tabedit<cr>:terminal<cr>i
    " Move around the terminal in a way compatible with tmux.
    tnoremap <c-b>[ <c-\><c-n>
    tnoremap <c-b><c-[> <c-\><c-n>

    autocmd TermOpen * setlocal nonumber
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing <leader>ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Tabline format functions.
function MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        if 0 != i
            let s .= '╲  '
        endif

        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'
        " set page number string
        let s .= i + 1 . ''
        " the label is made by MyTabLabel()
        let s .= '%{MyTabLabel(' . (i + 1) . ')}  '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999Xclose'
    endif

    return s
endfunction

function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let is_modified = 0
    let label = ''

    for buffer in buflist
        if getbufvar(buffer, "&modified")
            let is_modified = 1
            break
        endif
    endfor

    if is_modified == 1
        let label .= '❕'
    else
        let label .= ' '
    endif

    let label .= fnamemodify(bufname(buflist[winnr - 1]), ':t')

    return label
endfunction


function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Only use plugins for neovim, not vim.
if has('nvim')
    call plug#begin("~/.config/nvim/vim_plug")
    " File explorer.
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

    " LSP.
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Snippets
    Plug 'sirver/UltiSnips'

    " Colorschemes.
    Plug 'lifepillar/vim-gruvbox8'

    " Statusline/Tabline manager.
    Plug 'vim-airline/vim-airline'
    call plug#end()
endif

