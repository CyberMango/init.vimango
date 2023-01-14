--[[Table of contents:
    <0>  Helper functions
    <1>  General and UI configs
    <2>  Colors, Fonts, ...
    <3>  Text, tab and indent related
    <4>  Visual mode related
    <5>  Tabpages, windows and buffers
    <6>  Editing mappings
    <7>  Integrated terminal settings
    <8>  Spell checking
    <9>  Software developement related
    <10> Config Scripts
-----------------------------------------]]

-----------------------------------------
-- <0>  Helper functions
-----------------------------------------
local lua_utils = require("lua_utils")
require("vimscript_utils")

-----------------------------------------
-- <1>  General and UI configs
-----------------------------------------
-- init.lua's directory.
VIMD = vim.env.MYVIMRC:sub(1, -string.len("init.lua") - 2)
vim.cmd(string.format("let VIMD = '%s'", VIMD))
vim.cmd(string.format("let $VIMD = '%s'", VIMD))

----- General
vim.wo.number = true
lua_utils.set.cursorline = true
vim.wo.wrap = false
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Show current position in the file.
lua_utils.set.ruler = true
-- Always show the status line.
lua_utils.set.laststatus = 2
-- Always show the sign column (the column that marks lines with errors).
lua_utils.set.signcolumn = "yes"
-- Scroll with a space from the edge of the window.
lua_utils.set.scrolloff = 1
lua_utils.set.sidescrolloff = 1
-- Number of commands to remember.
lua_utils.set.history = 500

-- Search related configurations.
lua_utils.set.ignorecase = true
lua_utils.set.smartcase = true
lua_utils.set.incsearch = true
lua_utils.set.hlsearch = true
-- Cancel search highlight on esc press.
vim.keymap.set("n", "<esc>", "<esc>:noh<cr>", { silent = true })

-- Don't redraw while executing macros (good performance config).
lua_utils.set.lazyredraw = true

-- How vim completions work.
lua_utils.set.completeopt = { "longest", "menuone" }

-- Set wildmenu (autocompletions in command line).
lua_utils.set.wildmenu = true
lua_utils.set.wildmode = "longest,full"
-- Command prompt completion keystroke is tab (\t).
lua_utils.set.wildchar = ("\t"):byte()
-- How to refer to wildchar inside of mappings (26 == ctrl-z).
lua_utils.set.wildcharm = 26
-- Ignore these file patterns when expanding file names.
lua_utils.set.wildignore = "*.o,*~,*.pyc,*.doc,*.docx,*.jpg,*.gif,*.exe,*.img"

-- Allow left/right to move between lines.
--lua_utils.set.whichwrap = lua_utils.set.whichwrap .. '<,>,h,l'

-- For regular expressions turn magic on.
lua_utils.set.magic = true

-- Show matching brackets when text indicator is over them.
lua_utils.set.showmatch = true
-- How many tenths of a second to blink when matching brackets.
lua_utils.set.mat = 2
--
-- No annoying sound on errors.
lua_utils.set.errorbells = false
lua_utils.set.visualbell = false

-- wait 500 milliseconds for mappings to complete.
lua_utils.set.timeoutlen = 500

-- Reload init.lua when it changes.
local init_lua_aus = vim.api.nvim_create_augroup("init_lua_aus", {})
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = string.format("%s/init.lua", VIMD),
    command = "source <afile>",
    group = init_lua_aus
})

-- Allow mouse control in normal, visual and command modes.
--lua_utils.set.mouse = "nvc"
lua_utils.set.mouse = ""

-- Make 0 behave like <home> on most editors.
vim.keymap.set("n", "0", lua_utils.goto_line_start, { silent = true, expr = true })
vim.keymap.set("n", "<home>", lua_utils.goto_line_start, { silent = true, expr = true })
vim.keymap.set("i", "<home>", function()
    return "<esc>" .. lua_utils.goto_line_start() .. "i"
end, { silent = true, expr = true })

-- Go down single visual lines in wrapped text.
vim.keymap.set("n", "k", function() if vim.v.count == 0 then return 'gk' else return 'k' end end,
    { expr = true, silent = true })
vim.keymap.set("n", "j", function() if vim.v.count == 0 then return 'gj' else return 'j' end end,
    { expr = true, silent = true })

-----------------------------------------
-- <2>  Colors, Fonts, ...
-----------------------------------------
lua_utils.set.termguicolors = true
-- Set utf8 as standard encoding and en_US as the standard language
lua_utils.set.encoding = "utf8"
-- Chosen colorscheme. Called in an error safe way.
pcall(vim.cmd, "colorscheme vscode")

-----------------------------------------
-- <3>  Text, tab and indent related
-----------------------------------------
-- Tab settings.
lua_utils.set.expandtab   = true
lua_utils.set.smarttab    = true
-- 1 tab = 4 spaces.
lua_utils.set.shiftwidth  = 4
lua_utils.set.tabstop     = 4
lua_utils.set.softtabstop = 4

lua_utils.set.autoindent = true
-- Round the shift (tab) to a multiply of shiftwidth.
lua_utils.set.shiftround = true

-- Dont auto comment when going down a line in a comment with enter or O/o .
-- (needs to be specifically set for some file types due to ftplugins).
lua_utils.set.formatoptions:remove({ "r", "o" })

-- Stop the legacy behavior that cw acts like ce.
lua_utils.set.cpoptions:remove("_")

-- Remove trailing whitespace on save (But I now have a smart plugin for it).
--vim.api.nvim_create_autocmd('BufWritePre', {command = '%s/\s\+$//e', group = init_lua_aus})

-----------------------------------------
-- <4>  Visual mode related
-----------------------------------------
-- Visual mode pressing * or # searches for the current selection
vim.keymap.set("v", "*", ':<C-u>call VisualSelection("", "")<CR>/<C-R>=@/<CR><CR>', { silent = true })
vim.keymap.set("v", "#", ':<C-u>call VisualSelection("", "")<CR>?<C-R>=@/<CR><CR>', { silent = true })

-- Stay in visual mode after indenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Pasting over visually selected text wont copy it.
vim.keymap.set("v", "p", '"_dP')

-----------------------------------------
-- <5>  Tabpages, windows and buffers
-----------------------------------------
----- Windows
-- Smart way to move between windows
vim.keymap.set('n', '<m-j>', '<C-W>j')
vim.keymap.set('n', '<m-k>', '<C-W>k')
vim.keymap.set('n', '<m-h>', '<C-W>h')
vim.keymap.set('n', '<m-l>', '<C-W>l')

-- Use Q to exit an unchanged window (usefull for helper windows).
vim.keymap.set('n', 'Q', ':q<cr>', { silent = true })
-- Disable command history (I type this way too many times wrong).
vim.keymap.set('n', 'q:', ':q')

-- Open new split panes on the bottom and on the right.
lua_utils.set.splitbelow = true
lua_utils.set.splitright = true

----- Buffers
-- A buffer becomes hidden when it is abandoned.
lua_utils.set.hidden = true

-- Allow actions like :find and gf to find files in sub-directories of :pwd .
lua_utils.set.path:append("**")

-- Use :f, :sf and :vf as shortcuts for using :find .
vim.cmd("cnoreabbre f find")
vim.cmd("cnoreabbre sf sfind")
vim.cmd("cnoreabbre vf vert sfind")

-- Use existing buffers in the current tab if already open.
lua_utils.set.switchbuf = 'useopen'

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
    group = init_lua_aus
})

-- Buffer navigation (mostly done with gb. Next/previous is for a lazy mood).
vim.keymap.set("n", "gb", ":ls<CR>:b<space>")
vim.keymap.set("n", "<leader>bn", ":bnext<cr>")
vim.keymap.set("n", "<leader>bp", ":bprevious<cr>")
vim.keymap.set("n", "<leader>bs", ":ls<cr>:sb<space>")
vim.keymap.set("n", "<leader>bv", ":ls<cr>:vert sb<space>")
vim.keymap.set("n", "<Leader>bb", "<c-6>")

-- Closing buffers.
vim.keymap.set("n", "<leader>bd", ":ls<cr>:bdelete<space>")
vim.keymap.set("n", "<leader>bo", ":w<cr>:tabonly<cr>:%bd<cr><c-o>:bd#<cr>", { silent = true })

----- Tabpages
-- Enable switching to last active tab.
if Last_tab == nil then
    Last_tab = 1
    Last_tab_backup = 1
end
vim.api.nvim_create_autocmd("TabLeave", {
    callback = function()
        Last_tab_backup = Last_tab
        Last_tab = vim.api.nvim_get_current_tabpage()
    end,
    group = init_lua_aus
})
vim.api.nvim_create_autocmd("TabClosed", {
    callback = function() Last_tab = Last_tab_backup end,
    group = init_lua_aus
})

-- Useful mappings for managing tabs.
vim.keymap.set("n", "<leader>te", ":tabedit<space>")
vim.keymap.set("n", "<leader>tf", ":tabfind<space>")
vim.keymap.set("n", "<leader>to", ":tabonly<cr>")
vim.keymap.set("n", "<leader>tc", ":tabclose<cr>")
vim.keymap.set("n", "<leader>tm", ":tabmove<cr>")
vim.keymap.set("n", "<leader>th", ":tab help<space>")
vim.keymap.set("n", "<c-pageup>", ":tabnext<cr>")
vim.keymap.set("n", "<c-pagedown>", ":tabprevious<cr>")
vim.keymap.set("n", "<Leader>tt", ":lua vim.cmd('tabnext ' .. Last_tab)<cr>", { silent = true })

-- Switch CWD to the directory of the open buffer. Global for all tabpages.
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<cr>")

-----------------------------------------
-- <6>  Editing mappings
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

-- Allow paste in insert mode.
vim.keymap.set('i', '<c-v>', '<c-g>u<esc>pa<c-g>u')

-- Make Y yank to end of line (much like C and D).
vim.keymap.set('n', 'Y', 'y$', { silent = true })

-- Use do and dO to turn current line to empty line and move on.
vim.keymap.set('n', 'do', '0Dj')
vim.keymap.set('n', 'dO', '0Dk')

-- Allow undoing changes after reopenning a file.
lua_utils.set.undofile = true
lua_utils.set.undolevels = 1000
lua_utils.set.undoreload = 10000

-- Auto expand brackets.
vim.keymap.set('i', '{<cr>', '{<cr><c-g>u}<esc>O')
vim.keymap.set('i', '(<cr>', '(<cr><c-g>u)<esc>O')

-- Easy system clipboard copy-paste.
vim.keymap.set("i", "<c-c>", "<nop>")
vim.keymap.set("v", "<c-c>", "<nop>")
vim.keymap.set("v", "<c-c>c", '"+y')
vim.keymap.set("v", "<c-c>x", '"+d')
vim.keymap.set("v", "<c-c>v", '"+p')
vim.keymap.set("n", "<c-c>v", '"+p')
vim.keymap.set("i", "<c-c>v", '<esc>"+pa')

-- Highlight yanked lines.
vim.api.nvim_create_autocmd("TextYankPost", {
    command = "lua vim.highlight.on_yank()",
    group = init_lua_aus,
})

-- Configure backspace so it acts as it should act.
lua_utils.set.backspace = "eol,start,indent"

-----------------------------------------
-- <7>  Integrated terminal settings
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

vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal nonumber", group = init_lua_aus })
vim.api.nvim_create_autocmd("TermOpen", {
    command = "nnoremap <buffer><silent> Q :bd!<cr>",
    group = init_lua_aus
})

-----------------------------------------
-- <8>  Spell checking
-----------------------------------------
-- Toggle spell checking.
vim.keymap.set("n", "<leader>pt", ":setlocal spell!<cr>")

-- Shortcuts using <leader> .
vim.keymap.set("n", "<leader>pn", "]s")
vim.keymap.set("n", "<leader>pp", "[s")
vim.keymap.set("n", "<leader>pa", "zg")
vim.keymap.set("n", "<leader>p?", "z=")

-----------------------------------------
-- <9> Software developement related
-----------------------------------------
-- Basic debugging with gdb inside of vim.
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

-- Dont open files folded.
lua_utils.set.foldlevel = 99

----------------------------------------
-- <10> Config Scripts
-----------------------------------------
-- Plugins.
require("packer_config")
