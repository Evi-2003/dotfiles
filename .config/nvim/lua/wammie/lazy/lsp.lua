return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "ts_ls", "eslint", "jsonls", "html", "cssls" },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {},
      },
    },
    opts = {
      ensure_installed = {
        "prettierd",
        "prettier",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    tag = "v3.8.0",
    pin = true,
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    opts = function(_, opts)
      local enabled_servers = {
        ts_ls = true,
        eslint = true,
        jsonls = true,
        html = true,
        cssls = true,
      }

      opts.servers = opts.servers or {}
      local mappings = require("mason-lspconfig.mappings").get_mason_map()
      for server in pairs(mappings.lspconfig_to_package) do
        if not enabled_servers[server] then
          opts.servers[server] = { enabled = false }
        end
      end

      return opts
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({
            async = true,
            lsp_format = "fallback",
          })
        end,
        mode = "",
        desc = "Format",
      },
    },
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },

        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },

        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },

        markdown = { "prettierd", "prettier", stop_after_first = true },
      },

      format_on_save = {
        timeout_ms = 502,
        lsp_format = "fallback",
      },
    },
  },
  {
    "gpanders/editorconfig.nvim",
    event = "VeryLazy",
  },
}
