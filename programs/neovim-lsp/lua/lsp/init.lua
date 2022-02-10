require('lsp.null_ls')

local map_opts = { noremap = true, silent = true }
local icons = require('lsp.icons')
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
local completion_capabilities = require('cmp_nvim_lsp').update_capabilities(lsp_capabilities)
vim.api.nvim_set_keymap('n','<leader>da','<cmd>lua vim.diagnostic.open_float()<CR>',map_opts)
vim.api.nvim_set_keymap('n',']g','<cmd>lua vim.diagnostic.goto_next()<CR>',map_opts)
vim.api.nvim_set_keymap('n','[g','<cmd>lua vim.diagnostic.goto_prev()<CR>',map_opts)
vim.api.nvim_set_keymap('n','<leader>q','<cmd>lua vim.diagnostic.setloclist()<CR>',map_opts)

-- Set up LSP configurations
local shared_config = {
  capabilities = completion_capabilities,
  on_attach = (function(_, buffer_num)
    local function map(...) vim.api.nvim_buf_set_keymap(buffer_num, ...) end
    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', map_opts)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', map_opts)
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', map_opts)
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', map_opts)
    map('n', '<leader>kk>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', map_opts) -- clashes with line move up and down
    map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', map_opts)
    map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', map_opts)
    map('n', '<leader>aa', '<cmd>lua vim.lsp.buf.code_action()<CR>', map_opts)
    map('n', '<leader>R', '<cmd>lua vim.lsp.buf.references()<CR>', map_opts)
    map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', map_opts)


    for i, kind in ipairs(vim.lsp.protocol.CompletionItemKind) do
      vim.lsp.protocol.CompletionItemKind[i] = icons[kind] or kind
    end
  end),
  flags = {
    debounce_text_changes = 250,
  },
}

local lspconfig = require('lspconfig')
local servers = { 'sumneko_lua', 'rnix', 'ccls', 'texlab', 'bashls', 'pyright', 'sqls' }

-- Apply server-specific config from lsp dir
for _, server in ipairs(servers) do
  local ok, module = pcall(require, 'lsp.servers.' .. server)
  if not ok then
    module = {}
  end
  local updated_module = {}
  if module.on_attach then
    updated_module.on_attach = function (client,bufnr)
      shared_config.on_attach(client,bufnr)
      module.on_attach(client,bufnr)
    end
  else
      updated_module = module
  end
  lspconfig[server].setup(vim.tbl_deep_extend('force', shared_config, updated_module))
end

-- Show LSP diagnostics in virtual lines
require('lsp_lines').register_lsp_virtual_lines()
vim.diagnostic.config({
  virtual_lines = false,
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true
})

-- Highlight line number instead of having icons in sign columns
vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarning", { text = "", numhl = "DiagnosticSignWarning" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "", numhl = "DiagnosticSignInformation" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", numhl = "DiagnosticSignHint" })

