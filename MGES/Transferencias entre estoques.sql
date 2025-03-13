SELECT me.cd_estoque
      ,e.ds_estoque
      ,To_Char(dt_mvto_estoque, 'DD/MM/YYYY') ||' '|| To_Char(hr_mvto_estoque, 'HH24:MI') hr_mvto_estoque
      ,Decode(tp_mvto_estoque,'T', 'Transferencia entre estoques', 'P', 'Saida para paciente') tp_mvto_estoque
      ,ime.qt_movimentacao
      ,me.cd_estoque_destino
      ,ed.ds_estoque ds_estoque_destino
      ,me.cd_usuario
      ,u.nm_usuario
FROM mvto_estoque me
    ,itmvto_estoque ime
    ,estoque e
    ,estoque ed
    ,produto pr
    ,dbasgu.usuarios u

WHERE me.cd_mvto_estoque = ime.cd_mvto_estoque
  AND ime.cd_produto = pr.cd_produto
  AND me.cd_estoque = e.cd_estoque
  AND me.cd_estoque_destino = ed.cd_estoque (+)
  AND me.cd_usuario = u.cd_usuario
  AND me.tp_mvto_estoque = 'T'
  AND pr.cd_produto = 4568
  AND me.dt_mvto_estoque BETWEEN '01/06/2020' AND '30/09/2021'










