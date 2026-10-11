vim.g.mapleader = " "

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
  callback = function(args)
    require("conform").format({
      bufnr = args.buf,
      async = false,
      lsp_format = "never",
    })
  end,
})

require("wammie.lazy_init")
require("wammie.set")
require("wammie.keymaps")
