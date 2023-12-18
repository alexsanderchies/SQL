SELECT pm.cd_perfil_ambulatorial
      ,pa.ds_perfil_ambulatorial
      ,pm.cd_modulo
      ,pm.nm_titulo
FROM pw_perfil_modulo pm
    ,perfil_ambulatorial pa
WHERE pa.cd_perfil_ambulatorial = pm.cd_perfil_ambulatorial
  AND pa.cd_perfil_ambulatorial = 49
  --AND pm.cd_modulo = 'MVPEP_TEMA_DOC_ELETRONICO'
ORDER BY 2






SELECT pm.cd_perfil_modulo
      ,pm.cd_modulo
      ,pmp.cd_modulo
      ,pmp.nm_titulo MODULO_PAI
FROM pw_perfil_modulo pm
    ,pw_perfil_modulo pmp
WHERE pm.cd_perfil_modulo_pai = pmp.cd_perfil_modulo (+)
  AND pm.cd_perfil_ambulatorial = 49




SELECT * FROM perfil_ambulatorial
WHERE cd_multi_empresa = 1
  AND tp_perfil = 'SIS'
  AND cd_perfil_ambulatorial = 49
ORDER BY 2












