local ok, none_ls = pcall(require, 'none_ls')
if not ok then
  return
end

local formatting = none_ls.builtins.formatting
local diagnostics = none_ls.builtins.diagnostics

none_ls.setup({
  debug = false,
  sources = {
    formatting.nixfmt,
    formatting.stylua,
    formatting.black,
    formatting.clang_format,
    diagnostics.statix,
    diagnostics.luacheck.with({ extra_args = { '--globals', 'vim' } }),
    diagnostics.flake8,
    diagnostics.cppcheck
  }
})
