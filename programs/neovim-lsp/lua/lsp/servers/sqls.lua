return {

 picker = "telescope" ,
  on_attach = function (client,bufnr)
    require('sqls').on_attach(client,bufnr)
    vim.api.nvim_set_keymap('n','<F5>','<Plug>(sqls-execute-query)',{silent=true})
    vim.api.nvim_set_keymap('v','<F5>','<Plug>(sqls-execute-query)',{silent=true})
  end
}
