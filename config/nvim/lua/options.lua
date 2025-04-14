vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Synchronizes the system clipboard with Neovim
vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 999

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.api.nvim_set_hl(0, "WinBar", { fg = "#ADD7FF", bg = "NONE" })

--ai generated code :( that made it so winbar would actually update between windows
local update_winbar = function()
  -- Only update if LSP is attached and symbols are supported
  local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
  for _, client in ipairs(clients) do
    if client.supports_method("textDocument/documentSymbol") then
      vim.wo.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
      return
    end
  end
  -- Clear winbar if no LSP symbols
  vim.wo.winbar = ""
end

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "CursorMoved", "LspAttach" }, {
  callback = update_winbar,
})
