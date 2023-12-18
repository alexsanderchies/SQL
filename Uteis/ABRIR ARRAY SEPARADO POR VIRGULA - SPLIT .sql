 select regexp_substr (
           identificadores,
           '[^,]+',
           1,
           level
         ) valor
         ,cd_aviso_cirurgia
         ,CD_REGISTRO
FROM (                     
SELECT LISTAGG(a.IDENTIFICADORES, ', ')
          WITHIN GROUP(ORDER BY a.IDENTIFICADORES DESC) IDENTIFICADORES 
      ,LISTAGG(a.CD_AVISO_CIRURGIA, ', ')
          WITHIN GROUP(ORDER BY a.CD_AVISO_CIRURGIA DESC) CD_AVISO_CIRURGIA
      ,LISTAGG(To_Char(a.DS_PROD_AVULSOS), ', ')
          WITHIN GROUP(ORDER BY a.DS_PROD_AVULSOS DESC) DS_PROD_AVULSOS
      ,CD_REGISTRO
  FROM (
        SELECT To_Char(SUBSTR(LO_VALOR,2)) IDENTIFICADORES
              ,NULL                        CD_AVISO_CIRURGIA
              ,NULL                        DS_PROD_AVULSOS
              ,EDITOR_REGISTRO.CD_REGISTRO CD_REGISTRO
          FROM DBAMV.EDITOR_REGISTRO 
          JOIN DBAMV.EDITOR_REGISTRO_CAMPO
            ON EDITOR_REGISTRO.CD_REGISTRO = EDITOR_REGISTRO_CAMPO.CD_REGISTRO  
          JOIN DBAMV.EDITOR_CAMPO
            ON EDITOR_REGISTRO_CAMPO.CD_CAMPO = EDITOR_CAMPO.CD_CAMPO 
          WHERE EDITOR_CAMPO.ds_identificador IN ('DS_COD_BARRAS_2')
        UNION ALL 
        SELECT NULL                        IDENTIFICADORES
              ,To_Char(lo_valor)           CD_AVISO_CIRURGIA
              ,NULL                        DS_PROD_AVULSOS
              ,EDITOR_REGISTRO.CD_REGISTRO CD_REGISTRO                       
          FROM DBAMV.EDITOR_REGISTRO 
          JOIN DBAMV.EDITOR_REGISTRO_CAMPO
            ON EDITOR_REGISTRO.CD_REGISTRO = EDITOR_REGISTRO_CAMPO.CD_REGISTRO  
          JOIN DBAMV.EDITOR_CAMPO
            ON EDITOR_REGISTRO_CAMPO.CD_CAMPO = EDITOR_CAMPO.CD_CAMPO 
          WHERE EDITOR_CAMPO.ds_identificador IN ('NR_AVISO_CIRURGIA_2')
            AND lo_valor IS NOT NULL
        UNION ALL 
        SELECT NULL                        IDENTIFICADORES
              ,NULL                        CD_AVISO_CIRURGIA
              ,To_Char(lo_valor)           DS_PROD_AVULSOS
              ,EDITOR_REGISTRO.CD_REGISTRO CD_REGISTRO
          FROM DBAMV.EDITOR_REGISTRO 
          JOIN DBAMV.EDITOR_REGISTRO_CAMPO
            ON EDITOR_REGISTRO.CD_REGISTRO = EDITOR_REGISTRO_CAMPO.CD_REGISTRO  
          JOIN DBAMV.EDITOR_CAMPO
            ON EDITOR_REGISTRO_CAMPO.CD_CAMPO = EDITOR_CAMPO.CD_CAMPO 
          WHERE EDITOR_CAMPO.ds_identificador IN ('DS_MAT_MED_AVULSO_2')
        ) A
GROUP BY CD_REGISTRO
)
  connect by level <= 
    length (identificadores  ) - length ( replace ( identificadores, ',' ) ) + 1; 