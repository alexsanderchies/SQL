INSERT INTO DBAMV.PLANO_CONTAS_EMP_TRANSACAO
SELECT plano_estr.CD_REDUZIDO
      ,MULTI_EMPRESAS.CD_MULTI_EMPRESA 
  FROM DBAMV.plano_estr, DBAMV.MULTI_EMPRESAS
  WHERE plano_estr.cd_plano = 002 -- CÓDIGO DO PLANO DE CONTAS 
    AND (plano_estr.CD_REDUZIDO, MULTI_EMPRESAS.CD_MULTI_EMPRESA) NOT IN (SELECT CD_REDUZIDO
                                                                                  ,CD_MULTI_EMPRESA 
                                                                              FROM DBAMV.PLANO_CONTAS_EMP_TRANSACAO)
