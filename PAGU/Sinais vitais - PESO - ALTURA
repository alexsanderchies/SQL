SELECT coleta_sinal_vital.cd_atendimento
      ,coleta_sinal_vital.data_coleta
      ,sinal_vital.ds_sinal_vital
      ,itcoleta_sinal_vital.valor
      ,pw_unidade_afericao.ds_unidade_afericao 
  FROM dbamv.sinal_vital
  JOIN dbamv.itcoleta_sinal_vital 
    ON sinal_vital.cd_sinal_vital = itcoleta_sinal_vital.cd_sinal_vital
  JOIN dbamv.coleta_sinal_vital -- registro da coleta vinculado ao atendimento
    ON coleta_sinal_vital.cd_coleta_sinal_vital = itcoleta_sinal_vital.cd_coleta_sinal_vital
  JOIN dbamv.pw_unidade_afericao
    ON itcoleta_sinal_vital.cd_unidade_afericao = pw_unidade_afericao.cd_unidade_afericao 
  WHERE sinal_vital.ds_sinal_vital like '%PESO%'
