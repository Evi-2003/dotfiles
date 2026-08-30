return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  lazy = false,

  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "elixir",
        "javascript",
        "html",
        "python",
        "typescript",
      },
    })

    -- Enable treesitter highlighting
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "elixir",
        "javascript",
        "html",
        "python",
        "typescript",
      },
      callback = function()
        vim.treesitter.start()
      end,
    })

    -- Enable treesitter indentation
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "elixir",
        "javascript",
        "html",
        "python",
        "typescript",
      },
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
