-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>h", "*#") -- Highlight word under cursor

keymap.set("v", "<leader>y", [["+y]]) -- yank from vim to system clipboard, could be also "*y depending on system
keymap.set("n", "<leader>p", [["+p]]) -- paste from system clipboard to vim, could be also "*p depending on system

keymap.set("n", "x", '"_x') -- When clicking on x in normal mode, the character is not copied into the register

keymap.set("i", "<C-e>", "<C-o>A") -- Use ctl-e to move to the end of line when in insert mode

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Switch between buffers using left and right arrows
keymap.set("n", "<left>", ":bp<cr>")
keymap.set("n", "<right>", ":bn<cr>")

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
-- keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
-- keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Toggle scrollbind for all open windows/splits
keymap.set("n", "<F5>", ":windo set scb!<cr>")
