SELECT RTrim(to_char(SYSDATE, 'dd')) || ' de ' ||
       RTrim(to_char(SYSDATE, 'Month', 'NLS_DATE_LANGUAGE=PORTUGUESE')) || ' de ' ||
       RTrim(to_char(SYSDATE, 'yyyy')) Data_Atual
  FROM dual