return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    "folke/todo-comments.nvim",
  },
  -- Two important keymaps to use while in Telescope are:
  --  - Insert mode: <c-/>
  --  - Normal mode: ?

  config = function()
    -- import telescope plugin safely
    local telescope = require("telescope")

    -- import telescope actions safely
    local actions = require("telescope.actions")

    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")
    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })
    -- import telescope-ui-select safely
    local themes = require("telescope.themes")

    -- configure telescope
    telescope.setup({
      -- configure custom mappings
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist, -- send selected to quickfixlist
            ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          themes.get_dropdown(),
        },
      },
    })

    -- Enable Telescope extension if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- Shortcut for searching your Neovim configuration files
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[S]earch [N]eovim files" })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" }) -- find files within current working directory, respects .gitignore
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" }) -- find previously opened files
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" }) -- find string in current working directory as you type
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" }) -- find string under cursor in current working directory
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Show open buffers" }) -- list open buffers in current neovim instance
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find Todos" }) -- list available help tags
    keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
    -- keymap.set("n", "<leader>hf", "<cmd>Telescope harpoon marks<cr>", { desc = "Show harpoon marks" }) -- show harpoon marks
    keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Show git commits" }) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
    keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", { desc = "Show git commits for current buffer" }) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
    keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Show git branches" }) -- list git branches (use <cr> to checkout) ["gb" for git branch]
    keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Show current git changes per file" }) -- list current changes per file with diff preview ["gs" for git status]
  end,
}
