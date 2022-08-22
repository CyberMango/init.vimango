--[[Table of contents:
    <0>  Helper functions
    <1>  General and UI configs
    <2>  Colors, Fonts, ...
    <3>  Text, tab and indent related
    <4>  Visual mode related
    <5>  Tabpages, windows and buffers
    <6>  Status line
    <7>  Editing mappings
    <8>  Integrated terminal settings
    <9>  Spell checking
    <10> Software developement related
    <11> Config Scripts
-----------------------------------------]]

-----------------------------------------
-- <0>  Helper functions
-----------------------------------------
local lua_utils = require("lua_utils")
require("vimscript_utils")

-----------------------------------------
-- <1>  General and UI configs
-----------------------------------------
-- Use this to make it easier to move settings from vim.o to vim.opt if you swap the two.
local set = vim.o

-- init.lua's directory.
VIMD = vim.env.MYVIMRC:sub(1, -string.len('init.lua') - 2)
vim.cmd(string.format("let VIMD = '%s'", VIMD))
vim.cmd(string.format("let $VIMD = '%s'", VIMD))


-- General
vim.wo.number = true
set.cursorline = true
vim.wo.wrap = false
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Show current position in the file.
set.ruler = true
-- Always show the sign column (the column that marks lines with errors).
set.signcolumn = "yes"
-- Scroll page with 1 line space.
set.scrolloff = 1
-- Number of commands to remember.
set.history = 500

-- Enable filetype plugins.
--TODO is this necessary? whats a better way to do this?
vim.cmd('filetype plugin on')
vim.cmd('filetype indent on')

-- Search related configurations.
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.hlsearch = true
-- Cancel search highlight on esc press.
vim.keymap.set('n', '<esc>', '<esc>:noh<cr>', { silent = true })

-- Easy system clipboard copy-paste.
vim.keymap.set('i', '<c-c>', '<nop>')
vim.keymap.set('v', '<c-c>', '<nop>')
vim.keymap.set('v', '<c-c>c', '"+y')
vim.keymap.set('v', '<c-c>x', '"+d')
vim.keymap.set('v', '<c-c>v', '"+p')
vim.keymap.set('n', '<c-c>v', '"+p')
vim.keymap.set('i', '<c-c>v', '<esc>"+pa')

-- Don't redraw while executing macros (good performance config).
set.lazyredraw = true

-- How vim completions work
set.completeopt = "longest,menuone,preview"

-- Set wildmenu (autocompletions in command line).
set.wildmenu = true
set.wildmode = "longest,full"
-- Command prompt completion keystroke is tab (\t).
set.wildchar = ('\t'):byte()
-- How to refer to wildchar inside of mappings (26 == ctrl-z).
set.wildcharm = 26
-- Ignore compiled files.
set.wildignore = "*.o,*~,*.pyc"

-- Configure backspace so it acts as it should act
set.backspace = "eol,start,indent"

-- Allow left/right to move between lines
--set.whichwrap = set.whichwrap .. '<,>,h,l'

-- For regular expressions turn magic on
set.magic = true

-- Show matching brackets when text indicator is over them
set.showmatch = true
-- How many tenths of a second to blink when matching brackets
set.mat = 2
--
-- No annoying sound on errors
set.errorbells = false
set.visualbell = false
set.t_vb = ""

-- wait 500 milliseconds for mappings to complete
set.timeoutlen = 500

-- Reload vim configs when changing them.
local reload_configs = vim.api.nvim_create_augroup("reload_configs", {})
vim.api.nvim_create_autocmd("BufWritePost", {
    command = "source <afile>",
    pattern = { VIMD .. "/*.vim", VIMD .. "/*.lua" },
    group = reload_configs
})

-- Allow mouse control in normal, visual and command modes.
--set.mouse = "nvc"

-- Make 0 behave like <home> on most editors.
vim.keymap.set("n", "0", lua_utils.goto_line_start, { silent = true, expr = true })
vim.keymap.set("n", "<home>", lua_utils.goto_line_start, { silent = true, expr = true })
vim.keymap.set("i", "<home>", function()
    return "<esc>" .. lua_utils.goto_line_start() .. "i"
end, { silent = true, expr = true })

--TODO this makes sure files are opened unfolded. Find a better way.
vim.api.nvim_create_autocmd("BufReadPost", {
    command = "normal zR",
    group = reload_configs
})

-----------------------------------------
-- <2>  Colors, Fonts, ...
-----------------------------------------
set.termguicolors = true
-- Set utf8 as standard encoding and en_US as the standard language
set.encoding = "utf8"
-- Chosen colorscheme. Called in an error safe way.
pcall(vim.cmd, "colorscheme vscode")

-----------------------------------------
-- <3>  Text, tab and indent related
-----------------------------------------
-- Tab settings
set.expandtab   = true
set.smarttab    = true
-- 1 tab = 4 spaces
set.shiftwidth  = 4
set.tabstop     = 4
set.softtabstop = 4

set.autoindent = true

-- Dont auto comment when going down a line in a comment with enter or O/o
-- (needs to be specifically set for some file types due to ftplugins).
--TODO ask on a forum if this is really the best alternative to set formatoptions-=r
set.formatoptions = string.gsub(set.formatoptions, 'r', '')
set.formatoptions = string.gsub(set.formatoptions, 'o', '')

-- Stop the legacy behavior that cw acts like ce.
set.cpoptions = string.gsub(set.cpoptions, '_', '')

-- Remove trailing whitespace on save (But I now have a smart plugin for it).
--vim.api.nvim_create_autocmd('BufWritePre', {command = '%s/\s\+$//e'})

-----------------------------------------
-- <4>  Visual mode related
-----------------------------------------
-- Visual mode pressing * or # searches for the current selection
vim.keymap.set('v', '*', ':<C-u>call VisualSelection("", "")<CR>/<C-R>=@/<CR><CR>', { silent = true })
vim.keymap.set('v', '#', ':<C-u>call VisualSelection("", "")<CR>?<C-R>=@/<CR><CR>', { silent = true })

-- Stay in visual mode after indenting
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-----------------------------------------
-- <5>  Tabpages, windows and buffers
-----------------------------------------
----- Windows
-- Smart way to move between windows
vim.keymap.set('n', '<m-j>', '<C-W>j')
vim.keymap.set('n', '<m-k>', '<C-W>k')
vim.keymap.set('n', '<m-h>', '<C-W>h')
vim.keymap.set('n', '<m-l>', '<C-W>l')

-- Use Q to exit an unchanged window (usefull for helper windows)
vim.keymap.set('n', 'Q', ':q<cr>', { silent = true })
-- Disable command history (I type this way too many times wrong).
vim.keymap.set('n', 'q:', ':q')

-- Open new split panes on the bottom and on the right
set.splitbelow = true
set.splitright = true

----- Buffers
-- A buffer becomes hidden when it is abandoned
set.hidden = true

-- Allow actions like :find and gf to find files in sub-directories of :pwd
set.path = '.,**'

-- Use :f, :sf and :vf as shortcuts for using :find
vim.cmd('cnoreabbre f find')
vim.cmd('cnoreabbre sf sfind')
vim.cmd('cnoreabbre vf vert sfind')

-- Use existing buffers in the current tab if already open.
set.switchbuf = 'useopen'

-- Return to last edit position when opening files (You want this!).
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local fn = vim.fn

        if fn.expand("%:p"):match(".git") and fn.line("'\"") > 1
            and fn.line("'\"") <= fn.line("$") then
            return
        end

        vim.cmd("normal! g'\"")
        vim.cmd("normal zz")
    end,
})

-- Buffer navigation (mostly done with gb. Next/previous is for a lazy mood).
vim.keymap.set('n', 'gb', ':ls<CR>:b<space>')
vim.keymap.set('n', '<leader>bn', ':bnext<cr>')
vim.keymap.set('n', '<leader>bp', ':bprevious<cr>')
vim.keymap.set('n', '<leader>bs', ':ls<cr>:sb<space>')
vim.keymap.set('n', '<leader>bv', ':ls<cr>:vert sb<space>')

-- Closing buffers.
vim.keymap.set('n', '<leader>bd', ':ls<cr>:bdelete<space>')
vim.keymap.set('n', '<leader>bo', ':w<cr>:tabonly<cr>:%bd<cr><c-o>:bd#<cr>', { silent = true })

----- Tabpages
-- Enable switching to last-active tab
if last_tab == nil then
    last_tab = 1
    last_tab_bkup = 1
end
vim.api.nvim_create_autocmd('TabLeave',
    { command = 'lua last_tab_bkup = last_tab; last_tab = vim.api.nvim_get_current_tabpage()' })
vim.api.nvim_create_autocmd('TabClosed', { command = 'lua last_tab = last_tab_bkup' })
-- if !exists('g:Lasttab')
--     let g:Lasttab = 1
--     let g:Lasttab_backup = 1
-- endif
-- autocmd! TabLeave * let g:Lasttab_backup = g:Lasttab | let g:Lasttab = tabpagenr()
-- autocmd! TabClosed * let g:Lasttab = g:Lasttab_backup

-- Useful mappings for managing tabs.
vim.keymap.set('n', '<leader>te', ':tabedit<space>')
vim.keymap.set('n', '<leader>tf', ':tabfind<space>')
vim.keymap.set('n', '<leader>to', ':tabonly<cr>')
vim.keymap.set('n', '<leader>tc', ':tabclose<cr>')
vim.keymap.set('n', '<leader>tm', ':tabmove<cr>')
vim.keymap.set('n', '<leader>th', ':tab help<space>')
vim.keymap.set('n', '<c-pageup>', ':tabnext<cr>')
vim.keymap.set('n', '<c-pagedown>', ':tabprevious<cr>')
vim.keymap.set('n', '<Leader>tt', ':lua vim.cmd("tabnext " .. last_tab)<cr>', { silent = true })

-- Switch CWD to the directory of the open buffer. Global for all tabpages.
vim.keymap.set('n', '<leader>cd', ':cd %:p:h<cr>')

-----------------------------------------
-- <6>  Status line
-----------------------------------------
-- Always show the status line
set.laststatus = 2

-----------------------------------------
-- <7>  Editing mappings
-----------------------------------------
-- Move lines of text using alt+shift+h/j/k/l.
vim.keymap.set('n', '<c-j>', 'mz:m+<cr>`z')
vim.keymap.set('n', '<c-k>', 'mz:m-2<cr>`z')
vim.keymap.set('v', '<c-j>', ":m'>+<cr>`<my`>mzgv`yo`z")
vim.keymap.set('v', '<c-k>', ":m'<-2<cr>`>my`<mzgv`yo`z")
vim.keymap.set('v', '<c-l>', '>gv4l')
vim.keymap.set('v', '<c-h>', '<gv4h')
vim.keymap.set('n', '<c-l>', '>>')
vim.keymap.set('n', '<c-h>', '<<')

-- Allow paste and undo in insert and visual mode.
vim.keymap.set('i', '<c-v>', '<c-g>u<esc>pa<c-g>u')

-- Make Y yank to end of line (much like C and D).
vim.keymap.set('n', 'Y', 'y$', { silent = true })

-- Use do and dO to turn current line to empty line and move on.
vim.keymap.set('n', 'do', '0Dj')
vim.keymap.set('n', 'dO', '0Dk')

-- Allow undoing changes after reopenning a file.
set.undofile = true
set.undolevels = 1000
set.undoreload = 10000

-- Auto expand brackets.
vim.keymap.set('i', '{<cr>', '{<cr><c-g>u}<esc>O')
vim.keymap.set('i', '(<cr>', '(<cr><c-g>u)<esc>O')

-----------------------------------------
-- <8>  Integrated terminal settings
-----------------------------------------
-- Openning terminals.
vim.keymap.set("n", "gs", "<c-w>s:terminal<cr>i", { silent = true })
vim.keymap.set("n", "<leader>ts", ":tabedit<cr>:terminal<cr>i")

-- Move around the terminal in a way compatible with tmux.
vim.keymap.set("t", "<c-b>[", "<c-\\><c-n>")
vim.keymap.set("t", "<c-b><c-[>", "<c-\\><c-n>")
vim.keymap.set("t", "<c-b>x", "<c-\\><c-n>:bd!<cr>", { silent = true })
vim.keymap.set("t", "<c-b>h", "<c-\\><c-n><c-w>h")
vim.keymap.set("t", "<c-b>j", "<c-\\><c-n><c-w>j")
vim.keymap.set("t", "<c-b>k", "<c-\\><c-n><c-w>k")
vim.keymap.set("t", "<c-b>l", "<c-\\><c-n><c-w>l")

vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal nonumber" })
vim.api.nvim_create_autocmd("TermOpen", { command = "nnoremap <buffer><silent> Q :bd!<cr>" })

-----------------------------------------
-- <9>  Spell checking
-----------------------------------------
-- Toggle spell checking.
vim.keymap.set("n", "<leader>pt", ":setlocal spell!<cr>")

-- Shortcuts using <leader> .
vim.keymap.set("n", "<leader>pn", "]s")
vim.keymap.set("n", "<leader>pp", "[s")
vim.keymap.set("n", "<leader>pa", "zg")
vim.keymap.set("n", "<leader>p?", "z=")

-----------------------------------------
-- <10> Software developement related
-----------------------------------------
-- Basic debugging with gdb inside of vim.
--command! -nargs=1 GDB packadd termdebug | Termdebug <args>
vim.api.nvim_create_user_command("GDB", "packadd termdebug | Termdebug <args>", { nargs = 1 })

-- Shortcuts for using the quickfix list (used by :make and other commands).
vim.keymap.set("n", "<leader>co", ":copen<cr>")
vim.keymap.set("n", "<leader>cc", ":cclose<cr>")
vim.keymap.set("n", "<leader>cn", ":cnext<cr>")
vim.keymap.set("n", "<leader>cp", ":cprevious<cr>")
-- Shortcuts for using the location list (allocated by lsp diagnostics on command).
vim.keymap.set("n", "<leader>lo", ":lopen<cr>")
vim.keymap.set("n", "<leader>lc", ":lclose<cr>")
vim.keymap.set("n", "<leader>ln", ":lnext<cr>")
vim.keymap.set("n", "<leader>lp", ":lprevious<cr>")

-- If quickfix/location list is the last buffer opened, close it.
lua_utils.close_if_last("qf")

----------------------------------------
-- <11> Config Scripts
-----------------------------------------
-- Plugins.
require("packer_config")
