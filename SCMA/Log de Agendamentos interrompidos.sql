SELECT *
  FROM DBAMV.LOG_OPERA_AGENDA_CENTRAL
  WHERE LOG_OPERA_AGENDA_CENTRAL.TP_OPERACAO = 'AB'
ORDER BY 2 DESC

/*
 Tipo de Opera��o:
 (A) Agendamento
 (T) Transfer�ncia ;
 (B) Bloqueio de Agenda;
 (D) Desbloqueio de agenda;
 (E) Exclus�o de Agenda;
 (H) Exclus�o de  hor�rio;
 (C) Cancelamento de Hor�rio;
 (R) Revers�o de Cancelamento de hor�rio;
 (P) Altera��o de paciente agendado;
 (HD) Exclus�o de hor�rio por desist�ncia;
 (HA) Exclus�o de hor�rio por Alta;
 (HZ) Exclus�o de hor�rio por dispensa;
 (AA) Altera��o de Agendamento;
 (CF) Confirma��o de falta;
 (RP) Retirar presen�a;
 (CP) Confirma��o de Presen�a;
 (RF) Retirar falta;
 (CC) Confirma��o de contato
*/