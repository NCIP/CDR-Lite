select  'drop table '||tablename ||' cascade ;' as cmd 
  FROM pg_catalog.pg_tables
 where tableowner = 'cdr'
union
select 'drop sequence '||sequence_name||';' as cmd 
FROM information_schema.sequences where sequence_catalog = 'cdr';

/*
SELECT * FROM pg_catalog.pg_tables where tableowner = 'cdr'

SELECT sequence_name FROM information_schema.sequences where sequence_catalog = 'cdr'

describe pg_catalog.pg_tables

SELECT
    table_schema || '.' || table_name
FROM
    information_schema.tables
WHERE
    table_type = 'BASE TABLE'
AND
    table_schema NOT IN ('pg_catalog', 'information_schema');
*/