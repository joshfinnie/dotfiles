require('trouble').setup({
    win = {
        position = "right",
        size = 50,
    }
})

vim.keymap.set("n", "<leader>xx", function()
  vim.cmd("Trouble diagnostics toggle")
end, { desc = "Diagnostics (Trouble)" })

vim.keymap.set("n", "<leader>xX", function()
  vim.cmd("Trouble diagnostics toggle filter.buf=0")
end, { desc = "Buffer Diagnostics (Trouble)" })

vim.keymap.set("n", "<leader>cs", function()
  vim.cmd("Trouble symbols toggle focus=false")
end, { desc = "Symbols (Trouble)" })

vim.keymap.set("n", "<leader>cl", function()
  vim.cmd("Trouble lsp toggle focus=false win.position=right")
end, { desc = "LSP Definitions / references / ... (Trouble)" })

vim.keymap.set("n", "<leader>xL", function()
  vim.cmd("Trouble loclist toggle")
end, { desc = "Location List (Trouble)" })

vim.keymap.set("n", "<leader>xQ", function()
  vim.cmd("Trouble qflist toggle")
end, { desc = "Quickfix List (Trouble)" })
