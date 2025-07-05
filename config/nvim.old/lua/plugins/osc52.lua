-- ~/.config/nvim/lua/plugins/osc52.lua
return {
  "ojroques/nvim-osc52",
  event = "VeryLazy",
  opts = {
    max_length = 0,
    trim = false,
    silent = false,
    tmux = false,
  },
  config = function(_, opts)
    require("osc52").setup(opts)

    -- Copy keybindings (optional if using autocmd below)
    vim.keymap.set("n", "<leader>y", require("osc52").copy_operator, { expr = true })
    vim.keymap.set("n", "<leader>yy", "<leader>y_", { remap = true })
    vim.keymap.set("v", "<leader>y", require("osc52").copy_visual)

    -- 👇 This should trigger on all normal yanks
    vim.api.nvim_create_autocmd("TextYankPost", {
      callback = function()
        print("yank detected") -- for debugging
        if vim.v.event.operator == "y" and vim.v.event.regname == "" then
          print("copying with osc52...")
          require("osc52").copy_register("")
        end
      end,
    })
  end,
}
