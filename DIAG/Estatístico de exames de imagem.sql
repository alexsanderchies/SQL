SELECT Count (*)  QT
      ,TP_MOTIVO
      ,NM_SET_EXA
      ,DS_EXA_RX
      ,STATUS
  FROM (
        SELECT Decode(PED_RX.TP_MOTIVO,'R','Rotina','Urgencia')                                   TP_MOTIVO
              --,To_Char(PED_RX.DT_PEDIDO,'DD/MM/RRRR')||' '||To_Char(PED_RX.HR_PEDIDO,'HH24:MI')   HR_PEDIDO
              ,SET_EXA.NM_SET_EXA                                                                 NM_SET_EXA
              ,EXA_RX.DS_EXA_RX                                                                   DS_EXA_RX
              ,CASE
                    WHEN ITPED_RX.CD_LAUDO IS NULL AND ITPED_RX.SN_REALIZADO IS NULL                  THEN 'NAO REALIZADO'
                    WHEN ITPED_RX.CD_LAUDO IS NULL AND ITPED_RX.SN_REALIZADO = 'N'                    THEN 'NAO REALIZADO'
                    WHEN ITPED_RX.CD_LAUDO IS NULL AND iTPED_RX.SN_REALIZADO = 'S'                    THEN 'REALIZADO e AGUARDANDO RESULTADO'
                    WHEN ITPED_RX.CD_LAUDO IS NOT NULL AND LAUDO_RX.SN_EMITIDO = 'N'                  THEN 'COM RESULTADO'
                    WHEN ITPED_RX.CD_LAUDO IS NOT NULL AND LAUDO_RX.SN_EMITIDO = 'S' AND LAUDO_RX.SN_ENTREGUE = 'N' THEN 'IMPRESSO'
                    WHEN ITPED_RX.CD_LAUDO IS NOT NULL AND LAUDO_RX.SN_EMITIDO = 'S' AND LAUDO_RX.SN_ENTREGUE = 'S' THEN 'ENTREGUE'
                    ELSE 'SOLICITADO'
                  END STATUS
          FROM DBAMV.PED_RX
          JOIN DBAMV.ITPED_RX
            ON PED_RX.CD_PED_RX = ITPED_RX.CD_PED_RX
          JOIN DBAMV.SET_EXA
            ON PED_RX.CD_SET_EXA = SET_EXA.CD_SET_EXA
          JOIN DBAMV.EXA_RX
            ON ITPED_RX.CD_EXA_RX = EXA_RX.CD_EXA_RX
          LEFT JOIN DBAMV.LAUDO_RX
            ON ITPED_RX.CD_LAUDO = LAUDO_RX.CD_LAUDO
        )
GROUP BY TP_MOTIVO
        ,NM_SET_EXA
        ,DS_EXA_RX
        ,STATUS

 --SELECT * FROM LAUDO_RX   





