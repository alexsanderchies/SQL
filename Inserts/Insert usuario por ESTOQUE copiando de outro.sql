--INSERT INTO DBAMV.USU_ESTOQUE
SELECT b.cd_estoque
      ,a.CD_USUARIO
      ,b.sn_autoriza_excl_solicitacao
      ,b.sn_autoriza_alte_solicitacao
      ,b.tp_usuario
      ,b.sn_permite_alt_ord_compras
      ,b.sn_alt_vl_unit_oc
      ,b.vl_perc_var_vl_unit
      ,b.sn_trans_quant_cota
      ,b.sn_autoriza_alte_movimentacao
      ,b.sn_autoriza_excl_movimentacao
      ,b.sn_altera_unidade
      ,b.tp_unid_transf
      ,b.sn_pode_abrir_conferencia_entr
      ,b.sn_pode_conferir_confe_entr
      ,b.sn_pode_validar_confe_entr
      ,b.sn_pode_cancelar_confe_entr
      ,b.sn_pode_gerar_entrad_cnfr_entr
      ,b.sn_altera_localizacao_produto
      ,b.sn_informa_data_faturamento
      ,b.sn_autoriza_desc_comercial
      ,b.sn_exige_autenticacao_atnd_sol
      ,b.sn_libera_mov_produto_contagem
      ,b.sn_pode_mov_produto_contagem
      ,b.sn_avaliacao_farmaceutica
      ,b.sn_altera_ent_pro_concluida
  FROM (SELECT CD_USUARIO
          FROM DBASGU.USUARIOS
          WHERE USUARIOS.CD_USUARIO IN ('HC7002','HC4742','HC3844')--USUARIOS PARA INSERIR
        )A
        ,(SELECT *
            FROM DBAMV.USU_ESTOQUE
            WHERE CD_ID_DO_USUARIO = 'HC5130' --USUARIO MODELO
        )B
WHERE (B.CD_ESTOQUE,A.CD_USUARIO) NOT IN (SELECT CD_ESTOQUE,CD_ID_DO_USUARIO FROM USU_ESTOQUE) -- nao insere estoque que ja tem











