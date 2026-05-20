return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  opts = {
    window = {
      width = 85,
      options = {
        number = false,
        relativenumber = false,
        signcolumn = "no",
      }
    },
    plugins = {
      tmux = { enabled = true },
      alacritty = { enabled = true },
    }
  }
}
