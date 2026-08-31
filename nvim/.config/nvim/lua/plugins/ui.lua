return {
  -- collection of ui plugins
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- git plugins
      git = {
        enabled = true,
      },
      gitbrowse = {
        enabled = true,
      },
      -- errors, warnings, messages banners
      notifier = {
        enabled = true,
        timeout = 5000,
        style = "fancy",
        top_down = true,
      },
      -- fuzzy-finder for finding files, grepping, etc
      picker = {
        enabled = true,
      },
      explorer = {},
      -- the main neovim dashboard that opens when you run `nvim`
      dashboard = {
        enabled = true,
        preset = { pick = "snacks" },
        sections = {
          {
            section = "header",
          },
          {
            section = "keys",
            gap = 1,
            padding = 2,
          },
          {
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            indent = 2,
            padding = 2,
          },
          {
            icon = " ",
            title = "Projects",
            section = "projects",
            indent = 2,
            padding = 2,
          },
          {
            section = "startup",
          },
        },
      },
      -- styling of certain plugins
      styles = {
        notification = {
          border = "rounded",
          wo = {
            wrap = true,
          },
        },
      },
    },
    -- keymaps for certain snacks
    keys = {
      {
        "<leader>ff",
        function() Snacks.picker.files() end,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        function() Snacks.picker.grep() end,
        desc = "Grep Text",
      },
      {
        "<leader>fb",
        function() Snacks.picker.buffers() end,
        desc = "Open Buffers",
      },
      {
        "<leader>ft",
        function() Snacks.picker.lines({ bufnr = 0 }) end,
        desc = "Buffer lines (Current Panel)",
      },
      {
        "<leader>fr",
        function() Snacks.picker.recent() end,
        desc = "Recent Files",
      },
      {
        "<leader>nh",
        function() Snacks.picker.notifications() end,
        desc = "Snacks Notification History",
      },
      {
        "<leader>fc",
        function() 
          Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) 
        end,
        desc = "Find Config Files",
      },
      {
        "<leader>od",
        function() Snacks.dashboard.open() end,
        desc = "Open Dashboard"
      },
    },
  },
  -- places messages, cmdline and popupmenu in pretty sections
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- Override markdown rendering so that cmp and other plugins use Treesitter
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,         -- Keeps / and ? search bars at the bottom
          command_palette = true,       -- Centers the : command line nicely on your screen
          long_message_to_split = true, -- Redirects massive error logs to a split
          inc_rename = false,
          lsp_doc_border = false,
        },
     })
    end
  },
}
