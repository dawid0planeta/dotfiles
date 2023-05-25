---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "github_dark",
  theme_toggle = { "github_dark", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

vim.diagnostic.config({underline = false})
vim.opt.whichwrap = ""
vim.opt.winbar = "%f%m"

return M
