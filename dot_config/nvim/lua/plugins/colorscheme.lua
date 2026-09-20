return {
	"catppuccin/nvim",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	config = function()
		-- Follow 'background': latte when light, mocha when dark. Nvim keeps it in
		-- sync with the terminal, which follows the macOS appearance.
		local function apply()
			local flavour = vim.o.background == "light" and "catppuccin-latte" or "catppuccin-mocha"
			if vim.g.colors_name ~= flavour then
				vim.cmd.colorscheme(flavour)
			end
		end

		apply()
		vim.api.nvim_create_autocmd("OptionSet", { pattern = "background", callback = apply })
	end,
}
