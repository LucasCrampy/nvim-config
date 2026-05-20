local M = {}

local function read_template(filename, replacements)
  local path = vim.fn.stdpath("config") .. "/templates/" .. filename
  local f = io.open(path, "r")
  if not f then
    vim.notify("Could not open template file: " .. path, vim.log.levels.ERROR)
    return {}
  end
  local content = f:read("*all")
  f:close()

  for placeholder, val in pairs(replacements) do
    -- Escape special character % in replacement value
    local escaped_val = tostring(val):gsub("%%", "%%%%")
    content = content:gsub(placeholder, escaped_val)
  end

  -- Split content by lines
  local lines = {}
  for line in content:gmatch("([^\n]*)\n?") do
    table.insert(lines, line)
  end
  -- Remove trailing empty line that gmatch might capture
  if #lines > 0 and lines[#lines] == "" then
    table.remove(lines)
  end
  return lines
end

local function pick_or_create_folder(base_path, prompt_title, callback)
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  vim.fn.mkdir(base_path, "p")
  local folders = {}
  local handle = vim.loop.fs_scandir(base_path)
  if handle then
    while true do
      local name, type = vim.loop.fs_scandir_next(handle)
      if not name then break end
      if type == "directory" then
        table.insert(folders, name)
      end
    end
  end

  pickers.new({}, {
    prompt_title = prompt_title .. " (Type new name or select existing)",
    finder = finders.new_table({
      results = folders,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        local current_line = action_state.get_current_line()
        actions.close(prompt_bufnr)

        local chosen_folder
        local exact_match = false
        for _, f in ipairs(folders) do
          if f == current_line then
            exact_match = true
            chosen_folder = f
            break
          end
        end

        if not exact_match then
          if current_line and current_line ~= "" then
            chosen_folder = current_line
          elseif selection then
            chosen_folder = selection.value
          end
        end

        if not chosen_folder or chosen_folder == "" then
          vim.notify("No folder selected or entered", vim.log.levels.WARN)
          return
        end

        callback(chosen_folder)
      end)
      return true
    end,
  }):find()
end

local templates = {
  ["Python Math Script (.py)"] = function()
    local base_path = vim.fn.expand("~/math-vim")
    pick_or_create_folder(base_path, "Select Math Class/Folder", function(folder)
      vim.ui.input({ prompt = "Enter script name (leave blank for [date].py): " }, function(name)
        local date = os.date("%Y-%m-%d")
        local filename
        if not name or name == "" then
          filename = date .. ".py"
        else
          filename = name .. "-" .. date .. ".py"
        end
        local parent_dir = base_path .. "/" .. folder
        vim.fn.mkdir(parent_dir, "p")
        local filepath = parent_dir .. "/" .. filename

        local lines = read_template("python_math.py", { ["{{DATE}}"] = date })
        vim.fn.writefile(lines, filepath)
        
        -- Switch to Mathematics profile
        require("config.profiles").switch("Mathematics")

        vim.cmd("edit " .. vim.fn.fnameescape(filepath))
        vim.notify("Created and opened: " .. filepath, vim.log.levels.INFO)
      end)
    end)
  end,

  ["MATLAB Script (.m)"] = function()
    local base_path = vim.fn.expand("~/math-vim")
    pick_or_create_folder(base_path, "Select MATLAB Class/Folder", function(folder)
      vim.ui.input({ prompt = "Enter script name (leave blank for [date].m): " }, function(name)
        local date = os.date("%Y-%m-%d")
        local filename
        if not name or name == "" then
          filename = date .. ".m"
        else
          filename = name .. "-" .. date .. ".m"
        end
        local parent_dir = base_path .. "/" .. folder
        vim.fn.mkdir(parent_dir, "p")
        local filepath = parent_dir .. "/" .. filename

        local lines = read_template("matlab.m", { ["{{DATE}}"] = date })
        vim.fn.writefile(lines, filepath)

        -- Switch to Mathematics profile
        require("config.profiles").switch("Mathematics")

        vim.cmd("edit " .. vim.fn.fnameescape(filepath))
        vim.notify("Created and opened: " .. filepath, vim.log.levels.INFO)
      end)
    end)
  end,

  ["Standalone LaTeX Document (.tex)"] = function()
    local base_path = vim.fn.expand("~/writing-vim")
    pick_or_create_folder(base_path, "Select Writing Class/Folder", function(folder)
      vim.ui.input({ prompt = "Enter document name (leave blank for [date].tex): " }, function(name)
        local date = os.date("%Y-%m-%d")
        local filename
        if not name or name == "" then
          filename = date .. ".tex"
        else
          filename = name .. "-" .. date .. ".tex"
        end
        local parent_dir = base_path .. "/" .. folder
        vim.fn.mkdir(parent_dir, "p")
        local filepath = parent_dir .. "/" .. filename

        local lines = read_template("latex_article.tex", { ["{{DATE}}"] = date })
        vim.fn.writefile(lines, filepath)

        -- Switch to Writing profile
        require("config.profiles").switch("Writing")

        vim.cmd("edit " .. vim.fn.fnameescape(filepath))
        vim.notify("Created and opened: " .. filepath, vim.log.levels.INFO)
      end)
    end)
  end,

  ["Full LaTeX Project (Multi-file)"] = function()
    local base_path = vim.fn.expand("~/writing-vim")
    pick_or_create_folder(base_path, "Select/Enter LaTeX Project Folder", function(folder)
      local parent_dir = base_path .. "/" .. folder
      vim.fn.mkdir(parent_dir, "p")

      local main_path = parent_dir .. "/main.tex"
      local bib_path = parent_dir .. "/references.bib"
      local gitignore_path = parent_dir .. "/.gitignore"

      local main_lines = read_template("latex_project_main.tex", { ["{{PROJECT_NAME}}"] = folder })
      local bib_lines = read_template("latex_project_references.bib", {})
      local gitignore_lines = read_template("latex_project_gitignore", {})

      vim.fn.writefile(main_lines, main_path)
      vim.fn.writefile(bib_lines, bib_path)
      vim.fn.writefile(gitignore_lines, gitignore_path)

      -- Switch to Writing profile
      require("config.profiles").switch("Writing")

      vim.cmd("edit " .. vim.fn.fnameescape(main_path))
      vim.notify("Created LaTeX Project in: " .. parent_dir, vim.log.levels.INFO)
    end)
  end,

  ["Academic Markdown Essay (.md)"] = function()
    local base_path = vim.fn.expand("~/writing-vim")
    pick_or_create_folder(base_path, "Select Writing Class/Folder", function(folder)
      vim.ui.input({ prompt = "Enter document name (leave blank for [date].md): " }, function(name)
        local date = os.date("%Y-%m-%d")
        local filename
        if not name or name == "" then
          filename = date .. ".md"
        else
          filename = name .. "-" .. date .. ".md"
        end
        local parent_dir = base_path .. "/" .. folder
        vim.fn.mkdir(parent_dir, "p")
        local filepath = parent_dir .. "/" .. filename

        local lines = read_template("academic_essay.md", { ["{{DATE}}"] = date })
        vim.fn.writefile(lines, filepath)

        -- Switch to Writing profile
        require("config.profiles").switch("Writing")

        vim.cmd("edit " .. vim.fn.fnameescape(filepath))
        vim.notify("Created and opened: " .. filepath, vim.log.levels.INFO)
      end)
    end)
  end,
}

vim.api.nvim_create_user_command("NewFile", function()
  local profile = vim.g.current_profile or "Code"
  local options = {}
  local map_choice = {}

  if profile == "Mathematics" then
    options = {
      "[Math] Python Math Script (.py)",
      "[Math] MATLAB Script (.m)",
      "[Writing] Standalone LaTeX Document (.tex)",
      "[Writing] Full LaTeX Project (Multi-file)",
      "[Writing] Academic Markdown Essay (.md)",
    }
    map_choice = {
      ["[Math] Python Math Script (.py)"] = "Python Math Script (.py)",
      ["[Math] MATLAB Script (.m)"] = "MATLAB Script (.m)",
      ["[Writing] Standalone LaTeX Document (.tex)"] = "Standalone LaTeX Document (.tex)",
      ["[Writing] Full LaTeX Project (Multi-file)"] = "Full LaTeX Project (Multi-file)",
      ["[Writing] Academic Markdown Essay (.md)"] = "Academic Markdown Essay (.md)",
    }
  elseif profile == "Writing" then
    options = {
      "[Writing] Standalone LaTeX Document (.tex)",
      "[Writing] Full LaTeX Project (Multi-file)",
      "[Writing] Academic Markdown Essay (.md)",
      "[Math] Python Math Script (.py)",
      "[Math] MATLAB Script (.m)",
    }
    map_choice = {
      ["[Writing] Standalone LaTeX Document (.tex)"] = "Standalone LaTeX Document (.tex)",
      ["[Writing] Full LaTeX Project (Multi-file)"] = "Full LaTeX Project (Multi-file)",
      ["[Writing] Academic Markdown Essay (.md)"] = "Academic Markdown Essay (.md)",
      ["[Math] Python Math Script (.py)"] = "Python Math Script (.py)",
      ["[Math] MATLAB Script (.m)"] = "MATLAB Script (.m)",
    }
  else
    options = {
      "[Math] Python Math Script (.py)",
      "[Math] MATLAB Script (.m)",
      "[Writing] Standalone LaTeX Document (.tex)",
      "[Writing] Full LaTeX Project (Multi-file)",
      "[Writing] Academic Markdown Essay (.md)",
    }
    map_choice = {
      ["[Math] Python Math Script (.py)"] = "Python Math Script (.py)",
      ["[Math] MATLAB Script (.m)"] = "MATLAB Script (.m)",
      ["[Writing] Standalone LaTeX Document (.tex)"] = "Standalone LaTeX Document (.tex)",
      ["[Writing] Full LaTeX Project (Multi-file)"] = "Full LaTeX Project (Multi-file)",
      ["[Writing] Academic Markdown Essay (.md)"] = "Academic Markdown Essay (.md)",
    }
  end

  vim.ui.select(options, {
    prompt = "Create New File from Template:",
  }, function(choice)
    if not choice then return end
    local template_key = map_choice[choice]
    if templates[template_key] then
      templates[template_key]()
    end
  end)
end, {})

-- Command to open the math guide
vim.api.nvim_create_user_command("MathGuide", function()
  local path = vim.fn.stdpath("config") .. "/math_guide.md"
  vim.cmd("edit " .. vim.fn.fnameescape(path))
end, {})

return M
