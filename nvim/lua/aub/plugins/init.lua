return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use

  "christoomey/vim-tmux-navigator", -- tmux & split window navigation

  -- "inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)

  -- Git related plugins
  { "tpope/vim-fugitive", enabled = false },
  { "tpope/vim-rhubarb", enabled = false },

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",
  { "xiyaowong/transparent.nvim", lazy = false },
}
