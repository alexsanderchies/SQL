SELECT PRO_FAT.CD_PRO_FAT                         cd_pro_fat
      ,CON_PLA.CD_CON_PLA                         cd_con_pla
      ,CON_PLA.CD_CONVENIO                        cd_convenio
      ,NULL                                       ds_proibicao
      ,'FC'                                       tp_proibicao
      ,'T'                                        tp_atendimento
      ,Trunc(SYSDATE)                             dt_inicial_proibicao
      ,1                                          cd_multi_empresa
      ,NULL                                       cd_setor
      ,NULL                                       cd_regra_proibicao_valor
      ,NULL                                       dt_fim_proibicao
  FROM DBAMV.PRO_FAT
      ,DBAMV.CON_PLA
  WHERE CON_PLA.SN_ATIVO = 'S'
    AND CON_PLA.CD_CONVENIO <> 3
    AND PRO_FAT.CD_GRU_PRO = 28
    AND PRO_FAT.CD_PRO_FAT = '40304051'
ORDER BY 3,2,1


