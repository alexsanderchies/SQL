--CRIA JOB ANTIGA
BEGIN

DBMS_SCHEDULER.CREATE_JOB
(
	JOB_NAME => 'LIMPA_SOLSAIPRO_ABERTA',
	JOB_TYPE => 'STORED_PROCEDURE',
	JOB_ACTION => 'PRC_DELETA_SOLSAIPRO_N_ATEND',
	START_DATE => trunc(sysdate)+23/24,
	REPEAT_INTERVAL => 'trunc(sysdate+1)+4/24',
	ENABLED => TRUE,
	COMMENTS => 'DELETAR SOLICITACOES DE ESTOQUE EM ABERTO A MAIS DE 2 DIAS'
);

END;



--CRIAR JOB CORRETA
DECLARE
    jobno number;
BEGIN
   DBMS_JOB.SUBMIT(job => jobno,
                   what=>'DBAMV.PRC_DELETA_SOLSAIPRO_N_ATEND;',
                   next_date => trunc(sysdate+1)+20/24,  	--EXECUTA AS 20H 
                   interval => 'trunc(sysdate+1)+20/24');
END;
