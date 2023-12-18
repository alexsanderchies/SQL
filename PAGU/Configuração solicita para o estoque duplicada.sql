SELECT cd_estoque
      ,cd_unid_int
      ,cd_setor
      ,cd_especie
      ,cd_classe
      ,cd_sub_cla
      ,cd_produto
      ,cd_estoque_sn
      ,cd_estoque_ei
      ,cd_estoque_subst
      ,cd_estoque_subst_sn
      ,cd_estoque_subst_ei
      ,Count(cd_config_estoque)
  FROM DBAMV.CONFIG_ESTOQUE
GROUP BY cd_estoque
      ,cd_unid_int
      ,cd_setor
      ,cd_especie
      ,cd_classe
      ,cd_sub_cla
      ,cd_produto
      ,cd_estoque_sn
      ,cd_estoque_ei
      ,cd_estoque_subst
      ,cd_estoque_subst_sn
      ,cd_estoque_subst_ei
HAVING Count(cd_config_estoque) >1










