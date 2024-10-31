return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
      -- "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        -- enable indentation
        indent = { enable = true, disable = { "python" } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        autotag = { enable = true },
        -- ensure these language parsers are installed
        ensure_installed = {
          "json",
          "javascript",
          "typescript",
          "terraform",
          "hcl",
          "tsx",
          "yaml",
          "html",
          "c",
          "cpp",
          "http",
          "css",
          "rust",
          "comment",
          "go",
          "gomod",
          "gowork",
          "gosum",
          "markdown",
          "markdown_inline",
          "query",
          -- "svelte",
          -- "graphql",
          "bash",
          "lua",
          "luadoc",
          "vim",
          "vimdoc",
          "dockerfile",
          "gitignore",
          "php",
          "regex",
          "python",
          "diff",
        },
        -- Add rainbow parentheses
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = 1000,
        },
        -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
        -- require("ts_context_commentstring").setup({
        --   enable = true,
        --   enable_autocmd = false,
        -- }),
        -- auto install above language parsers
        auto_install = true,
      })
    end,
  },
}
