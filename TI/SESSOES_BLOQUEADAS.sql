SELECT
'alter system kill session '||''''||b.sid||','||b.serial#||',@'||b.inst_id||''''||';' KILL,
Trunc(Mod(W.last_call_et/3600,60))||'h:'||Trunc(Mod((W.last_call_et/60),60))||'mim:'||Trunc(Mod(W.last_call_et,60))||'s' "TEMPO",
b.inst_id b_inst_id, b.sid b_sid,b.serial# b_serial#,b.username b_username ,
b.osuser b_osuser, NVL(b.module,b.program) b_program ,NVL(b.machine,b.terminal) b_machine,
b.action b_action,b.status b_status,
w.inst_id w_inst_id, w.sid w_sid,w.serial# w_serial#,
w.username w_username ,w.osuser w_osuser, NVL(w.module,w.program) w_program,
NVL(w.machine,w.terminal) w_machine,w.action w_action,'####'
,
(SELECT owner||'.'||object_name
          FROM dba_objects o
         WHERE o.object_id = w.row_wait_obj#) object
FROM gv$session w,
     gv$session b
WHERE w.blocking_session  IS NOT NULL
  AND w.blocking_instance = b.inst_id
  AND w.blocking_session = b.sid





                                                                         -- alter system kill session '46,62691,@1';