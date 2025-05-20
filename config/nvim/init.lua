if vim.g.vscode then
    require("vsoptions")
else
    require("options")
    require("keymaps")
end

-- setup lazy plugin manager
require("config.lazy")
