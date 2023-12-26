--GERAR PRESCRIÇÃO:
--TIPO DE REGRA: AO FINALIZAR DOCUMENTO
--RESPOSTA: ITEM 1 = TRUE
--AÇÃO: 
CALL
DBAMV.PRC_COPIA_PRESC_PADRAO_DOC(5, &<PAR_CD_ATENDIMENTO>, '&<PAR_CD_USUARIO>',447)
/*  onde 5 substitua pelo código da prescrição padrão gerada
	onde 447 substitua pelo código de objeto da prescrição médica)
*/
