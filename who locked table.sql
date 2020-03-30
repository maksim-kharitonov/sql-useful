select v.oracle_username,
                     v.os_user_name,
                     v.session_id, V.*, A.*
              from v$locked_object v,
                   all_objects a
              where v.object_id=a.object_id
                    and a.object_type='TABLE'
                    and a.object_name= <ÈÌß_ÒÀÁËÈÖÛ>
                    and a.owner='SOFI_26MOU2'