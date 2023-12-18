--query dos exemplos
select * from
 (select sql_fulltext, dbms_lob.substr (v$sql.SQL_fullTEXT , 4000, 1 ), 
first_load_time from v$sql 
--order by first_load_time
where substr(first_load_time,0,10) = to_char(sysdate,'yyyy-mm-dd') --filtro de comparação data atual
order by first_load_time desc --ordenando ultimas querys executadas no banco
 )tb1 
where 1=1
and rownum <30 --quantidades de linhas que vai retornar