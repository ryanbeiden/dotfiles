-- ============================================================================
-- Leader Keys
-- ============================================================================
vim.g.mapleader = " "      -- Set space as the leader key for custom mappings
vim.g.maplocalleader = " " -- Set space as the local leader key for buffer-local mappings

-- ============================================================================
-- Editor Behavior
-- ============================================================================
vim.opt.clipboard = "unnamedplus"                   -- Use system clipboard for all yank/paste operations
vim.opt.undofile = true                             -- Persist undo history to disk between sessions
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo" -- Directory to store undo files
vim.opt.confirm = true                              -- Prompt for confirmation instead of failing on unsaved changes
vim.opt.autoread = true                             -- Automatically reload files changed outside of Neovim
vim.opt.number = true                               -- Show line numbers always

-- ============================================================================
-- UI/Display
-- ============================================================================
vim.opt.termguicolors = true -- Enable 24-bit RGB colors in the terminal
vim.opt.numberwidth = 4      -- Minimum width of number column
vim.opt.signcolumn = "yes:1" -- Always show sign column with width of 1
vim.opt.wrap = false         -- Don't wrap long lines
vim.opt.breakindent = true   -- Wrapped lines preserve indentation
vim.opt.ruler = true         -- Show cursor position in command line
vim.opt.showtabline = 1      -- Never show the tab line
vim.opt.sidescroll = 1       -- Scroll 1 column at a time instead of jumping
vim.opt.sidescrolloff = 50   -- Keep 50 columns of context visible to the left/right
vim.o.winborder = "rounded"  -- Use rounded borders for floating windows

-- ============================================================================
-- Indentation
-- ============================================================================
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.shiftwidth = 2     -- Number of spaces for each indentation level
vim.opt.smartindent = true -- Auto-indent new lines based on syntax

-- ============================================================================
-- Other
-- ============================================================================
vim.opt.title = true -- Set window title to filename

