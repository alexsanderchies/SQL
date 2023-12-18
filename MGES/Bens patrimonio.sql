SELECT b.cd_bem
      ,b.ds_bem
      ,b.ds_plaqueta 
      ,b.cd_localidade
      ,l.ds_localidade
      ,b.vl_compra
      ,b.dt_compra
      ,b.dt_tombamento
      ,b.cd_fornecedor
      ,i.cd_capitulo
      ,i.ds_capitulo
FROM bens b
    ,iob i
    ,localidade l
WHERE b.cd_capitulo = i.cd_capitulo
  AND b.cd_localidade = l.cd_localidade
  AND b.dt_baixa IS NULL 


