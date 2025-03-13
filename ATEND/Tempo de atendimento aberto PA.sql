SELECT
       nm_cor,
       nvl(ds_tipo_risco, 'AGUARDANDO CLASSIFICAÇÃO - FILA: ' || fila_senha.ds_fila) as ds_tipo_risco,
       atendime.cd_atendimento,
       To_Char(dbamv.Fnc_mv_recupera_data_hora(atendime.dt_atendimento, atendime.hr_atendimento), 'dd/mm/yyyy hh24:mi') AS dh_atendimento,
       paciente.nm_paciente,
       cidade.nm_cidade || ' - ' || cidade.cd_uf AS nm_cidade,
       dbamv.Fn_idade(paciente.dt_nascimento, 'a A m M d D', sysdate) AS idade,
       CASE paciente.tp_sexo WHEN 'F' THEN 'FEMININO' WHEN 'M' THEN 'MASCULINO' ELSE paciente.tp_sexo END AS tp_sexo,
       
       case TRUNC(24*MOD(SYSDATE - FNC_MV_RECUPERA_DATA_HORA(DT_ATENDIMENTO, HR_ATENDIMENTO),1)) 
        when 0 then TRUNC( MOD(MOD(SYSDATE - FNC_MV_RECUPERA_DATA_HORA(DT_ATENDIMENTO, HR_ATENDIMENTO),1)*24,1)*60 ) || ' minutos'
        when 1 then '1 hora e ' || TRUNC( MOD(MOD(SYSDATE - FNC_MV_RECUPERA_DATA_HORA(DT_ATENDIMENTO, HR_ATENDIMENTO),1)*24,1)*60 ) || ' minutos'
        else TRUNC(24*MOD(SYSDATE - FNC_MV_RECUPERA_DATA_HORA(DT_ATENDIMENTO, HR_ATENDIMENTO),1)) || ' horas e ' || TRUNC( MOD(MOD(SYSDATE - FNC_MV_RECUPERA_DATA_HORA(DT_ATENDIMENTO, HR_ATENDIMENTO),1)*24,1)*60 ) || ' minutos' 
        end AS DH_TIME
FROM   dbamv.atendime atendime
       JOIN dbamv.paciente paciente
         ON atendime.cd_paciente = paciente.cd_paciente
       LEFT JOIN dbamv.triagem_atendimento
              ON atendime.cd_atendimento = triagem_atendimento.cd_atendimento
       LEFT JOIN dbamv.sacr_classificacao
              ON triagem_atendimento.cd_classificacao = sacr_classificacao.cd_classificacao
       LEFT JOIN dbamv.sacr_cor_referencia
              ON triagem_atendimento.cd_cor_referencia = sacr_cor_referencia.cd_cor_referencia
       LEFT JOIN dbamv.prestador
              ON atendime.cd_prestador = prestador.cd_prestador
       LEFT JOIN dbamv.cid
              ON atendime.cd_cid = cid.cd_cid
       LEFT JOIN dbamv.especialid
              ON atendime.cd_especialid = especialid.cd_especialid
       LEFT JOIN dbamv.pre_med
              ON atendime.cd_atendimento = pre_med.cd_atendimento
       LEFT JOIN dbamv.cidade
              ON paciente.cd_cidade = cidade.cd_cidade
       LEFT JOIN dbamv.fila_senha
              ON triagem_atendimento.cd_fila_senha = fila_senha.cd_fila_senha
WHERE  atendime.tp_atendimento IN ( 'U' )
       AND atendime.dt_atendimento = Trunc(sysdate)

       AND atendime.dt_alta IS NULL
       AND cd_pre_med IS NULL
ORDER BY fnc_mv_recupera_data_hora(dt_atendimento, hr_atendimento) asc
