select tbl.owner, tbl.segment_name, tbl.tbl_size, ind.ind_size, lbs.lob_size, 
       tbl.tbl_size +nvl(ind.ind_size,0) + nvl(lbs.lob_size,0) total 
  from ( SELECT dst.owner, dst.segment_name, dst.segment_type/*, dst.tablespace_name*/ 
              , sum(dst.bytes)/1024/1024 tbl_size 
           FROM dba_segments dst 
          WHERE dst.segment_type = 'TABLE' 
            and dst.owner like 'IBE%' 
            --and dst.segment_name ='LOGGING_EVENT' 
          group by dst.owner, dst.segment_name, dst.segment_type/*, dst.tablespace_name*/ 
        )tbl 
        ,(select i.table_owner owner, i.table_name table_name/*, i.index_type*/ 
                ,nvl(sum(dsi.bytes),0)/1024/1024 ind_size 
            from dba_indexes i, dba_segments dsi 
           where dsi.segment_name(+) = i.index_name and dsi.owner(+) = i.owner 
             and dsi.owner like 'IBE%' 
           group by i.table_owner, i.table_name/*, i.index_type*/ 
         ) ind 
        ,(select l.OWNER, l.table_name table_name 
                ,nvl(sum(dsl.bytes),0)/1024/1024 lob_size 
            from dba_lobs l, dba_segments dsl 
           where dsl.segment_name(+) = l.SEGMENT_NAME and dsl.owner(+) = l.owner 
             and dsl.owner like 'IBE%' 
           group by l.OWNER, l.table_name 
         ) lbs 
 where ind.table_name(+) = tbl.segment_name and ind.owner(+) = tbl.owner 
   and lbs.TABLE_NAME(+) = tbl.segment_name and lbs.OWNER(+) = tbl.owner 
   and  tbl.tbl_size +nvl(ind.ind_size,0) + nvl(lbs.lob_size,0) > 50 
order by total desc