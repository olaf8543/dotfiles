if vim.g.vscode then
    require("vsoptions")
else
    require("options")
end

-- setup lazy plugin manager
require("config.lazy")
