-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- increment / decrease a number with +-
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- deleting a word backwords
map("n", "dw", "vb_d")

-- select all
map("n", "<C-a>", "gg<S-v>G")

-- jumplist
map("n", "<C-m>", "<C-i>", opts)

-- new tab
map("n", "te", ":tabedit", opts)
map("n", "<tab>", ":tabnext<Return>", opts)
map("n", "<s-tab>", ":tabprev<Return>", opts)

-- split window
map("n", "ss", ":split<Return>", opts)
map("n", "sv", ":vsplit<Return>", opts)

-- Move window
map("n", "sh", "<C-w>h")
map("n", "sk", "<C-w>k")
map("n", "sj", "<C-w>j")
map("n", "sl", "<C-w>l")

-- Resize window
map("n", "<C-w><left>", "<C-w><")
map("n", "<C-w><right>", "<C-w>>")
map("n", "<C-w><up>", "<C-w>+")
map("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
map("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)
