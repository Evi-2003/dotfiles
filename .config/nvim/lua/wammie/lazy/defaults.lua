return {
        {"folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
	vim.cmd.colorscheme("tokyonight-night")
    end},
        {
  "folke/which-key.nvim",
  event = "VeryLazy",
},
        { 'nvim-mini/mini.icons', version = '*' },
        { 'nvim-tree/nvim-web-devicons' },

{
  "startup-nvim/startup.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
  config = function()
    require "startup".setup()
  end
}
}
