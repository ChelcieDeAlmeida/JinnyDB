WITH TablesWithFK AS (
    SELECT DISTINCT kcu.table_name
    FROM information_schema.key_column_usage kcu
    JOIN information_schema.referential_constraints rc 
    ON kcu.constraint_name = rc.constraint_name
    WHERE kcu.table_schema = 'prod'
)

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'prod'
AND table_type = 'BASE TABLE'
AND table_name NOT IN (SELECT table_name FROM TablesWithFK)
ORDER BY table_name
;

