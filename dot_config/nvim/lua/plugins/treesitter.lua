return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "main",
	lazy = false,
	config = function()
		require("nvim-treesitter").setup()
		local ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"ruby",
			"css",
			"javascript",
			"toml",
			"yaml",
		}
		require("nvim-treesitter").install(ensure_installed)
	end,
}
-- vim: ts=2 sts=2 sw=2 et
