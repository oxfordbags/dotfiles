vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

require("options")
require("keymaps")

require("lazy-bootstrap")
require("lazy-plugins")

-- vim: ts=2 sts=2 sw=2 et
