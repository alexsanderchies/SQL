SELECT coleta_sinal_vital.cd_atendimento
      ,coleta_sinal_vital.data_coleta
      ,sinal_vital.ds_sinal_vital
      ,itcoleta_sinal_vital.valor
      ,pw_unidade_afericao.ds_unidade_afericao
      ,SINAL_VITAL.CD_SINAL_VITAL
      ,CASE 
          WHEN PW_UNIDADE_AFERICAO.DS_UNIDADE_AFERICAO = 'CENTÍMETRO' THEN valor
          WHEN PW_UNIDADE_AFERICAO.DS_UNIDADE_AFERICAO = 'METRO'      THEN VALOR * 100
      END ALTURA_CM
  FROM dbamv.sinal_vital
  JOIN dbamv.itcoleta_sinal_vital 
    ON sinal_vital.cd_sinal_vital = itcoleta_sinal_vital.cd_sinal_vital
  JOIN dbamv.coleta_sinal_vital -- registro da coleta vinculado ao atendimento
    ON coleta_sinal_vital.cd_coleta_sinal_vital = itcoleta_sinal_vital.cd_coleta_sinal_vital
  JOIN dbamv.pw_unidade_afericao
    ON ITCOLETA_SINAL_VITAL.CD_UNIDADE_AFERICAO = PW_UNIDADE_AFERICAO.CD_UNIDADE_AFERICAO 
  WHERE SINAL_VITAL.CD_SINAL_VITAL = 10                  
    AND (COLETA_SINAL_VITAL.CD_COLETA_SINAL_VITAL, COLETA_SINAL_VITAL.CD_ATENDIMENTO) IN (SELECT Max(COLETA_SINAL_VITAL.CD_COLETA_SINAL_VITAL)
                                                                                                ,COLETA_SINAL_VITAL.CD_ATENDIMENTO
                                                                                            FROM DBAMV.COLETA_SINAL_VITAL
                                                                                            JOIN DBAMV.ITCOLETA_SINAL_VITAL
                                                                                              ON coleta_sinal_vital.cd_coleta_sinal_vital = itcoleta_sinal_vital.cd_coleta_sinal_vital
                                                                                            WHERE itcoleta_sinal_vital.CD_SINAL_VITAL = 10
                                                                                              AND COLETA_SINAL_VITAL.CD_ATENDIMENTO = 496
                                                                                            GROUP BY CD_ATENDIMENTO
                                                                                          )                                                                