SELECT PRO_FAT.CD_GRU_PRO
      ,PRO_FAT.CD_PRO_FAT
      ,ITREGRA.CD_TAB_FAT
      ,RETORNA_VALOR_PROCEDIMENTO(itregra.cd_tab_fat,pro_fat.cd_pro_fat)
  FROM DBAMV.CONVENIO
  JOIN DBAMV.CON_PLA
    ON CONVENIO.CD_CONVENIO = CON_PLA.CD_CONVENIO
  JOIN DBAMV.REGRA
    ON CON_PLA.CD_REGRA = REGRA.CD_REGRA
  JOIN DBAMV.ITREGRA
    ON ITREGRA.CD_REGRA = REGRA.CD_REGRA
  JOIN DBAMV.PRO_FAT
    ON PRO_FAT.CD_GRU_PRO = ITREGRA.CD_GRU_PRO
  WHERE CONVENIO.CD_CONVENIO = 3
    AND CON_PLA.CD_CON_PLA = 1
    AND PRO_FAT.CD_PRO_FAT IN ('40804046','40804054')

-- função criada pra retornar o valor do procedimento
PROMPT CREATE OR REPLACE FUNCTION retorna_valor_procedimento
CREATE OR REPLACE FUNCTION retorna_valor_procedimento
  (p_tab_fat IN val_pro.cd_tab_fat%TYPE
  ,p_pro_fat IN val_pro.cd_pro_fat%TYPE
  )
RETURN NUMBER
IS
v_total_pro_fat val_pro.vl_total%TYPE :=0;
BEGIN
  SELECT VAL_PRO.VL_TOTAL
         INTO v_total_pro_fat
  FROM DBAMV.VAL_PRO
  WHERE (VAL_PRO.CD_PRO_FAT, VAL_PRO.DT_VIGENCIA) IN (SELECT VAL_PRO.CD_PRO_FAT
                                                            ,MAX(VAL_PRO.DT_VIGENCIA)
                                                      FROM DBAMV.VAL_PRO
                                                      WHERE VAL_PRO.CD_TAB_FAT = p_tab_fat
                                                      GROUP  BY VAL_PRO.CD_PRO_FAT)
    AND VAL_PRO.CD_TAB_FAT = P_TAB_FAT
    AND VAL_PRO.CD_PRO_FAT = P_PRO_FAT;
RETURN v_total_pro_fat;
END RETORNA_VALOR_PROCEDIMENTO;
/

