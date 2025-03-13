SELECT LISTAGG(DIAGNOSTICO.DS_DIAGNOSTICO, ', ')
         WITHIN GROUP (ORDER BY SAE_DIAGNOSTICO_REALIZADO.CD_ATENDIMENTO) DIAG_SAE
  FROM DBAMV.SAE_DIAGNOSTICO_PACIENTE
  JOIN DBAMV.SAE_DIAGNOSTICO_REALIZADO
    ON SAE_DIAGNOSTICO_PACIENTE.CD_DIAGNOSTICO_REALIZADO = SAE_DIAGNOSTICO_REALIZADO.CD_DIAGNOSTICO_REALIZADO
  JOIN DBAMV.DIAGNOSTICO
    ON SAE_DIAGNOSTICO_PACIENTE.CD_DIAGNOSTICO = DIAGNOSTICO.CD_DIAGNOSTICO
  WHERE SAE_DIAGNOSTICO_REALIZADO.CD_ATENDIMENTO = 3
    AND (SAE_DIAGNOSTICO_REALIZADO.CD_ATENDIMENTO,SAE_DIAGNOSTICO_REALIZADO.CD_DIAGNOSTICO_REALIZADO) IN (SELECT SAE_DIAGNOSTICO_REALIZADO.CD_ATENDIMENTO
                                                                                                                ,Max(SAE_DIAGNOSTICO_REALIZADO.cd_diagnostico_realizado)
                                                                                                            FROM DBAMV.SAE_DIAGNOSTICO_REALIZADO
                                                                                                            JOIN DBAMV.PW_DOCUMENTO_CLINICO
                                                                                                              ON SAE_DIAGNOSTICO_REALIZADO.CD_DOCUMENTO_CLINICO = PW_DOCUMENTO_CLINICO.CD_DOCUMENTO_CLINICO
                                                                                                            WHERE PW_DOCUMENTO_CLINICO.tp_status = 'FECHADO'
                                                                                                              AND SAE_DIAGNOSTICO_REALIZADO.CD_ATENDIMENTO = 3
                                                                                                          GROUP BY SAE_DIAGNOSTICO_REALIZADO.CD_ATENDIMENTO
                                                                                                          )
