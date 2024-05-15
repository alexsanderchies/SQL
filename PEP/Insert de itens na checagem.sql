INSERT INTO DBAMV.HRITPRE_CONS
SELECT hritpre_med.cd_itpre_med
      ,hritpre_med.dh_medicacao
      ,SYSDATE
      ,'ENF283210' 
      ,'N'
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,1
      ,NULL
      ,NULL
      ,'MVPEP'
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL
  FROM dbamv.hritpre_med
  JOIN DBAMV.ITPRE_MED 
    ON hritpre_med.CD_ITPRE_MED = ITPRE_MED.CD_ITPRE_MED
  JOIN DBAMV.PRE_MED
    ON ITPRE_MED.CD_PRE_MED = PRE_MED.CD_PRE_MED
  --JOIN DBAMV.HRITPRE_CONS
    --ON hritpre_med.cd_itpre_med = HRITPRE_CONS.cd_itpre_med
  WHERE PRE_MED.fl_impresso = 'S'      
    AND PRE_MED.cd_atendimento in (SELECT cd_atendimento FROM dbamv.atendime WHERE tp_atendimento = 'I')
    --AND (ITPRE_MED.sn_cancelado = 'N' or ITPRE_MED.sn_cancelado is NULL)  
    AND (ITPRE_MED.CD_ITPRE_MED,hritpre_med.DH_MEDICACAO) NOT IN (SELECT CD_ITPRE_MED, DH_MEDICACAO FROM HRITPRE_CONS)
    AND hritpre_med.DH_MEDICACAO <= To_Date('14/05/2024 23:59','DD/MM/YYYY HH24:MI')
ORDER BY 2