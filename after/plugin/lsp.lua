
local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
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
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({select = true}),
	['<C-Space>'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })

  vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover()

    vim.defer_fn(function()
      vim.diagnostic.open_float({
        scope = 'cursor',
        focusable = false,
        border = 'rounded',
      })
    end, 100)
  end, { buffer = bufnr, desc = 'Show hover + diagnostics' })
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,      -- Show inline errors (optional)
  signs = true,             -- Show signs in the gutter
  update_in_insert = false, -- Don't update diagnostics while typing
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',      -- Show diagnostic source (e.g., "eslint")
    header = '',            -- No header
    prefix = '',            -- No prefix
  },
})

vim.filetype.add({
  extension = {
    sksl = "glsl",
  },
})

require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({})
  end,

  ["glsl_analyzer"] = function()
    require("lspconfig").glsl_analyzer.setup({
      filetypes = { "glsl", "sksl" },
    })
  end,
})
