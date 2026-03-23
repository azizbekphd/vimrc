require('mason').setup({})

local servers = {
  'eslint',
  'cssls',
  'emmet_ls',
  'grammarly',
  'graphql',
  'html',
  'jsonls',
  'jdtls',
  'kotlin_language_server',
  'marksman',
  'intelephense',
  'prismals',
  'pylsp',
  'sqlls',
  'lemminx',
  'yamlls',
}

require('mason-lspconfig').setup({
  ensure_installed = servers,
})

-- Capabilities for nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Apply default config to all servers
-- This sets up capabilities for any server enabled via vim.lsp.enable()
vim.lsp.config('*', {
  capabilities = capabilities,
})

-- Manually enable the servers listed above.
-- In Neovim 0.11+, vim.lsp.enable() automatically finds the configuration
-- in the 'lsp/' directory provided by nvim-lspconfig.
for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

-- Keymaps and Autocmds
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    -- User's custom hover logic: Hover + Diagnostics
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover()

      vim.defer_fn(function()
        vim.diagnostic.open_float({
          scope = 'cursor',
          focusable = false,
          border = 'rounded',
        })
      end, 100)
    end, { buffer = event.buf, desc = 'Show hover + diagnostics' })

    -- Standard LSP keymaps
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('n', '<F2>', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set({'n', 'x'}, '<F3>', function() vim.lsp.buf.format({async = true}) end, opts)
    vim.keymap.set('n', '<F4>', function() vim.lsp.buf.code_action() end, opts)
    
    -- Diagnostic keymaps
    vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
  end,
})

-- Autocompletion Setup
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Diagnostic Config
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

-- Custom Filetypes
vim.filetype.add({
  extension = {
    sksl = "glsl",
  },
})
