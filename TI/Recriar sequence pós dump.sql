
-- EXECUTAR EM PRODUÇÃO PRA PEGAR A SEQUENCE ATUAL E APÓS EXECUTAR EM SML

set feedback off
set heading off
set linesize 300
set pagesize 5000
spool sequencias.sql
select 'DROP SEQUENCE ' || SEQUENCE_OWNER || '.' || SEQUENCE_NAME || ';' ||
CHR(10) ||
       'CREATE SEQUENCE ' || SEQUENCE_OWNER || '.' || SEQUENCE_NAME  || '
START WITH ' || LAST_NUMBER || ' NOCACHE' || ';'  || CHR(10) ||
       'GRANT SELECT ON ' || SEQUENCE_OWNER || '.' || SEQUENCE_NAME || ' TO
MV2000;'
 from dba_sequences
where SEQUENCE_owner= user and nvl(last_number,0)>0;
spool off


-- EXECUTAR EM SML 

SET HEADING OFF
set linesize 300
SPOOL grant_sequence.sql
select 'GRANT SELECT ON ' ||
       OBJECT_NAME ||
       ' TO MV2000 ; ' comando
from   user_objects
where  object_type = 'SEQUENCE'
        and object_name not like '%BIN$%'
union all -- Dá permissao aos outros usuários do mv2000
select 'GRANT SELECT ON ' ||
       OBJECT_NAME ||
       ' TO '  || u.username  || ';' comando
from   user_objects , all_users u
where  object_type = 'SEQUENCE'
        and  u.username  in ( 'DBAMV' , 'DBASGU' , 'DBAPS' , 'MVINTEGRA')
        and u.username <> user
        and object_name not like '%BIN$%'
union all
select 'CREATE PUBLIC SYNONYM ' ||
       OBJECT_NAME ||
       ' FOR ' ||
       OBJECT_NAME || ';' comando
From user_objects
where object_type = 'SEQUENCE'
        and object_name not like '%BIN$%';
spool off
@grant_sequence.sql
