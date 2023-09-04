
vim.g.mapleader = "\\"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
end)
vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
end)
vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
end)
vim.keymap.set("x", "<leader>ca", function()
    vim.lsp.buf.range_code_action()
end)

vim.keymap.set("n", "gD", function()
    vim.lsp.buf.declaration()
end)
vim.keymap.set("n", "gr", function()
    vim.lsp.buf.references()
end)
vim.keymap.set("n", "gi", function()
    vim.lsp.buf.implementation()
end)
vim.keymap.set("n", "<C-k>", function()
    vim.lsp.buf.signature_help()
end)
vim.keymap.set("n", "<leader>do", function()
  vim.diagnostic.open_float()
end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-n>", function()
    vim.lsp.diagnostic.goto_prev()
end)
vim.keymap.set("n", "<C-p>", function()
    vim.lsp.diagnostic.goto_next()
end)

