INSERT INTO TUSS
SELECT Nvl(TUSS_MIN.CD_TIP_TUSS,0)                                              CD_TIP_TUSS  
      ,COD_PRO.DS_CODIGO_COBRANCA                                               CD_TUSS
      ,Nvl(COD_PRO.DS_NOME_COBRANCA,PRO_FAT.DS_PRO_FAT)                         DS_TUSS
      ,'02/05/2022'                                                             DT_INICIO_VIGENCIA
      ,'03/05/2022'                                                             DT_FIM_VIGENCIA
      ,NULL                                                                     DT_FIM_IMPLANTACAO
      ,NULL                                                                     DS_EDICAO_NORMA_OBSERVACOES
      ,NULL                                                                     DS_DESCRICAO_DETALHADA
      ,NULL                                                                     DS_APRESENTACAO             
      ,NULL                                                                     NM_FABRICANTE
      ,NULL                                                                     CD_REF_FABRICANTE
      ,NULL                                                                     NM_LABORATORIO
      ,NULL                                                                     DS_SIGLA
      ,SEQ_TUSS.NEXTVAL                                                         CD_SEQ_TUSS
      ,COD_PRO.CD_MULTI_EMPRESA                                                 CD_MULTI_EMPRESA
      ,COD_PRO.CD_CONVENIO                                                      CD_CONVENIO
      ,Decode(COD_PRO.tp_atendimento,'U','U','A','A','E','E','I','I',NULL)      TP_ATENDIMENTO
      ,NULL                                                                     CD_ESPECIALIDADE
      ,NULL                                                                     CD_TIP_ACOM
      ,NULL                                                                     CD_MOT_ALT
      ,NULL                                                                     TP_SEXO
      ,NULL                                                                     CD_SERVICO
      ,NULL                                                                     TP_GRU_PRO
      ,NULL                                                                     CD_GRU_PRO
      ,COD_PRO.CD_PRO_FAT                                                       CD_PRO_FAT
      ,NULL                                                                     CD_ATI_MED
      ,NULL                                                                     TP_SERVICO_HOSPITALAR
      ,NULL                                                                     CD_CONSELHO
      ,NULL                                                                     CD_MOTIVO_GLOSA
      ,NULL                                                                     CD_REFERENCIA
      ,NULL                                                                     CD_SETOR
  FROM COD_PRO
  JOIN PRO_FAT
    ON COD_PRO.CD_PRO_FAT = PRO_FAT.CD_PRO_FAT
  LEFT JOIN (SELECT CD_TUSS
                   ,CD_TIP_TUSS
                   ,CD_SEQ_TUSS
               FROM TUSS
               WHERE (CD_TUSS,CD_SEQ_TUSS) IN (SELECT CD_TUSS
                                                     ,Min(CD_SEQ_TUSS)
                                                FROM TUSS 
                                                GROUP BY CD_TUSS
                                              )
            ) TUSS_MIN
    ON COD_PRO.DS_CODIGO_COBRANCA = TUSS_MIN.CD_TUSS                                   
  WHERE COD_PRO.CD_CONVENIO NOT IN (SELECT CD_CONVENIO FROM CONVENIO WHERE NM_CONVENIO LIKE '%INATIV%')
    AND COD_PRO.CD_CONVENIO NOT IN (SELECT CD_CONVENIO FROM CONVENIO WHERE NM_CONVENIO LIKE '%DESAT%')
    AND COD_PRO.CD_CONVENIO NOT IN (480,1,31)
	AND Length(COD_PRO.DS_CODIGO_COBRANCA) < 11
    AND PRO_FAT.CD_GRU_PRO NOT IN (65)
