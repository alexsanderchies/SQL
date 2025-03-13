--locks - kill session
SELECT 'alter system kill session '''||b.sid||','||sb.serial#||''' immediate' comando,
       'alter system kill session '''||b.sid||','||sb.serial#||',@'||b.inst_id||''' immediate' comando_RAC,
       w.inst_id w_inst,
       w.sid w_sid,
       sw.serial#,
       sw.username w_user,
       sw.osuser w_osuser,
       NVL(sw.module,sw.program) w_program,
       NVL(sw.machine,sw.terminal) w_machine,
       sw.action w_action,
       b.inst_id b_inst,
       b.sid b_sid,
       sb.serial# b_serial#,
       sb.username b_user,
       sb.osuser b_osuser,
       NVL(sb.module,sb.program) b_program,
       NVL(sb.machine,sb.terminal) b_machine,
       sb.action b_action,
       sb.status b_status,
       (SELECT owner||'.'||object_name
          FROM dba_objects o
         WHERE o.object_id = sw.row_wait_obj#) object
  FROM gv$lock b,
       gv$lock w,
       gv$session sb,
       gv$session sw
 WHERE b.block    >= 1
   AND w.request  >  0
   AND b.id1      =  w.id1
   AND b.id2      =  w.id2
   AND sb.sid     =  b.sid
   AND sb.inst_id =  b.inst_id
   AND sw.sid     =  w.sid
   AND sw.inst_id =  w.inst_id;