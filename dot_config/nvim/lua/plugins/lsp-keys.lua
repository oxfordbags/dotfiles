return {
	-- Defines buffer-local keymaps and UI behaviour that activate when an LSP attaches to a buffer
	"neovim/nvim-lspconfig",
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					vim.keymap.set(mode or "n", keys, func, {
						buffer = event.buf,
						desc = "LSP: " .. desc,
					})
				end

				map("grn", vim.lsp.buf.rename, "Rename")
				map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
				map("grd", vim.lsp.buf.definition, "Definition")
				map("grr", vim.lsp.buf.references, "References")
				map("gri", vim.lsp.buf.implementation, "Implementation")
				map("grt", vim.lsp.buf.type_definition, "Type Definition")
			end,
		})

		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded" },
			virtual_text = { spacing = 2 },
		})
	end,
}
