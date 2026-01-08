return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "lua_ls",
      "ruby_lsp",
      "html",
      "cssls",
    },

  },
  dependencies = {
    { "mason-org/mason.nvim",                     opts = {} },
    "neovim/nvim-lspconfig",
    { "WhoIsSethDaniel/mason-tool-installer.nvim", opts = {
    ensure_installed = {
      "stylua",
      "prettier",
      "rubocop",
    },
    run_on_start = true,
    auto_update = true,
    } },
  },

}
