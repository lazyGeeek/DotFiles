-- Leader key is Space

local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves lines up in visual selection" })

-- vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Centered search iteration" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Centered search iteration" })

vim.keymap.set("v", "<", "<gv", opts, { desc = "Move selected lines to left" })
vim.keymap.set("v", ">", ">gv", opts, { desc = "Move selected lines to right" })

-- Paste without replacing clipboard content
vim.keymap.set("x", "<leader>p", [["_dP"]])
vim.keymap.set("v", "p", '"_dP', opts)
vim.keymap.set({ "n", "v" }, "d", [["_d]], { desc = "Delete without copying" })

-- Exit insert mode 
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = true })

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>d", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })

-- Tabs
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew<CR>", { desc = "Open current tab in new tab" })

-- Window split
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window verticaly" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horiz:ontaly" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split equal size" })
vim.keymap.set("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close current split" })

-- LSP
vim.keymap.set("n", "<C-f>", vim.lsp.buf.format, { desc = "Format document" })

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

