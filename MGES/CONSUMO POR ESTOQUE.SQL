SELECT SAIDAS.CD_PRODUTO
      ,PRODUTO.DS_PRODUTO
      ,UNI_PRO.DS_UNIDADE
      ,Nvl(SAIDAS.TOTAL_SAIDA,0) - Nvl(DEVOLUCOES.TOTAL_DEV,0)  CONSUMIDO
      ,CONSUMO_7.CONSUMIDO_7  
      ,Round(CONSUMO_7.CONSUMIDO_7 /7,2) MEDIA_CONSUMO
      ,EST_PRO.QT_ESTOQUE_ATUAL
      ,Round(CONSUMO_7.CONSUMIDO_7 /7,2) * 30 PREV_CONS_30
  FROM (
        SELECT ITMVTO_ESTOQUE.CD_PRODUTO     
              ,Sum(itmvto_estoque.QT_MOVIMENTACAO * UNI_PRO.VL_FATOR) TOTAL_SAIDA
          FROM DBAMV.MVTO_ESTOQUE
          JOIN DBAMV.ITMVTO_ESTOQUE
            ON MVTO_ESTOQUE.CD_MVTO_ESTOQUE = ITMVTO_ESTOQUE.CD_MVTO_ESTOQUE
          JOIN DBAMV.UNI_PRO
            ON ITMVTO_ESTOQUE.CD_PRODUTO = UNI_PRO.CD_PRODUTO
          AND ITMVTO_ESTOQUE.CD_UNI_PRO = UNI_PRO.CD_UNI_PRO   
          WHERE MVTO_ESTOQUE.DT_MVTO_ESTOQUE = $DataInicial$
            AND MVTO_ESTOQUE.TP_MVTO_ESTOQUE IN ('S','P') -- SAIDAS DE SETOR E PACIENTE
			and MVTO_ESTOQUE.CD_ESTOQUE = $Estoque$ 
            AND mvto_estoque.cd_setor IN ($SETOR$) 
			
        GROUP BY ITMVTO_ESTOQUE.CD_PRODUTO
        )  SAIDAS
  
  
  LEFT JOIN (
              SELECT ITMVTO_ESTOQUE.CD_PRODUTO
                    ,Sum(itmvto_estoque.QT_MOVIMENTACAO * UNI_PRO.VL_FATOR) TOTAL_DEV 
                FROM DBAMV.MVTO_ESTOQUE
                JOIN DBAMV.ITMVTO_ESTOQUE
                  ON MVTO_ESTOQUE.CD_MVTO_ESTOQUE = ITMVTO_ESTOQUE.CD_MVTO_ESTOQUE
                JOIN DBAMV.UNI_PRO
                  ON ITMVTO_ESTOQUE.CD_PRODUTO = UNI_PRO.CD_PRODUTO
                AND ITMVTO_ESTOQUE.CD_UNI_PRO = UNI_PRO.CD_UNI_PRO  
                WHERE MVTO_ESTOQUE.DT_MVTO_ESTOQUE = $DataInicial$
				  and MVTO_ESTOQUE.CD_ESTOQUE = $Estoque$ 
                  AND MVTO_ESTOQUE.TP_MVTO_ESTOQUE IN ('D','C') -- DEVOLUÇÕES DE SETOR E PACIENTE
                  AND mvto_estoque.cd_setor IN ($SETOR$) 
              GROUP BY ITMVTO_ESTOQUE.CD_PRODUTO
              ) DEVOLUCOES
    ON SAIDAS.CD_PRODUTO = DEVOLUCOES.CD_PRODUTO 
  
  
  LEFT JOIN (
              SELECT SAIDAS_7.CD_PRODUTO
                    ,Nvl(SAIDAS_7.TOTAL_SAIDA_7,0) - Nvl(DEVOLUCOES_7.TOTAL_DEV_7,0)  CONSUMIDO_7
                FROM (
                      SELECT ITMVTO_ESTOQUE.CD_PRODUTO   
                            ,Sum(ITMVTO_ESTOQUE.QT_MOVIMENTACAO * UNI_PRO.VL_FATOR) TOTAL_SAIDA_7
                        FROM DBAMV.MVTO_ESTOQUE
                        JOIN DBAMV.ITMVTO_ESTOQUE
                          ON MVTO_ESTOQUE.CD_MVTO_ESTOQUE = ITMVTO_ESTOQUE.CD_MVTO_ESTOQUE
                        JOIN DBAMV.UNI_PRO
                          ON ITMVTO_ESTOQUE.CD_PRODUTO = UNI_PRO.CD_PRODUTO
                        AND ITMVTO_ESTOQUE.CD_UNI_PRO = UNI_PRO.CD_UNI_PRO 
                        WHERE MVTO_ESTOQUE.DT_MVTO_ESTOQUE BETWEEN To_Date($DataInicial$,'dd/mm/yyyy')-7 AND To_Date($DataInicial$,'dd/mm/yyyy')
						  and MVTO_ESTOQUE.CD_ESTOQUE = $Estoque$ 
                          AND mvto_estoque.cd_setor IN ($SETOR$) 
						  AND MVTO_ESTOQUE.TP_MVTO_ESTOQUE IN ('S','P') -- SAIDAS DE SETOR E PACIENTE
                          
                      GROUP BY ITMVTO_ESTOQUE.CD_PRODUTO 
                      )SAIDAS_7
                
                
                LEFT JOIN (
                            SELECT ITMVTO_ESTOQUE.CD_PRODUTO
                                  ,Sum(ITMVTO_ESTOQUE.QT_MOVIMENTACAO * UNI_PRO.VL_FATOR) TOTAL_DEV_7 
                              FROM DBAMV.MVTO_ESTOQUE
                              JOIN DBAMV.ITMVTO_ESTOQUE
                                ON MVTO_ESTOQUE.CD_MVTO_ESTOQUE = ITMVTO_ESTOQUE.CD_MVTO_ESTOQUE
                              JOIN DBAMV.UNI_PRO
                                ON ITMVTO_ESTOQUE.CD_PRODUTO = UNI_PRO.CD_PRODUTO
                              AND ITMVTO_ESTOQUE.CD_UNI_PRO = UNI_PRO.CD_UNI_PRO
                              WHERE MVTO_ESTOQUE.DT_MVTO_ESTOQUE BETWEEN To_Date($DataInicial$,'dd/mm/yyyy')-7 AND To_Date( $DataInicial$ ,'dd/mm/yyyy')
							    and MVTO_ESTOQUE.CD_ESTOQUE = $Estoque$
								AND mvto_estoque.cd_setor IN ($SETOR$)
                                AND MVTO_ESTOQUE.TP_MVTO_ESTOQUE IN ('D','C') -- DEVOLUÇÕES DE SETOR E PACIENTE
                                
                            GROUP BY ITMVTO_ESTOQUE.CD_PRODUTO 
                            ) DEVOLUCOES_7
                  ON SAIDAS_7.CD_PRODUTO = DEVOLUCOES_7.CD_PRODUTO
            ) CONSUMO_7
    ON SAIDAS.CD_PRODUTO = CONSUMO_7.CD_PRODUTO
  JOIN DBAMV.EST_PRO
    ON SAIDAS.CD_PRODUTO = EST_PRO.CD_PRODUTO
  JOIN DBAMV.UNI_PRO
    ON SAIDAS.CD_PRODUTO = UNI_PRO.CD_PRODUTO
  JOIN DBAMV.PRODUTO
    ON SAIDAS.CD_PRODUTO = PRODUTO.CD_PRODUTO
  WHERE EST_PRO.CD_ESTOQUE =  $Estoque$ 
    AND UNI_PRO.TP_RELATORIOS = 'R'
    AND PRODUTO.SN_PADRONIZADO  IN ($Padronizados$) 
ORDER BY 2,3