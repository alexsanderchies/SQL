select  ITEM.CD_GUIA,
        guia.cd_convenio
        ,NULL CD_FORNECEDOR,
        '' fornecedor,
        item.cd_pro_fat codigo, ds_pro_fat descricao,
        ds_unidade unidade, cd_rms rms, cd_opme_forn,
(select NR_REFERENCIA from produto where produto.cd_pro_fat = item.cd_pro_fat and rownum=1) ref_fabricante,
        (select cd_tuss from tuss where tuss.cd_pro_fat = item.cd_pro_fat and rownum=1) tuss,
        QT_AUTORIZADO qtd,
        CASE
          WHEN ACRESC_DESCONTOS.DS_DESCONTO = 'Desconto' THEN VL_UNITARIO-(VL_UNITARIO*(VL_PERC_DESCONTO/100))
          WHEN ACRESC_DESCONTOS.DS_ACRESCIMO = 'Acréscimo' THEN VL_UNITARIO+(VL_UNITARIO*(VL_PERC_ACRESCIMO/100))
          ELSE VL_UNITARIO
        END VL_UNIT_FINAL,
        VL_UNITARIO VL_UNITARIO_guia,
        item.ds_observacao,

(select cd_apresentacao||' - '||cd_medicamento||' - '||cd_laboratorio from IMP_BRA where IMP_BRA.cd_pro_fat = item.cd_pro_fat and rownum=1) bras
from dbamv.guia
    ,dbamv.IT_GUIA item
    ,dbamv.pro_fat
    ,dbamv.VAL_OPME_IT_GUIA val
    ,(SELECT DISTINCT CD_CONVENIO,CD_REGRA FROM DBAMV.EMPRESA_CON_PLA WHERE cd_regra IS NOT NULL) EMPRESA_CON_PLA -- TABELA DE REGRA VINCULADA AO PLANO DO CONVENIO
    ,DBAMV.REGRA             --REGRA DO CONVENIO
    ,DBAMV.ACRESC_DESCONTOS  --TABELA DE ACRESC E DESC DE CADA CONVENIO
  where  item.CD_GUIA = guia.CD_GUIA
  and val.cd_it_guia = item.cd_it_guia
  AND GUIA.CD_CONVENIO = EMPRESA_CON_PLA.CD_CONVENIO
  AND EMPRESA_CON_PLA.CD_REGRA = REGRA.CD_REGRA
  AND REGRA.CD_REGRA = ACRESC_DESCONTOS.CD_REGRA
  AND PRO_FAT.CD_GRU_PRO = ACRESC_DESCONTOS.CD_GRU_PRO (+)
  and item.cd_pro_fat= pro_fat.cd_pro_fat



--687,15
--   150,63

--  --SELECT CD_REGRA FROM GUIA

--SELECT (837.79*(17.98/100)) +  FROM dual

        ---SELECT * FROM acresc_descontos WHERE CD_REGRA = 5








