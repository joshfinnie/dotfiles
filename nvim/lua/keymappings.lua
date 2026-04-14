vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

-- :w saves without formatting; :ww saves with formatting
vim.cmd([[cnoreabbrev w noa w]])
vim.cmd([[cnoreabbrev ww write]])

-- Pane navigation
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", opts)
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", opts)
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", opts)
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", opts)

-- Pane management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window

-- copy/paste
vim.keymap.set("v", '<leader>c', '"*yy<CR>', opts)
vim.keymap.set("v", '<leader>v', '"+p<CR>', opts)
vim.keymap.set("n", '<leader>v', '"+p<CR>', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Keep search matches centered
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Delete without yanking
vim.keymap.set("n", "x", '"_x', opts)

-- Paste in visual mode without replacing the yank register
vim.keymap.set("v", "p", '"_dP', opts)

-- Buffer management
vim.keymap.set("n", "<leader>x", ":bdelete!<CR>", opts) -- close buffer

-- Diagnostics
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Open floating diagnostic" })
