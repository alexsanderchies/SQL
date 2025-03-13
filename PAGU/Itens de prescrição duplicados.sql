SELECT TIP_PRESC.CD_TIP_PRESC
      ,TIP_PRESC.CD_TIP_ESQ
      ,TIP_PRESC.DS_TIP_PRESC
      ,TIP_PRESC.CD_PRO_FAT
      ,TIP_PRESC.SN_ATIVO
  FROM DBAMV.TIP_PRESC
  WHERE Trim(TIP_PRESC.DS_TIP_PRESC) IN ( SELECT Trim(TIP_PRESC.DS_TIP_PRESC) DS_TIP_PRESC
                                            FROM DBAMV.TIP_PRESC
                                            --WHERE TIP_PRESC.CD_TIP_ESQ IN ('PEN','PME')
                                          GROUP BY Trim(TIP_PRESC.DS_TIP_PRESC)
                                          HAVING Count(*) > 1
                                        )
ORDER BY TIP_PRESC.DS_TIP_PRESC