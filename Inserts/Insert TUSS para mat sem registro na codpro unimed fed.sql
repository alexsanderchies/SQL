INSERT INTO TUSS 
SELECT 0                                                                        CD_TIP_TUSS  
      ,PRO_FAT.CD_PRO_FAT                                                       CD_TUSS
      ,PRO_FAT.DS_PRO_FAT                                                       DS_TUSS
      ,'03/01/2022'                                                             DT_INICIO_VIGENCIA
      ,NULL                                                                     DT_FIM_VIGENCIA
      ,NULL                                                                     DT_FIM_IMPLANTACAO
      ,NULL                                                                     DS_EDICAO_NORMA_OBSERVACOES
      ,NULL                                                                     DS_DESCRICAO_DETALHADA
      ,NULL                                                                     DS_APRESENTACAO             
      ,NULL                                                                     NM_FABRICANTE
      ,NULL                                                                     CD_REF_FABRICANTE
      ,NULL                                                                     NM_LABORATORIO
      ,NULL                                                                     DS_SIGLA
      ,SEQ_TUSS.NEXTVAL                                                         CD_SEQ_TUSS
      ,NULL                                                                     CD_MULTI_EMPRESA
      ,CONVENIO.CD_CONVENIO                                                     CD_CONVENIO
      ,NULL                                                                     TP_ATENDIMENTO
      ,NULL                                                                     CD_ESPECIALIDADE
      ,NULL                                                                     CD_TIP_ACOM
      ,NULL                                                                     CD_MOT_ALT
      ,NULL                                                                     TP_SEXO
      ,NULL                                                                     CD_SERVICO
      ,NULL                                                                     TP_GRU_PRO
      ,NULL                                                                     CD_GRU_PRO
      ,PRO_FAT.CD_PRO_FAT                                                       CD_PRO_FAT
      ,NULL                                                                     CD_ATI_MED
      ,NULL                                                                     TP_SERVICO_HOSPITALAR
      ,NULL                                                                     CD_CONSELHO
      ,NULL                                                                     CD_MOTIVO_GLOSA
      ,NULL                                                                     CD_REFERENCIA
      ,NULL                                                                     CD_SETOR 
  FROM PRO_FAT
      ,CONVENIO 
  WHERE PRO_FAT.CD_PRO_FAT NOT IN (
                                    SELECT DISTINCT TUSS.CD_PRO_FAT 
                                      FROM PRO_FAT
                                      LEFT JOIN COD_PRO
                                        ON PRO_FAT.CD_PRO_FAT = COD_PRO.CD_PRO_FAT
                                      LEFT JOIN TUSS
                                        ON PRO_FAT.CD_PRO_FAT = TUSS.CD_PRO_FAT
                                      WHERE TUSS.CD_CONVENIO BETWEEN 116 AND 141
                                        AND COD_PRO.CD_CONVENIO BETWEEN 116 AND 141
                                        AND PRO_FAT.CD_GRU_PRO IN (8,94,95,96)                                                     
                                  )
    AND PRO_FAT.CD_GRU_PRO IN (8,94,95,96)
    AND PRO_FAT.SN_ATIVO = 'S' 
    AND CONVENIO.CD_CONVENIO BETWEEN 116 AND 141
