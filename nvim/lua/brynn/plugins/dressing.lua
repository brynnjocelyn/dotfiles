return {
  "stevearc/dressing.nvim",
  opts = { noremap = true, silent = true },
  event = "VeryLazy",
  config = function()
    require("dressing").setup({
      -- Add your custom configurations here
    })
  end,
}
