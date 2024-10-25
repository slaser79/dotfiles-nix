require("options")

require("picker")
require("completion")
require("lsp")

-- vim.api.nvim_buf_set_keymap('n', '<C-h', '<C-w>h', { expr = true, noremap = true })
-- vim.api.nvim_buf_set_keymap('n', '<C-j', '<C-w>j', { expr = true, noremap = true })
-- vim.api.nvim_buf_set_keymap('n', '<C-k', '<C-w>k', { expr = true, noremap = true })
-- vim.api.nvim_buf_set_keymap('n', '<C-l', '<C-w>l', { expr = true, noremap = true })

-- Delete word at cursor while in Insert mode
vim.api.nvim_set_keymap("i", "<C-d>", "<ESC>diwi", { silent = true, noremap = true })

-- gitsigns
require('gitsigns').setup{
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hr', gitsigns.reset_hunk)
    map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('n', '<leader>hS', gitsigns.stage_buffer)
    map('n', '<leader>hu', gitsigns.undo_stage_hunk)
    map('n', '<leader>hR', gitsigns.reset_buffer)
    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>hd', gitsigns.diffthis)
    map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
    map('n', '<leader>td', gitsigns.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

require("lightspeed").setup({})

--colorscheme setup
vim.cmd([[colorscheme tokyonight]])
require("statusline")

require("nvim-web-devicons").setup({})

require("nvim-treesitter.configs").setup({
  --ensure_installed = {"c", "lua", "vim", "vimdoc", "query"},
  --sync_install = false,
  highlight = { enable = true },
  indent = { enable = true, disable = { "python" } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  playground = { enable = true },
})

--Highlight yanked test
vim.cmd([[
    augroup highlight_yank
    autocmd!
    au TextYankPost * silent!  lua vim.highlight.on_yank({higroup="Visual",timeout=200})
    augroup END
]])

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
require("colorizer").setup({})

require("dressing").setup({})

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
      open = "<M-p>",
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4,
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
    yaml = true,
    markdown = true,
    help = false,
    gitcommit = true,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = "node", -- Node.js version must be > 16.x
  server_opts_overrides = {},
})
--chatgpt setup
require("chatgpt").setup({

  welcome_message = WELCOME_MESSAGE,
  loading_text = "loading",
  question_sign = "", -- you can use emoji if you want e.g. 🙂
  answer_sign = "ﮧ", -- 🤖
  max_line_length = 120,
  yank_register = "+",
  chat_layout = {
    relative = "editor",
    position = "50%",
    size = {
      height = "80%",
      width = "80%",
    },
  },
  settings_window = {
    border = {
      style = "rounded",
      text = {
        top = " Settings ",
      },
    },
  },
  chat_window = {
    filetype = "chatgpt",
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top = " ChatGPT ",
      },
    },
  },
  popup_input = {
    prompt = "  ",
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top_align = "center",
        top = " Prompt ",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
    submit = "<C-t>",
  },
  chat_input = {
    prompt = "  ",
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top_align = "center",
        top = " Prompt ",
      },
    },
  },
  openai_params = {
    model = "gpt-3.5-turbo",
    frequency_penalty = 0,
    presence_penalty = 0,
    max_tokens = 300,
    temperature = 0,
    top_p = 1,
    n = 1,
  },
  openai_edit_params = {
    model = "code-davinci-edit-001",
    temperature = 0,
    top_p = 1,
    n = 1,
  },
  keymaps = {
    close = { "<C-c>", "<C-e>" },
    submit = { "<C-Enter>", "C-t" },
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
  predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
  actions_paths = { "~/.config/nvim/custom_actions.json" },
})

vim.api.nvim_set_keymap("n", "<leader>ce", "<cmd>ChatGPTEditWithInstructions<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("v", "<leader>ce", "<cmd>ChatGPTEditWithInstructions<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>cg", "<cmd>ChatGPT<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("v", "<leader>cg", "<cmd>ChatGPTEditWithInstructions<cr>", { silent = true, noremap = true })

-- Which key setup
require("which-key").setup({})

-- wezterm setup
require("wezterm").setup({})

--harpoon setup
local harpoon = require("harpoon")
harpoon.setup({})

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<M-1>", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "<M-2>", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<M-3>", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "<M-4>", function()
  harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>p>", function()
  harpoon:list():prev()
end)
vim.keymap.set("n", "<leader>n>", function()
  harpoon:list():next()
end)

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
      .new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      })
      :find()
end

vim.keymap.set("n", "<C-e>", function()
  toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

--git worktree setup
require("telescope").load_extension("git_worktree")

vim.keymap.set(
  "n",
  "<leader>gwl",
  [[<Cmd>lua require('telescope').extensions.git_worktree.git_worktree()<CR>]],
  { noremap = true, silent = false }
)
vim.keymap.set(
  "n",
  "<leader>gwc",
  [[<Cmd>lua require('telescope').extensions.git_worktree.git_worktree()<CR>]],
  { noremap = true, silent = false }
)

--flutter tools setup
require("flutter-tools").setup {}
