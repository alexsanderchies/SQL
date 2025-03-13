
SELECT
'alter system kill session '||''''||s.sid||','||s.serial#||',@'||s.inst_id||''''||';' kill
,s.inst_id             AS iid,
Trunc(Mod(s.last_call_et/3600,60))||'h:'||Trunc(Mod((s.last_call_et/60),60))||'mim:'||Trunc(Mod(s.last_call_et,60))||'s' "LAST_CALL_ET",
       s.audsid              AS audsid,
       s.sid                 AS sid,
       s.serial#             AS sr#,
       (select cd_usuario||' - '||nm_usuario from dbasgu.usuarios where cd_usuario = s.username  ) AS username ,
    --   s.username            AS username,
       s.osuser              AS osuser,
       s.last_call_et        as lce,
       (select name from audit_actions where action = s.command) as action,
       s.sql_id              AS sql_id,
  --     s.sql_child_number    as sql_cld#,
       s.blocking_session    AS blksess,
       s.blocking_instance   AS blki,
       substr( nvl( s.module, s.program ), 1, 15 ) AS program,
       substr( s.action, 1, 15 ) AS action,
       substr( nvl( s.machine, s.terminal ), 1, 15 ) AS machine,
       s.event               AS event
FROM gv$session s
WHERE s.username IS NOT NULL
   AND s.status = 'ACTIVE'
      AND audsid <> ( SELECT userenv( 'SESSIONID' ) FROM dual  )
 --AND sql_id IS NOT NULL
   --   AND s.blocking_session = 8892
    --  AND  s.sid = 6686
  --  AND username ='F0111663'
  --AND username LIKE '%ACESSOPRD%'

-- AND  s.last_call_et  >=  3554

   --AND  sql_id   ='d4n0z3s3aqa12'
ORDER BY s.last_call_et DESC;



/*

SELECT * FROM table (DBMS_XPLAN.DISPLAY_CURSOR('3xjtcmb66u2nr',0));

*/