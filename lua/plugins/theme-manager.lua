return {
  "f-person/auto-dark-mode.nvim",
  priority = 1000,
  config = function()
    local auto_dark_mode = require("auto-dark-mode")
    
    local state_path = vim.fn.stdpath("state") .. "/active_theme"
    
    local get_saved_theme = function()
      local f = io.open(state_path, "r")
      if f then
        local theme = f:read("*all"):gsub("%s+", "")
        f:close()
        if theme ~= "" then
          return theme
        end
      end
      return "gruvbox"
    end

    local save_theme = function(theme)
      local f = io.open(state_path, "w")
      if f then
        f:write(theme)
        f:close()
      end
    end

    vim.g.active_theme = get_saved_theme()

    local apply_theme = function()
      local bg = vim.o.background
      if vim.g.active_theme == "catppuccin" then
        vim.cmd("colorscheme catppuccin-" .. (bg == "dark" and "mocha" or "latte"))
      elseif vim.g.active_theme == "rose-pine" then
        vim.cmd("colorscheme rose-pine-" .. (bg == "dark" and "moon" or "dawn"))
      elseif vim.g.active_theme == "gruvbox" then
        vim.cmd("colorscheme gruvbox")
      end
    end

    -- Apply the theme immediately on startup to prevent default blue theme flash
    apply_theme()

    auto_dark_mode.setup({
      update_interval = 1000,
      set_dark_mode = function()
        vim.o.background = "dark"
        apply_theme()
      end,
      set_light_mode = function()
        vim.o.background = "light"
        apply_theme()
      end,
    })

    vim.api.nvim_create_user_command("Theme", function()
      vim.ui.select({"gruvbox", "catppuccin", "rose-pine"}, {
        prompt = "Select Theme Family:",
      }, function(choice)
        if not choice then return end
        vim.g.active_theme = choice
        save_theme(choice)
        apply_theme()
      end)
    end, { desc = "Theme Switcher" })
  end,
}
