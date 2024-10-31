-- [[ Enhanced Auto-commands ]]
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
-- General settings augroup
local general_settings = augroup("GeneralSettings", { clear = true })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Don't auto comment new lines
autocmd("BufEnter", {
  group = general_settings,
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- Remove whitespace on save
autocmd("BufWritePre", {
  group = general_settings,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Return to last edit position when opening files
autocmd("BufReadPost", {
  group = general_settings,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
