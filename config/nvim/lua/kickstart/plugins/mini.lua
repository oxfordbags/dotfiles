return {
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			require("mini.pairs").setup({
				modes = { insert = true, command = true, terminal = false },
				-- skip autopair when next character is one of these
				skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
				-- skip autopair when the cursor is inside these treesitter nodes
				skip_ts = { "string" },
				-- skip autopair when next character is closing pair
				-- and there are more closing pairs than opening pairs
				skip_unbalanced = true,
				-- better deal with markdown code blocks
				markdown = true,
			})
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
