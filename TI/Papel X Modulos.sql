SELECT p.cd_papel
      ,p.ds_papel
      ,m.cd_sistema_dono
      ,m.cd_modulo
      ,m.nm_modulo 
FROM dbasgu.papel p
    ,dbasgu.papel_mod pm
    ,dbasgu.modulos m
WHERE p.cd_papel = pm.cd_papel
  AND pm.cd_modulo = m.cd_modulo
ORDER BY 1,3,4
