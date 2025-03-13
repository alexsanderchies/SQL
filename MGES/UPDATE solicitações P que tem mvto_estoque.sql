UPDATE solsai_pro
  SET tp_situacao = 'C'
  WHERE CD_SOLSAI_PRO IN (
                            SELECT cd_solsai_pro
                              FROM mvto_estoque
                              WHERE cd_solsai_pro IN (SELECT SOLSAI_PRO.CD_SOLSAI_PRO
                                                        FROM SOLSAI_PRO
                                                        LEFT JOIN ITSOLSAI_PRO
                                                          ON SOLSAI_PRO.CD_SOLSAI_PRO = ITSOLSAI_PRO.CD_SOLSAI_PRO
                                                        WHERE HR_SOLSAI_PRO < SYSDATE - 2
                                                          AND TP_SITUACAO = 'P'
                                                    )
                          )