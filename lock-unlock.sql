--создание пользователя 
CREATE USER "UPDATER"  PROFILE "DEFAULT" IDENTIFIED BY "1" 
    DEFAULT 
    TABLESPACE "SOFI_DATA" TEMPORARY 
    TABLESPACE "TEMP" ACCOUNT UNLOCK;
    
GRANT "CONNECT" TO "UPDATER";
GRANT ALTER USER TO "UPDATER";
GRANT ALTER SESSION TO "UPDATER";

GRANT SELECT ANY TABLE TO "UPDATER";
GRANT CREATE ANY TABLE TO "UPDATER";
GRANT DELETE ANY TABLE TO "UPDATER";
GRANT INSERT ANY TABLE TO "UPDATER";
GRANT UPDATE ANY TABLE TO "UPDATER";

ALTER USER "UPDATER" QUOTA UNLIMITED ON "SOFI_DATA";   


--создание таблички хранения схем
create table UPDATER.Schemas
(
  name varchar2(50) not null
);
alter table UPDATER.SCHEMAS
  add constraint PK_SCHEMAS primary key (NAME);
  
--Отключаем и блокируем всех пользователей СОФИ
--выполняется владельцем схемы перед патчем
begin
  for c1 in (select s.SID, s.SERIAL#, s.USERNAME from V$SESSION s 
              where s.SCHEMANAME = (select v.SCHEMANAME from V$SESSION v where v.AUDSID = userenv('sessionid')) 
                and s.AUDSID <> userenv('sessionid')
  )loop
     execute immediate 'alter system kill session ''' || to_char(c1.sid) || ',' || to_char(c1.serial#) || ''' immediate';
  end loop;

  for c1 in (select * from all_users au, c_users u 
              where au.username = Upper(u.login)
                and username not in ('SYS', 'SYSTEM', 'PUBLIC', 'INTERNAL', 'UPDATER')
  ) loop
    execute immediate 'alter user ' || c1.username || ' ACCOUNT LOCK ';

    insert into UPDATER.schemas (NAME) values (c1.username);    
    commit;
  end loop;
end;

--Снимаем блокировку пользователей СОФИ
--выполняется пользователем UPDATER
begin
  for schemas in (
                  select t.name from schemas t
  )loop
    execute immediate '
      begin
        for c1 in (select * from all_users au, '||schemas.name||'.c_users u 
                    where au.username = Upper(u.login)
                      and username not in (''SYS'', ''SYSTEM'', ''PUBLIC'', ''INTERNAL'', ''UPDATER'')) 
        loop
           execute immediate ''alter user ''|| c1.username ||'' ACCOUNT UNLOCK '';           
        end loop;
        delete schemas s where s.name='''||schemas.name||''';           
        commit;      
      end;';
  end loop;
end;
