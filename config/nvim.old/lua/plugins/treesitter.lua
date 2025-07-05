return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "RRethy/nvim-treesitter-endwise" },
  opts = {
    endwise = { enabled = true },
    indent = { enabled = true, disable = { "yaml", "ruby" } },
    ensure_installed = {
      "markdown",
      "markdown_inline",
      "ruby",
      "html",
      "javascript",
      "json",
      "lua",
      "embedded_template",
    },
  },
}
