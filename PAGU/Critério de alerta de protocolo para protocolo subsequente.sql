                         
SELECT 1 
  FROM PW_CASO_PROTOCOLO
  WHERE CD_ATENDIMENTO = <CD_ATENDIMENTO>    
    AND SYSDATE > DT_INICIO + 3 -- QUANTIDADE DE DIAS PARA DAR O START DO SEGUNDO 

    AND CD_ALERTA_PROTOCOLO = 21 -- CÓDIGO DO PROTOCOLO 1

    AND CD_ATENDIMENTO NOT IN (SELECT CD_ATENDIMENTO 
                               FROM PW_CASO_PROTOCOLO 
                               WHERE CD_ALERTA_PROTOCOLO= 61 -- CÓDIGO DO PROTOCOLO 2 
                                 AND DT_FIM IS NULL -- PARA NAO ALERTAR SE JA ESTIVER COM O PROTOCOLO 2 ATIVO 
                              )
    AND (CD_ATENDIMENTO,CD_ALERTA_PROTOCOLO,CD_CASO_PROTOCOLO) IN (SELECT CD_ATENDIMENTO
                                                                        ,CD_ALERTA_PROTOCOLO
                                                                        ,MAX(CD_CASO_PROTOCOLO)
                                                                    FROM PW_CASO_PROTOCOLO
                                                                    WHERE CD_ALERTA_PROTOCOLO = 21 -- CÓDIGO DO PROTOCOLO 1
                                                                      AND DT_FIM IS NULL -- PARA NAO ALERTAR SE JA ESTIVER COM O PROTOCOLO 1 FINALIZADO
                                                                    GROUP BY CD_ATENDIMENTO
                                                                            ,CD_ALERTA_PROTOCOLO
                                                                  )


