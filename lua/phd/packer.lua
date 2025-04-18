-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use ('wbthomason/packer.nvim')
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
		'sainnhe/gruvbox-material',
		as = 'gruvbox-material',
		config = function ()
			vim.cmd('colorscheme gruvbox-material')
		end
	}
	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use('mbbill/undotree')
	use('tpope/vim-fugitive')
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},         -- Required
			{'hrsh7th/cmp-nvim-lsp'},     -- Required
			{'hrsh7th/cmp-buffer'},       -- Optional
			{'hrsh7th/cmp-path'},         -- Optional
			{'saadparwaiz1/cmp_luasnip'}, -- Optional
			{'hrsh7th/cmp-nvim-lua'},     -- Optional

			-- Snippets
			{'L3MON4D3/LuaSnip'},             -- Required
			{'rafamadriz/friendly-snippets'}, -- Optional
		}
	}
    use('mhinz/vim-signify')
    use('vim-airline/vim-airline')
    use('dart-lang/dart-vim-plugin')
    use('ThePrimeagen/vim-be-good')
    use('folke/twilight.nvim')
    use {
        'lukas-reineke/headlines.nvim',
        after = 'nvim-treesitter',
        config = function()
            require('headlines').setup()
        end,
    }
    use {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {}
        end
    }
end)

