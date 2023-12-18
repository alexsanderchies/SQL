SELECT *
  FROM DBAMV.LOG_OPERA_AGENDA_CENTRAL
  WHERE LOG_OPERA_AGENDA_CENTRAL.TP_OPERACAO = 'AB'
ORDER BY 2 DESC

/*
 Tipo de Operação:
 (A) Agendamento
 (T) Transferência ;
 (B) Bloqueio de Agenda;
 (D) Desbloqueio de agenda;
 (E) Exclusão de Agenda;
 (H) Exclusão de  horário;
 (C) Cancelamento de Horário;
 (R) Reversão de Cancelamento de horário;
 (P) Alteração de paciente agendado;
 (HD) Exclusão de horário por desistência;
 (HA) Exclusão de horário por Alta;
 (HZ) Exclusão de horário por dispensa;
 (AA) Alteração de Agendamento;
 (CF) Confirmação de falta;
 (RP) Retirar presença;
 (CP) Confirmação de Presença;
 (RF) Retirar falta;
 (CC) Confirmação de contato
*/