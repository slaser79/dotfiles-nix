require('options')
require('filetype')

require('picker')
require('completion')
require('lsp')

-- vim.api.nvim_buf_set_keymap('n', '<C-h', '<C-w>h', { expr = true, noremap = true })
-- vim.api.nvim_buf_set_keymap('n', '<C-j', '<C-w>j', { expr = true, noremap = true })
-- vim.api.nvim_buf_set_keymap('n', '<C-k', '<C-w>k', { expr = true, noremap = true })
-- vim.api.nvim_buf_set_keymap('n', '<C-l', '<C-w>l', { expr = true, noremap = true })

-- Delete word at cursor while in Insert mode
vim.api.nvim_set_keymap('i', '<C-d>', "<ESC>diwi", { silent = true, noremap = true })

require('gitsigns').setup({})
require('lightspeed').setup({})

--colorscheme setup
vim.cmd[[colorscheme kanagawa]]
require('statusline')


require('nvim-web-devicons').setup({})

require('nvim-treesitter.configs').setup({
  --ensure_installed = {"c", "lua", "vim", "vimdoc", "query"},
  --sync_install = false,
  highlight = { enable = true },
  indent = { enable = true, disable = { "python" } },
  incremental_selection = { enable = true ,
    keymaps = {
      init_selection    = "gnn",
      node_incremental  = "grn",
      scope_incremental = "grc",
      node_decremental  = "grm",
    },
  },
  playground = { enable = true },
})

--Highlight yanked test
vim.cmd [[
    augroup highlight_yank
    autocmd! 
    au TextYankPost * silent!  lua vim.highlight.on_yank({higroup="Visual",timeout=200})
    augroup END
]]

-- indent blankline showing funning characters disabled for now
--[[require('indent_blankline').setup({
  show_trailing_blankline_indent = false,
  use_treesitter = true,
  show_current_context = true,
  -- show_current_context_start = true,
  show_first_indent_level = true,
  char = '🭰',
  filetype_exclude = { },
  buftype_exclude = { 'help', 'terminal', 'nofile' },
  context_patterns = {
    -- Common/C/C++
    'class', 'struct', 'function', 'method', '.*expression', '.*statement', 'for.*', '.*list',
    -- Nix
    'bind', '.*attrset', 'parenthesized',
    -- Lua
    'table', 'arguments'
  }
})]]
-- Fixes cursorline ghosting with indent-blankline on empty lines
--vim.opt.colorcolumn = "9999999";

--#region
require('colorizer').setup({})

require('dressing').setup({
    select = {
        get_config = function(opts)
            if opts.kind == 'codeaction' then
            return {
              backend = 'builtin',
              builtin  =  {
                relative = 'cursor',
                max_width = 40,
              }

            }
            end
        end
    }
})

--#Copilot setup
require("copilot").setup({
   panel = {
    enabled = true,
    auto_refresh = true,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-p>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 16.x
  server_opts_overrides = {},

})
--chatgpt setup
require("chatgpt").setup({
  keymaps = {
    close = { "<C-e>", "<Esc>" },
    submit = "<C-t>",
    yank_last = "<C-y>",
    yank_last_code = "<C-k>",
    scroll_up = "<C-u>",
    scroll_down = "<C-d>",
    toggle_settings = "<C-o>",
    new_session = "<C-n>",
    cycle_windows = "<Tab>",
    -- in the Sessions pane
    select_session = "<Space>",
    rename_session = "r",
    delete_session = "d",
  },
})


vim.api.nvim_set_keymap('n', '<leader>ce', "<cmd>ChatGPTEditWithInstructions<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('v', '<leader>ce', "<cmd>ChatGPTEditWithInstructions<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>cg', "<cmd>ChatGPT<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('v', '<leader>cg', "<cmd>ChatGPTEditWithInstructions<cr>", { silent = true, noremap = true })
