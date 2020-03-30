select owner,ds.tablespace_name, round(sum(bytes)/1024/1024/1024,2) from dba_segments ds
group by owner,ds.tablespace_name
order by owner,ds.tablespace_name;

  select owner, round(sum(bytes)/1024/1024/1024,2) from dba_segments ds
group by owner
order by owner;

select /*owner, */round(sum(bytes)/1024/1024/1024,2) from dba_segments ds
--group by owner
order by owner;
