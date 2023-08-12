
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = {
	  "c",
	  "lua",
	  "vim",
	  "help",
	  "html",
	  "css",
	  "scss",
	  "javascript",
	  "typescript",
	  "tsx",
	  "graphql",
	  "prisma",
	  "scheme",
	  "python",
	  "htmldjango",
	  "php",
	  "phpdoc",
	  "ini",
	  "sql",
	  "markdown",
	  "markdown_inline",
	  "dart",
	  "yaml",
	  "kotlin",
	  "java",
	  "swift",
	  "gitignore",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
	  enable = true,
  },
}

