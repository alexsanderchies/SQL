SELECT Count (*) Qt_Lancamentos
      ,'INT' tp_conta  
  FROM ITREG_FAT
  WHERE TP_MVTO = 'Faturamento'
    AND DT_LANCAMENTO > '31/12/2021'
UNION ALL 
SELECT Count(*) Qt_Lancamentos
      ,'AMB' tp_conta
  FROM ITREG_AMB
  WHERE TP_MVTO = 'Faturamento'
    AND HR_LANCAMENTO > '31/12/2021'
