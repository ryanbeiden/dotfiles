return {
  -- handles langauge parsing for highlighting and indentation
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = {
          "vim",
          "vimdoc",
          "lua",
          "php",
          "blade",
          "javascript",
          "typescript",
          "tsx",
          "html",
          "css",
          "regex",
        },
        highlight = {
          enable = true
        },
        indent = {
          enable = true
        },
      })
    end,
  }
}
