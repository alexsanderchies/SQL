SELECT usuarios.cd_usuario
      ,usuarios.nm_usuario
      ,usuarios.ds_observacao
      ,prestador.cd_tip_presta
      ,tip_presta.nm_tip_presta 
  FROM dbasgu.usuarios
  JOIN dbamv.prestador
    ON usuarios.cd_prestador = prestador.cd_prestador
  JOIN dbamv.tip_presta
    ON prestador.cd_tip_presta = tip_presta.cd_tip_presta
  WHERE prestador.cd_tip_presta NOT IN  (8,4,14,32,15,5,6,10,1,2,3,59,60,9,49,31)
    AND usuarios.sn_ativo = 'S'  