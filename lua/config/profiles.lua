local M = {}

function M.switch(choice)
    if not choice then return end
    vim.g.current_profile = choice
    vim.notify("Profile switched to: " .. choice, vim.log.levels.INFO)

    local ok_keys, keys = pcall(require, "config.keys")

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
        if ok_keys then
            keys.setup_writing_keymaps()
        end
    elseif choice == "Mathematics" then
        local ok, zen = pcall(require, "zen-mode")
        if ok then
            pcall(function() zen.close() end)
        end
        vim.wo.wrap = false
        vim.cmd("set nospell")
        if ok_keys then
            keys.clear_writing_keymaps()
        end
    elseif choice == "Code" then
        local ok, zen = pcall(require, "zen-mode")
        if ok then
            pcall(function() zen.close() end)
        end
        vim.wo.wrap = false
        vim.cmd("set nospell")
        if ok_keys then
            keys.clear_writing_keymaps()
        end
    end
end

vim.g.current_profile = "Code" -- Default

vim.api.nvim_create_user_command("Profile", function()
    vim.ui.select({"Code", "Mathematics", "Writing"}, {
        prompt = "Select Environment Profile:",
    }, function(choice)
        M.switch(choice)
    end)
end, { desc = "Switch Neovim Profile" })

return M
