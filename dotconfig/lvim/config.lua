-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- lvim.colorscheme = "onedarker"


lvim.colorscheme = "oxocarbon"


lvim.plugins = {
  { "tomasiser/vim-code-dark" },
  { "kyazdani42/blue-moon" },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "jacoborus/tender.vim" }
}

lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  t = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
  h = { "<cmd>2ToggleTerm size=30 direction=horizontal<cr>", "Split horizontal" },
}

vim.opt.timeoutlen = 250 -- for leader


local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  -- { name = "clang-format", filetypes = { "c" } },
  -- { name = "cmakelang" },
  { name = "csharpier" },
  { name = "asmfmt" }
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "flake8", filetypes = { "python" } },
  -- { name = "checkmate" },
  -- { name = "cmakelang" },
}

lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.lua", "*.py", "*.c", "*.asm", "*.cs" }
