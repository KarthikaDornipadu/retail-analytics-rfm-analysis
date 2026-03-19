✅ Step 1 – View data
SQL
SELECT * FROM raw_data;
✅ Step 2 – Check structure
SQL
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'raw_data';
✅ Step 3 – Check missing values
SQL
SELECT COUNT(*) AS Missing_Transaction_ID
FROM raw_data
WHERE Transaction_ID IS NULL;
✅ Step 4 – Delete missing values
SQL
DELETE FROM raw_data
WHERE Transaction_ID IS NULL;
✅ Step 5 – Find duplicates
SQL
SELECT Transaction_ID, COUNT(*)
FROM raw_data
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;
✅ Step 6 – Remove duplicates
SQL
WITH cte AS (
    SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY Transaction_ID
        ORDER BY (SELECT NULL)
    ) AS rn
    FROM raw_data
)
DELETE FROM cte
WHERE rn > 1;