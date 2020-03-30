SELECT fs.tablespace_name name,
       df.totalspace mbytes,
       (df.totalspace - fs.freespace) used,
       fs.freespace free,
       100 * (fs.freespace / df.totalspace) pct_free
  FROM (SELECT tablespace_name, ROUND(SUM(bytes) / 1048576) TotalSpace
          FROM dba_data_files
         GROUP BY tablespace_name) df,
       (SELECT tablespace_name, ROUND(SUM(bytes) / 1048576) FreeSpace
          FROM dba_free_space
         GROUP BY tablespace_name) fs
 WHERE df.tablespace_name = fs.tablespace_name(+);
