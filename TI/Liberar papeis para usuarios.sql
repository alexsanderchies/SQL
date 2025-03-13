INSERT INTO DBASGU.PAPEL_USUARIOS
SELECT USUARIOS.CD_USUARIO
      ,PAPEL.CD_PAPEL
      ,'A'
      ,'N'
  FROM DBASGU.USUARIOS
      ,DBASGU.PAPEL
  WHERE USUARIOS.CD_USUARIO IN ('HC4000',
                                'HC3440',
                                'HC5272',
                                'HC6828',
                                'HC5706',
                                'HC3393',
                                'HC3628',
                                'HC2738',
                                'HC2955',
                                'HC2056',
                                'HC6095',
                                'HC5020',
                                'HC4988',
                                'HC4004',
                                'HC3843',
                                'HC6254',
                                'HC7873',
                                'HC7876',
                                'HC7884',
                                'HC7917',
                                'HC7912',
                                'HC7919',
                                'HC108',
                                'HC2847',
                                'HC3391')
    AND PAPEL.CD_PAPEL IN (1,2,4,5,7,19)
    AND (USUARIOS.CD_USUARIO, PAPEL.CD_PAPEL) NOT IN (SELECT CD_USUARIO, CD_PAPEL FROM dbasgu.papel_usuarios)
ORDER BY 1