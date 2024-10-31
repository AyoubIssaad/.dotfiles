vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt -- for conciseness

-- Nerd Font
vim.g.have_nerd_font = true

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.breakindent = true

-- Mouse Mode
opt.mouse = "a"

-- line wrapping
opt.wrap = false -- disable line wrapping

-- Don't show mode, since it's already in status line
opt.showmode = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- set completeopt to have a better copletion experience
-- opt.completeopt = "menuone,noselect"

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
-- opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- opt.iskeyword:append("-") -- adds dash (-) to the world, so when deleting a word containing a dash it deletes the whole word
-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- Set scrolloff to 8
opt.scrolloff = 3

-- Set an undo file to keep history of changes
-- set undodir=~/.vim/undodir
opt.undodir = vim.fn.stdpath("config") .. "/undodir"
-- opt.undodir = "~/.config/nvim/undodir"
opt.undofile = true
-- Decrease update time
opt.updatetime = 250
opt.timeout = true
opt.timeoutlen = 300

-- Spell checking configuration
opt.spelllang = "en_us"
-- opt.spell = true
-- Set how neovim will display certain whitespace characters in the editor [ INFO:May interfere with another plugin that shows vertical lines]
-- opt.list = true
-- opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
