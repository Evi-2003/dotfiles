return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<End>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = {
        enabled = true,
      },
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = {
      "CopilotChat",
      "CopilotChatToggle",
      "CopilotChatExplain",
      "CopilotChatFix",
      "CopilotChatReview",
      "CopilotChatTests",
      "CopilotChatReset",
      "CopilotChatPrompts",
      "CopilotChatModels",
    },
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
    },
    build = "make tiktoken",
    opts = {},
    config = function(_, opts)
      require("vim.treesitter.query").add_directive(
        "set-lang-from-info-string!",
        function(match, _, bufnr, predicate, metadata)
          local language_node = match[predicate[2]]
          if type(language_node) == "table" then
            language_node = language_node[1]
          end
          if not language_node then
            return
          end

          local info = vim.treesitter.get_node_text(language_node, bufnr):lower()
          local filetype = vim.filetype.match({ filename = "file." .. info }) or info
          metadata["injection.language"] = vim.treesitter.language.get_lang(filetype) or filetype
        end,
        { force = true }
      )

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "copilot-chat",
        callback = function(event)
          vim.treesitter.start(event.buf, "markdown")
        end,
      })

      require("CopilotChat").setup(opts)
    end,
    keys = {
      {
        "<leader>aa",
        "<cmd>CopilotChatToggle<cr>",
        mode = { "n", "v" },
        desc = "Toggle Copilot Chat",
      },
      {
        "<leader>ce",
        "<cmd>CopilotChatExplain<cr>",
        mode = { "n", "v" },
        desc = "Explain code",
      },
      {
        "<leader>cf",
        "<cmd>CopilotChatFix<cr>",
        mode = { "n", "v" },
        desc = "Fix code",
      },
      {
        "<leader>cr",
        "<cmd>CopilotChatReview<cr>",
        mode = { "n", "v" },
        desc = "Review code",
      },
      {
        "<leader>ct",
        "<cmd>CopilotChatTests<cr>",
        mode = { "n", "v" },
        desc = "Generate tests",
      },
    },
  },
}
