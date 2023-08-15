WITH TableCounts AS (
    SELECT 
        tablename,
        schemaname,
        (xpath('/row/cnt/text()', 
          query_to_xml('SELECT COUNT(*) as cnt FROM ' || schemaname || '.' || tablename, 
          false, true, '')))[1]::text::int AS cnt
    FROM 
        pg_tables
    WHERE 
        schemaname = 'prod' -- adjust schema if needed
)

SELECT 
    tablename AS full_table_name
FROM 
    TableCounts
WHERE 
    cnt > 0;
	
	
