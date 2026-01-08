return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },

		init = function()
			-- Define rubocop formatter BEFORE conform.setup()
			local conform = require("conform")

			conform.formatters.rubocop = {
				command = "bundle",
				args = { "exec", "rubocop", "-A", "--stdin", "$FILENAME" },
				stdin = true,
			}
		end,

		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},

		opts = {
			notify_on_error = false,

			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,

			formatters_by_ft = {
				lua = { "stylua" },
				yaml = { "prettier" },

				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },

				ruby = { "rubocop" },
			},
		},
	},
}
