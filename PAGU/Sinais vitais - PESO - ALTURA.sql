SELECT coleta_sinal_vital.cd_atendimento
      ,coleta_sinal_vital.data_coleta
      ,sinal_vital.ds_sinal_vital
      ,itcoleta_sinal_vital.valor
      ,pw_unidade_afericao.ds_unidade_afericao
      ,SINAL_VITAL.CD_SINAL_VITAL

  FROM dbamv.sinal_vital
  JOIN dbamv.itcoleta_sinal_vital 
    ON sinal_vital.cd_sinal_vital = itcoleta_sinal_vital.cd_sinal_vital
  JOIN dbamv.coleta_sinal_vital -- registro da coleta vinculado ao atendimento
    ON coleta_sinal_vital.cd_coleta_sinal_vital = itcoleta_sinal_vital.cd_coleta_sinal_vital
  left JOIN dbamv.pw_unidade_afericao
    ON ITCOLETA_SINAL_VITAL.CD_UNIDADE_AFERICAO = PW_UNIDADE_AFERICAO.CD_UNIDADE_AFERICAO 
  WHERE SINAL_VITAL.CD_SINAL_VITAL = 1                  
    AND (COLETA_SINAL_VITAL.CD_COLETA_SINAL_VITAL, COLETA_SINAL_VITAL.CD_ATENDIMENTO) IN (SELECT Max(COLETA_SINAL_VITAL.CD_COLETA_SINAL_VITAL)
                                                                                                ,COLETA_SINAL_VITAL.CD_ATENDIMENTO
                                                                                            FROM DBAMV.COLETA_SINAL_VITAL
                                                                                            JOIN dbamv.pw_documento_clinico
                                                                                              ON pw_documento_clinico.cd_documento_clinico = COLETA_SINAL_VITAL.cd_documento_clinico
                                                                                            JOIN DBAMV.ITCOLETA_SINAL_VITAL
                                                                                              ON coleta_sinal_vital.cd_coleta_sinal_vital = itcoleta_sinal_vital.cd_coleta_sinal_vital
                                                                                            WHERE itcoleta_sinal_vital.CD_SINAL_VITAL = 1
                                                                                              AND COLETA_SINAL_VITAL.CD_ATENDIMENTO = 68376
                                                                                              AND itcoleta_sinal_vital.VALOR IS NOT NULL
                                                                                              AND pw_documento_clinico.tp_status  = 'FECHADO'
                                                                                              AND Trunc(coleta_sinal_vital.data_coleta) = Trunc(SYSDATE - 1)
                                                                                            GROUP BY coleta_sinal_vital.CD_ATENDIMENTO
                                                                                          )                     