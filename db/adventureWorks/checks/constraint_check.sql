SELECT DISTINCT
    con.conname AS constraint_name,
    con.conrelid::regclass AS table_name,
    --a.attname AS column_name,
    case 
		when con.contype in ('p') then 'primary'
		when con.contype in ('f') then 'foreign'
		when con.contype in ('u') then 'unique'
		when con.contype in ('c') then 'check'
		END AS constraint_type
FROM 
    pg_constraint con
JOIN pg_attribute a ON 
    a.attnum = ANY(con.conkey)
WHERE 
    con.connamespace = 'prod'::regnamespace  -- adjust schema if needed
ORDER BY 
    table_name, 
    constraint_name;
