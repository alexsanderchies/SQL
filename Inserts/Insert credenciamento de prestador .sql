
--INSERT CREDENCIAMENTO NA TELA DE PRESTADORES CREDENCIADOS M_CAD_PREST_CONV_CREDENC
--SOMENTE IPERGS
INSERT INTO DBAMV.PREST_CONV_CREDENC
SELECT seq_prest_conv_credenc.NEXTVAL      cd_prest_conv_credenc
      ,PRESTADOR.NM_PRESTADOR              nm_prestador
      ,3                                   cd_convenio
      ,00                                  cd_profissional
      ,Trunc(SYSDATE)                      dt_importacao
      ,PRESTADOR.DS_CODIGO_CONSELHO        nr_conselho
      ,'N'                                 sn_importado
      ,'01/01/2023'                        dt_inicio_vigencia
      ,'31/12/2030'                        dt_final_vigencia
  FROM DBAMV.PRESTADOR
  WHERE PRESTADOR.CD_TIP_PRESTA = 8
    AND PRESTADOR.TP_SITUACAO = 'A'
	
	
	
	
	

--INSERT CREDENCIAMENTO PRESTADORES CAD_PRE	
INSERT INTO DBAMV.PRES_CON
SELECT PRESTADOR.CD_PRESTADOR    cd_prestador_conveniado
      ,SEQ_PRES_CON.NEXTVAL      cd_pres_con
      ,CONVENIO.CD_CONVENIO      cd_convenio
      ,PRESTADOR.CD_PRESTADOR    cd_prestador
      ,NULL                      cd_reg_repasse
      ,'S'                       sn_paga_pelo_convenio
      ,NULL                      cd_unidade_origem
      ,1                         cd_multi_empresa
      ,NULL                      cd_con_pla
      ,NULL                      cd_regra
      ,NULL                      cd_gru_pro
      ,NULL                      cd_pro_fat
  FROM DBAMV.PRESTADOR
      ,DBAMV.CONVENIO 
  WHERE PRESTADOR.CD_TIP_PRESTA = 8
    AND PRESTADOR.TP_SITUACAO = 'A'
    AND CONVENIO.TP_CONVENIO = 'C'

