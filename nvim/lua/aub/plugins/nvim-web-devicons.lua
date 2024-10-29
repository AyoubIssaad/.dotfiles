return {
  "nvim-tree/nvim-web-devicons",
  -- tag = "nerd-v2-compat",
  config = function()
    require("nvim-web-devicons").set_icon({
      gql = {
        icon = "",
        color = "#e535ab",
        cterm_color = "199",
        name = "GraphQL",
      },
    })
  end,
}
