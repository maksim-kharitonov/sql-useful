SELECT 'USER: '||s.username||' SID: '||s.sid||' SERIAL #: '||S.SERIAL# "USER HOLDING LOCK" 
  ,o.OBJECT_NAME
FROM v$lock l 
,dba_objects o 
,v$session s 
WHERE l.id1 = o.object_id 
AND s.sid = l.sid 
AND o.owner = 'SOFI_VIP' 
--AND o.object_name = 'NAME of the temporary table';
