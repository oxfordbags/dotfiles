return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Mason manages LSPs and formatters
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },

    -- Optional UI and completion helpers
    "j-hui/fidget.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    -- =============================
    -- 1️⃣ Initialize Mason first
    -- =============================
    require("mason").setup()

    -- =============================
    -- 2️⃣ Define LSP servers
    -- =============================
    local servers = {
      ts_ls = {},
      ruby_lsp = {},
      html = {},
      cssls = {},
      emmet_ls = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
          },
        },
      },
    }

    -- =============================
    -- 3️⃣ Ensure LSP servers are installed
    -- =============================
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
    })

    -- =============================
    -- 4️⃣ Ensure formatters and tools are installed
    -- =============================
    local ensure_tools = { "stylua", "prettier", "rubocop" }
    require("mason-tool-installer").setup({
      ensure_installed = ensure_tools,
      run_on_start = true,
      auto_update = true,
    })

    -- =============================
    -- 5️⃣ Add Mason bin to PATH for Conform
    -- =============================
    vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"

    -- =============================
    -- 6️⃣ Configure each LSP
    -- =============================
    for name, config in pairs(servers) do
      require("lspconfig")[name].setup(config)
    end
  end,
}
