return {

 picker = "telescope" ,
  on_attach = function (client,bufnr)
    require('sqls').on_attach(client,bufnr)
  end
}
