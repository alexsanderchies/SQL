SELECT me.cd_mvto_estoque
      ,me.cd_estoque
      ,e.ds_estoque
      ,To_Char(dt_mvto_estoque, 'DD/MM/YYYY') ||' '|| To_Char(hr_mvto_estoque, 'HH24:MI') hr_mvto_estoque
      ,Decode(tp_mvto_estoque,'T', 'Transferencia entre estoques', 'P', 'Saida para paciente') tp_mvto_estoque
      ,ime.cd_itsolsai_pro
      ,ssp.cd_solsai_pro
      ,ssp.cd_pre_med
      ,pm.dh_criacao
      ,ipm.cd_itpre_med
      ,ipm.qt_itpre_med
      ,up.ds_unidade
      ,tf.ds_tip_fre
      ,fa.ds_for_apl
      ,pm.cd_prestador
      ,pre.nm_prestador
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
    ,pre_med pm
    ,itpre_med ipm
    ,prestador pre
    ,tip_fre tf
    ,for_apl fa
WHERE me.cd_mvto_estoque = ime.cd_mvto_estoque
  AND ime.cd_produto = pr.cd_produto
  AND me.cd_estoque = e.cd_estoque
  AND ime.cd_uni_pro = up.cd_uni_pro
  AND me.cd_atendimento = a.cd_atendimento
  AND a.cd_paciente = p.cd_paciente
  AND me.cd_usuario = u.cd_usuario
  AND ime.cd_itsolsai_pro = issp.cd_itsolsai_pro
  AND issp.cd_solsai_pro = ssp.cd_solsai_pro
  AND ssp.cd_pre_med = pm.cd_pre_med
  AND pm.cd_pre_med = ipm.cd_pre_med
  AND pm.cd_prestador = pre.cd_prestador
  AND ipm.cd_tip_fre = tf.cd_tip_fre
  AND ipm.cd_for_apl = fa.cd_for_apl
  AND pr.cd_produto = 4568
  AND ipm.cd_tip_presc = 34816
  AND me.dt_mvto_estoque BETWEEN '01/06/2020' AND '30/09/2021'
  AND ssp.cd_pre_med IS NOT NULL
  AND pm.fl_impresso = 'S'
ORDER BY a.cd_atendimento, pm.cd_pre_med





--SELECT * FROM pre_med WHERE cd_pre_med  =808375



--SELECT * FROM prestador WHERE cd_prestador = 1019




--SELECT * FROM tip_presc WHERE cd_produto = 4568


--SELECT * FROM itpre_med WHERE cd_pre_med = 805344 and  cd_tip_presc = 34816

-- select * from tip_fre



-- select * from for_apl





