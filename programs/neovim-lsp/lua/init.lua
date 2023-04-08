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
  highlight = { enable = true },
  indent = { enable = true, disable = { "python" } },
  incremental_selection = { enable = true },
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

