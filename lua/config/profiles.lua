local current_profile = "Code" -- Default

vim.api.nvim_create_user_command("Profile", function()
    vim.ui.select({"Code", "Mathematics", "Writing"}, {
        prompt = "Select Environment Profile:",
    }, function(choice)
        if not choice then return end
        current_profile = choice
        vim.notify("Profile switched to: " .. choice, vim.log.levels.INFO)

        if choice == "Writing" then
            local ok, zen = pcall(require, "zen-mode")
            if not ok then
                vim.cmd("ZenMode")
            else
                pcall(function() zen.open() end)
            end
            vim.wo.wrap = true
            vim.wo.linebreak = true
            vim.cmd("set spell")
        elseif choice == "Mathematics" then
            local ok, zen = pcall(require, "zen-mode")
            if ok then
                pcall(function() zen.close() end)
            end
            vim.wo.wrap = false
            vim.cmd("set nospell")
        elseif choice == "Code" then
            local ok, zen = pcall(require, "zen-mode")
            if ok then
                pcall(function() zen.close() end)
            end
            vim.wo.wrap = false
            vim.cmd("set nospell")
        end
    end)
end, { desc = "Switch Neovim Profile" })
