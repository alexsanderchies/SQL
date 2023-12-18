DELETE FROM PRES_CON WHERE CD_PRES_CON IN (
                                            SELECT CD_PRES_CON
                                              FROM (
                                                    SELECT DUPL.CD_PRESTADOR
                                                          ,DUPL.cd_convenio
                                                          ,DUPL.cd_multi_empresa
                                                      FROM (
                                                            SELECT cd_prestador
                                                                  ,cd_convenio
                                                                  ,cd_multi_empresa
                                                                  ,Count(*) qt
                                                              FROM dbamv.pres_con
                                                              WHERE CD_CONVENIO = 480
                                                                --AND CD_PRESTADOR = 10979
                                                            GROUP by cd_prestador
                                                                    ,cd_convenio
                                                                    ,cd_multi_empresa
                                                            ) DUPL
                                                      WHERE DUPL.QT > 1
                                                    )pres
                                              JOIN PRES_CON
                                                ON PRES_CON.CD_PRESTADOR = PRES.CD_PRESTADOR
                                              AND PRES_CON.CD_CONVENIO = PRES.CD_CONVENIO
                                              AND PRES_CON.CD_MULTI_EMPRESA = PRES.CD_MULTI_EMPRESA
                                              WHERE (PRES_CON.CD_PRESTADOR,PRES_CON.CD_CONVENIO,PRES_CON.CD_MULTI_EMPRESA,CD_PRES_CON) NOT IN (
                                                                                                                                                SELECT cd_prestador
                                                                                                                                                      ,cd_convenio
                                                                                                                                                      ,cd_multi_empresa
                                                                                                                                                      ,Max(CD_PRES_CON)
                                                                                                                                                  FROM dbamv.pres_con
                                                                                                                                                  WHERE CD_CONVENIO = 480
                                                                                                                                                  GROUP BY CD_PRESTADOR
                                                                                                                                                          ,CD_CONVENIO
                                                                                                                                                          ,CD_MULTI_EMPRESA
                                                                                                                                                )
                                            )
