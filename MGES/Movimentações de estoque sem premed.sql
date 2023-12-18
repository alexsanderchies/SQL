SELECT me.cd_mvto_estoque
      ,me.cd_estoque
      ,e.ds_estoque
      ,To_Char(dt_mvto_estoque, 'DD/MM/YYYY') ||' '|| To_Char(hr_mvto_estoque, 'HH24:MI') hr_mvto_estoque
      ,Decode(tp_mvto_estoque,'T', 'Transferencia entre estoques', 'P', 'Saida para paciente') tp_mvto_estoque
      ,ime.cd_itsolsai_pro
      ,ssp.cd_solsai_pro
      ,ssp.cd_pre_med
      ,me.cd_atendimento
      ,a.tp_atendimento
      ,p.nm_paciente
      ,ime.qt_movimentacao
      ,up.ds_unidade
      ,me.cd_usuario
      ,u.nm_usuario
FROM mvto_estoque me
    ,itmvto_estoque ime
    ,estoque e
    ,produto pr
    ,uni_pro up
    ,atendime a
    ,paciente p
    ,dbasgu.usuarios u
    ,itsolsai_pro issp
    ,solsai_pro ssp
WHERE me.cd_mvto_estoque = ime.cd_mvto_estoque
  AND ime.cd_produto = pr.cd_produto
  AND me.cd_estoque = e.cd_estoque
  AND ime.cd_uni_pro = up.cd_uni_pro
  AND me.cd_atendimento = a.cd_atendimento
  AND a.cd_paciente = p.cd_paciente
  AND me.cd_usuario = u.cd_usuario
  AND ime.cd_itsolsai_pro = issp.cd_itsolsai_pro
  AND issp.cd_solsai_pro = ssp.cd_solsai_pro
  AND pr.cd_produto = 4568
  AND me.dt_mvto_estoque BETWEEN '01/06/2020' AND '30/09/2021'
  AND ssp.cd_pre_med IS NULL
ORDER BY a.cd_atendimento