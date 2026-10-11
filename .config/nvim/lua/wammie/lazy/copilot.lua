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
          accept = "<C-Space>",
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
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
    },
    build = "make tiktoken",
    opts = {},
    keys = {
      {
        "<leader>cc",
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
