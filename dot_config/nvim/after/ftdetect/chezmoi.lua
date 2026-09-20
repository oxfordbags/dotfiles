vim.filetype.add({
	extension = {
		tmpl = function(path)
			local filename = vim.fn.fnamemodify(path, ":t:r")
			if filename == ".zshrc" or filename:match("%.zsh$") then
				return "zsh"
			end
			if filename == ".bashrc" or filename:match("%.bash$") then
				return "bash"
			end
			return "conf"
		end,
	},
})
