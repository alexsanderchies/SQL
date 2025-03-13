SELECT ep.cd_ent_pro
      ,ep.cd_estoque
      ,e.ds_estoque
      ,eep.nr_documento
      ,ep.nr_serie
      ,f.cd_fornecedor
      ,f.nm_fornecedor
      ,ep.dt_entrada
      ,iep.qt_entrada
      ,up.ds_unidade
      ,ep.cd_usuario
      ,u.nm_usuario
FROM ent_pro ep
    ,itent_pro iep
    ,estoque e
    ,dbasgu.usuarios u
    ,uni_pro up
    ,fornecedor f
WHERE ep.cd_ent_pro = iep.cd_ent_pro
  AND ep.cd_usuario = u.cd_usuario
  AND ep.cd_estoque = e.cd_estoque
  AND iep.cd_uni_pro = up.cd_uni_pro
  AND ep.cd_fornecedor = f.cd_fornecedor
  AND iep.cd_produto = 4568





--select * from uni_pro



--SELECT * FROM itent_pro where cd_produto = 4568










