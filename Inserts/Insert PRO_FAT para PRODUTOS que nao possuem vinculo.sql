--Insere profat quando não tiver nenhum já cadastrado com a mesma descrição e quando não tiver algum com o mesmo código da lógica CD_GRU_PRO + CD_PRODUTO com 8 digitos
INSERT INTO DBAMV.PRO_FAT
SELECT LPad(SUB_CLAS.CD_GRU_PRO,2,0)||LPad(PRODUTO.CD_PRODUTO,6,0)            CD_PRO_FAT
      ,PRODUTO.DS_PRODUTO                                                     DS_PRO_FAT
      ,UNI_PRO.CD_UNIDADE                                                     DS_UNIDADE
      ,'A'                                                                    TP_SEXO
      ,NULL                                                                   NR_AUXILIAR
      ,NULL                                                                   NR_INCICENCIAS
      ,NULL                                                                   VL_FILME
      ,SUB_CLAS.CD_GRU_PRO                                                    CD_GRU_PRO
      ,NULL                                                                   CD_POR_ANE
      ,NULL                                                                   QTD_MAXIMA
      ,'N'                                                                    SN_PACOTE
      ,NULL                                                                   NR_DIAS_INTERNACAO
      ,NULL                                                                   CD_SUS
      ,'S'                                                                    SN_ATIVO
      ,NULL                                                                   CD_GRU_PRO_SUS
      ,NULL                                                                   DS_SUS
      ,'N'                                                                    SN_URGENCIA
      ,'N'                                                                    SN_PODE_PERM_MAIOR
      ,'S'                                                                    SN_PODE_SD
      ,NULL                                                                   QT_MAXIMA_UTI
      ,NULL                                                                   QT_MAXIMA_ACOMPANHANTE
      ,NULL                                                                   CD_ESPEC_SUS
      ,NULL                                                                   NR_IDADE_MINIMA
      ,NULL                                                                   NR_IDADE_MAXIMA
      ,NULL                                                                   CD_ATI_MED
      ,'N'                                                                    SN_FIDEPS
      ,'N'                                                                    SN_CD_SUS_AUXILIAR
      ,'N'                                                                    SN_PERTENCE_PACOTE_SUS
      ,NULL                                                                   FATOR
      ,NULL                                                                   VL_FATOR_MINUTO
      ,NULL                                                                   CD_TIP_ACOM_CUSTO
      ,NULL                                                                   CD_ITEM_RES
      ,NULL                                                                   VL_TEMPO
      ,'N'                                                                    SN_CONTRASTE
      ,'S'                                                                    SN_PODE_SER_AUTORIZADO
      ,NULL                                                                   CD_TIPO_REMESSA
      ,NULL                                                                   VL_CUSTO
      ,NULL                                                                   CD_SUS_REDUZIDO
      ,NULL                                                                   CD_SUB_GRU_PRO_SUS
      ,'N'                                                                    SN_ATO_ANESTESICO
      ,'N'                                                                    SN_BUSCA_ATIVA_PAC_OBITO
      ,'N'                                                                    SN_OBRIGA_VDRL
      ,'N'                                                                    SN_PERMITE_ALTA_DA_UTI
      ,'N'                                                                    SN_GERA_MATRICULA_SAME
      ,'N'                                                                    SN_LANCA_PRO_FAT_ATEND
      ,NULL                                                                   NR_HORAS_INTERNACAO
      ,NULL                                                                   NR_DIAS_PERM_UTI
      ,NULL                                                                   NR_HORAS_PERM_UTI
      ,NULL                                                                   TP_SERV_HOSPITALAR
      ,NULL                                                                   CD_COMPLEXIDADE
      ,'S'                                                                    SN_CALCULA_VALOR
      ,'N'                                                                    SN_PARTO
      ,NULL                                                                   TP_CONSULTA
      ,'N'                                                                    SN_DIARIA_UTI_RN
      ,Decode(SUB_CLAS.CD_GRU_PRO,9,'S','N')                                  SN_OPME
  FROM DBAMV.PRODUTO
  JOIN DBAMV.SUB_CLAS
    ON PRODUTO.CD_ESPECIE = SUB_CLAS.CD_ESPECIE
   AND PRODUTO.CD_CLASSE = SUB_CLAS.CD_CLASSE
   AND PRODUTO.CD_SUB_CLA = SUB_CLAS.CD_SUB_CLA
  JOIN DBAMV.UNI_PRO
    ON PRODUTO.CD_PRODUTO = UNI_PRO.CD_PRODUTO
  WHERE PRODUTO.CD_PRO_FAT IS NULL
    AND SUB_CLAS.CD_GRU_PRO IS NOT NULL
    AND UNI_PRO.TP_RELATORIOS = 'R'
    AND PRODUTO.DS_PRODUTO NOT IN (SELECT DS_PRO_FAT FROM PRO_FAT)                                          -- Busca para nao inserir procedimento que já tenha com a mesma descrição
    AND LPad(SUB_CLAS.CD_GRU_PRO,2,0)||LPad(PRODUTO.CD_PRODUTO,6,0) NOT IN (SELECT CD_PRO_FAT FROM PRO_FAT) -- busca para nao inserir quando já tiver algum cadastrado com o mesmo código da lógica GRU_FAT + CD_PRODUTO
ORDER BY 1



--- Monta update para devolver o profat para o cadastro do produto --Substituir o " por ' antes de rodar o update
SELECT 'UPDATE DBAMV.PRODUTO SET' || ' ' || 'PRODUTO.CD_PRO_FAT' || ' = ' || '"' || Min(PRO_FAT.CD_PRO_FAT) || '"' || ' WHERE PRODUTO.CD_PRODUTO = ' | | PRODUTO.CD_PRODUTO || ';' UPDATE_PRODUTO
  FROM PRODUTO
      ,PRO_FAT
  WHERE PRODUTO.DS_PRODUTO = PRO_FAT.DS_PRO_FAT
    AND PRODUTO.CD_PRO_FAT IS NULL
    AND PRO_FAT.SN_ATIVO = 'S'
GROUP BY PRODUTO.CD_PRODUTO
        ,PRODUTO.CD_PRO_FAT
ORDER BY PRODUTO.CD_PRODUTO






