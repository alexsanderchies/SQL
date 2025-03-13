SELECT Count (*) QT
      ,INT_TEMPO
  FROM (
        SELECT CASE
                  WHEN INTERVALO.TEMPO < 6 THEN 'MENOS DE 6H'
                  WHEN INTERVALO.TEMPO >12 THEN 'MAIS QUE 12H'
                  ELSE  'DE 6H A 12H'
                END INT_TEMPO
          FROM (
                SELECT trunc(MOD(v_num_conv, 86400) / 3600) +
                                    (trunc(v_num_conv / 86400, 0) * 24) TEMPO 
                      , hr_atendimento
                      , dt_alta
                      , cd_atendimento
 
                FROM (

                      SELECT   (((v_ndate_fim - v_ndate_ini) * 86400) + 
                                  (v_nsecond_fim - v_nsecond_ini))          v_num_conv
                              , hr_atendimento
                              , dt_alta
                              , cd_atendimento
                        FROM (
                              SELECT  to_number(to_char(HR_ATENDIMENTO, 'SSSSS'))          v_nsecond_ini
                                    , to_number(to_char(DT_ALTA, 'SSSSS'))                 v_nsecond_fim
                                    , to_number(to_char(HR_ATENDIMENTO, 'J'))              v_ndate_ini
                                    , to_number(to_char(DT_ALTA, 'J'))                     v_ndate_fim
                                    , cd_atendimento
                                    , hr_atendimento
                                    , dt_alta
                                FROM (
                                      SELECT  To_Date(hr_atendimento,'DD/MM/YYYY HH24:MI') hr_atendimento
                                            , To_Date(dt_alta,'DD/MM/YYYY HH24:MI')        dt_alta
                                            , cd_atendimento                               cd_atendimento
                                      FROM (
                                            SELECT To_Char(ATENDIME.DT_ALTA,'DD/MM/YYYY')|| '' || To_Char(ATENDIME.HR_ALTA,'HH24:MI') DT_ALTA
                                                  ,To_Char(ATENDIME.DT_ATENDIMENTO,'DD/MM/YYYY')|| '' || To_Char(ATENDIME.HR_ATENDIMENTO,'HH24:MI') HR_ATENDIMENTO
                                                  ,ATENDIME.CD_ATENDIMENTO
                                                FROM ATENDIME
                                                WHERE ATENDIME.DT_ALTA IS NOT NULL 
												  AND ATENDIME.TP_ATENDIMENTO = 'U'
                                                  AND trunc (ATENDIME.DT_ATENDIMENTO) BETWEEN to_date('01/10/2022','dd/mm/rrrr') AND '28/12/2022'
                                            )
                                      )
                              )
                    )
                )INTERVALO
        )
GROUP BY INT_TEMPO

ORDER BY 1 
