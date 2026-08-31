return {
  -- finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    "folke/todo-comments.nvim",
    cmd = {
      "TodoQuickFix",
      "TodoTelescope",
    },
    opts = {},
  },
  -- git annotations
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
}
