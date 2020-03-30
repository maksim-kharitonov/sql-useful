--Илья Грызлов, 22.12.2011 13:04:31:
select a.inst_id,
(select username from gv$session s where s.inst_id=a.inst_id and s.sid=a.sid) blocker,
a.sid,
(select module from gv$session s where s.inst_id=a.inst_id and s.sid=a.sid) blocker_module ,
' is blocking ' "IS BLOCKING",
b.inst_id,
(select username from gv$session s where s.inst_id=b.inst_id and s.sid=b.sid) blockee,
b.sid ,
(select module from gv$session s where s.inst_id=b.inst_id and s.sid=b.sid) blockee_module
,s.*
from gv$lock a, gv$lock b, v$session s
where
--Modified to take care of issue where sid blocked on difft instances are not showing
-- Original Script
 a.block = 1
and b.request > 0
and a.id1 = b.id1
and a.inst_id = b.inst_id
and a.id2 = b.id2
and s.SID = a.SID
-- Modified script
/*a.block 0 and
b.request > 0
and a.id1 = b.id1
and a.id2 = b.id2
and a.sid b.sid*/
order by 1, 2
/

--=================================================
--=================================================
select d.OWNER, d.OBJECT_NAME, d2.OWNER, d2.OBJECT_NAME, l.*, d.*, d2.* from v$lock l, dba_objects d, dba_objects d2
where l.id1 = d.OBJECT_ID(+)
  and l.ID2 = d2.OBJECT_ID(+)
 -- and d.object_name = 'V_PARSE_ERROR'
  and l.SID = 17

--=================================================
--=================================================
--http://psoug.org/reference/locks.html

select username,
           v$lock.sid,
           trunc(id1/power(2,16)) rbs,
           bitand(id1,to_number('ffff','xxxx'))+0 slot,
           id2 seq,
           lmode,
           request, t.*, r.*
    from v$lock, v$session, V$TRANSACTION t,sys.v_$rollname r
    where v$lock.type = 'TX'
     and v$lock.sid = v$session.sid
     and v$session.username = USER
     and t.XIDUSN(+)=trunc(id1/power(2,16))
     and t.XIDSLOT(+)=bitand(id1,to_number('ffff','xxxx'))+0
     and t.XIDSQN(+)=id2
     and t.xidusn = r.usn(+)
