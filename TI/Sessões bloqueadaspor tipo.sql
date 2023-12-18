SELECT 'alter system disconnect session '||''''||b.sid||','||sb.serial#||''''||' immediate' comando
      ,Trunc(round( B.ctime/60, 2 )) tempo
      ,   O.OBJECT_NAME
      ,    sb.username
      ,Trunc(Mod(B.ctime/3600,60))||'h:'||Trunc(Mod((B.ctime/60),60))||'mim:'||Trunc(Mod(B.ctime,60))||'s' tempo2,sb.STATUS,sb.blocking_session,NVL(sb.module,sb.program) program          
      , DECODE(b.lmode, 0, 'NONE',
                        1, 'NULL',
                        2, 'ROW SHARE',
                        3, 'ROW EXCLUSIVE',
                        4, 'SHARE',
                        5, 'SHARE ROW EXCLUSIVE',
                        6, 'EXCLUSIVE',
                        '?') TIPO_LOCK
      ,DECODE(b.request, 0, 'NONE',
                         1, 'NULL',
                         2, 'ROW SHARE',
                         3, 'ROW EXCLUSIVE',
                         4, 'SHARE',
                         5, 'SHARE ROW EXCLUSIVE',
                         6, 'EXCLUSIVE',
                         '?') MODO_LOCK 
  FROM gv$lock b
      ,gv$session sb
      ,dba_objects o 
  WHERE b.TYPE IN ('TM','TX') 
--  AND w.request  >  0   AND o.object_name = 'SOLSAI_PRO'   AND o.object_id      =  b.id1   
--AND b.id2      =  w.id2   AND sb.sid     =  b.sid   AND sb.inst_id =  b.inst_id   AND sb.STATUS = 'INACTIVE'  -- AND sw.sid     =  w.sid  -- AND sw.inst_id =  w.inst_idORDER BY 2 desc