return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"j-hui/fidget.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		-- Servers you actually want
		local servers = {
			ts_ls = {},
			ruby_lsp = {},
			html = {},
			cssls = {},
			emmet_ls = {},
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
					},
				},
			},
		}

		-- Tell Mason which LSPs to install
		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_installation = true,
		})

		-- Install non-LSP tools (formatters, etc)
		require("mason-tool-installer").setup({
			ensure_installed = {
				"stylua",
				"prettier",
				"rubocop",
			},
		})

		-- Configure each LSP
		for server, config in pairs(servers) do
			require("lspconfig")[server].setup(config)
		end
	end,
}
