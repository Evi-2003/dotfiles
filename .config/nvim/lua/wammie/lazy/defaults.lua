return {
        {"folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
	vim.cmd.colorscheme("tokyonight-day")
    end},
{
  "folke/which-key.nvim",
  event = "VeryLazy",
 keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
}
