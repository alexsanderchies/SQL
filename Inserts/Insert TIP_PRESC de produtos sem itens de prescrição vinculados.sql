SELECT 'INSERT INTO DBAMV.TIP_PRESC VALUES (SEQ_TIP_PRESC.NEXTVAL'
      ,'"'||SUB_CLAS.CD_TIP_ESQ||'"'                                            cd_tip_esq
      ,'"'||Upper(Trim(PRODUTO.DS_PRODUTO))||'"'                                      ds_tip_presc
      ,'NULL'                                                                     cd_exa_lab
      ,'NULL'                                                                     cd_exa_rx
      ,PRODUTO.CD_PRODUTO                                                       cd_produto
      ,'NULL'                                                                     cd_uni_pro
      ,'"S"'                                                                     sn_solicitacao
      ,'NULL'                                                                     cd_for_apl
      ,'NULL'                                                                     cd_estoque
      ,'NULL'                                                                     cd_unidade
      ,'NULL'                                                                     cd_pro_fat
      ,'"N"'                                                                     sn_fatura
      ,'"S"'                                                                     sn_ativo
      ,'NULL'                                                                     cd_tip_fre
      ,'NULL'                                                                     cd_tipo_dieta
      ,'"S"'                                                                     sn_padronizado
      ,'"M"'                                                                     tp_pre_med
      ,'NULL'                                                                     cd_uni_pro_cons
      ,'NULL'                                                                     nr_dias_aberto
      ,'NULL'                                                                     nr_horas_aberto
      ,'NULL'                                                                     cd_sangue_derivados
      ,'"N"'                                                                     sn_liga_desligar
      ,'NULL'                                                                     ds_observacao
      ,'NULL'                                                                     nr_ordem_impressao
      ,'NULL'                                                                     qt_maxima_aplicacao
      ,1                                                                        qt_padrao
      ,'NULL'                                                                     cd_prestador
      ,'"N"'                                                                     sn_entubado
      ,'"S"'                                                                     sn_uso_simultaneo
      ,'"N"'                                                                     tp_tip_presc
      ,'NULL'                                                                     tp_modo_verifica
      ,'"N"'                                                                     sn_uso_continuo
      ,'NULL'                                                                     tp_balanco
      ,'"S"'                                                                     sn_imprime_horario
      ,'"N"'                                                                     sn_justificativa
      ,'"N"'                                                                     sn_dia_aplicacao
      ,'"S"'                                                                     sn_alerta_duplicidade
      ,'NULL'                                                                     ds_justificativa
      ,'NULL'                                                                     cd_uni_pro_inf
      ,'"H"'                                                                     tp_tempo
      ,'NULL'                                                                     cd_sus
      ,'NULL'                                                                     cd_ssm
      ,'"N"'                                                                     sn_copia_justificativa
      ,'NULL'                                                                     qt_tempo_assistencia
      ,'NULL'                                                                     hr_exame
      ,'NULL'                                                                     cd_item_agendamento
      ,'NULL'                                                                     ds_obs_adicional
      ,'NULL'                                                                     cd_uni_presc_inf
      ,'NULL'                                                                     hr_duracao
      ,'NULL'                                                                     ds_bloqueio_prescricao
      ,'NULL'                                                                     cd_uni_presc
      ,'NULL'                                                                     cd_uni_fat
      ,'NULL'                                                                     cd_procedimento_sia
      ,'NULL'                                                                     cd_procedimento_sih
      ,'"N"'                                                                     sn_solic_comp_mesmo_estoque
      ,'"N"'                                                                     sn_bloqueio_prescricao
      ,'NULL'                                                                     cd_uni_presc_maxima
      ,'NULL'                                                                     cd_uni_pro_maxima
      ,'"N"'                                                                     sn_justificativa_cadastrada
      ,'"N"'                                                                     sn_fracionar
      ,'"N"'                                                                     sn_lanca_conta_checagem
      ,'"N"'                                                                     sn_obriga_material
      ,'NULL'                                                                     cd_material
      ,'NULL'                                                                     nr_dias_padrao
      ,'NULL'                                                                     qt_dose_padrao
      ,'NULL'                                                                     cd_padrao_formula
      ,'"N"'                                                                     sn_dupla_checagem_dado
      ,'"N"'                                                                     sn_dupla_checagem_nao_dado
      ,'"TUDO"'                                                                  tp_permissao_inclusao_compon
      ,'"N"'                                                                     sn_exige_diluente
      ,'"N"'                                                                     sn_diluente
      ,'"N"'                                                                     sn_reconstituinte
      ,'NULL'                                                                     cd_observacao_predefinida
      ,'"S"'                                                                     sn_qtd_editavel
      ,'NULL'                                                                     cd_dispositivo
      ,'NULL'                                                                     cd_local_anatomico_coleta
      ,'"PERIODO"'                                                                tp_valida_checagem_duplicidade
      ,0                                                                        nr_dias_checagem_duplicidade
      ,0                                                                        nr_horas_checagem_duplicidade
      ,'NULL'                                                                     qt_infusao
      ,'NULL'                                                                     sn_trazer_componente_recolhido
      ,'NULL'                                                                     cd_config_exibicao_item_presc
      ,'NULL'                                                                     cd_nome_exibicao_componentes
      ,'"S"'                                                                     sn_soma_total_balanco
      ,'"N"'                                                                     sn_hab_lanc_unidade
      ,'NULL'                                                                     qtd_volume_total
      ,'NULL'                                                                     cd_unid_vol_total
      ,'NULL'                                                                     tp_isolamento_paciente
      ,'"N"'                                                                     sn_cronico
      ,'NULL'                                                                     nr_dias_duracao
      ,'NULL'                                                                     nr_horas_duracao
      ,'NULL'                                                                     nr_minutos_duracao
      ,'NULL'                                                                     cd_multi_empresa
      ,'"N"'                                                                     sn_item_avulso
      ,'NULL'                                                                     cd_cirurgia
      ,'"TODOS"'                                                                 tp_visualizacao
      ,'"N"'                                                                     sn_pesquisa_cientifica
      ,'NULL' ||');'
  FROM PRODUTO
  JOIN SUB_CLAS
    ON PRODUTO.CD_ESPECIE = SUB_CLAS.CD_ESPECIE
   AND PRODUTO.CD_CLASSE = SUB_CLAS.CD_CLASSE
   AND PRODUTO.CD_SUB_CLA = SUB_CLAS.CD_SUB_CLA
  WHERE SUB_CLAS.CD_TIP_ESQ IS NOT NULL
    AND PRODUTO.CD_PRODUTO NOT IN (SELECT CD_PRODUTO FROM TIP_PRESC WHERE CD_PRODUTO IS NOT NULL) --Produtos sem itens de prescrição vinculados
    AND PRODUTO.DS_PRODUTO NOT IN (SELECT DS_TIP_PRESC FROM TIP_PRESC) --Itens de prescrição que nao tem a mesma descrição do produto
    --AND PRODUTO.CD_PRODUTO = 50
    AND PRODUTO.SN_PADRONIZADO = 'S'
    AND PRODUTO.SN_MOVIMENTACAO = 'S'
    AND PRODUTO.CD_ESPECIE NOT IN (7) --OPME
    AND PRODUTO.CD_PRODUTO NOT IN (5750)
ORDER BY PRODUTO.CD_PRODUTO



--SELECT * FROM ESPECIE








