return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = true,
	keys = {
		{
			"<A-v>",
			"<cmd>ToggleTerm size=60 direction=vertical<cr>",
			desc = "Toggle vertical terminal",
			mode = { "n", "v", "i", "t" },
		},
		{
			"<A-c>",
			"<cmd>ToggleTerm size=15 direction=horizontal<cr>",
			desc = "Toggle horizontal terminal",
			mode = { "n", "v", "i", "t" },
		},
	},
}
