return {
	-- Enhances Lua LSP with Neovim runtime and plugin type information for better completion and diagnostics
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			{ path = "lazy.nvim", words = { "LazyVim" } },
		},
	},
}
