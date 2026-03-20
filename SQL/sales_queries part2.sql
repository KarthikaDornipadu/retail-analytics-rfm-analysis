USE RetailDB;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES;
SELECT TOP 10* FROM RetailDB;
SELECT COUNT(*) FROM RetailDB
-- Step 3 – Check missing Transaction_ID
SELECT COUNT(*) AS Missing_Transaction_ID
FROM RetailDB
WHERE Transaction_ID IS NULL;
-- Step 4 – Delete rows with missing Transaction_ID
DELETE FROM RetailDB
WHERE Transaction_ID IS NULL;
-- Step 5 – Find duplicates based on Transaction_ID
SELECT Transaction_ID, COUNT(*) AS DuplicateCount
FROM RetailDB
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;
-- Step 6 – Remove duplicates using a CTE
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Transaction_ID
               ORDER BY (SELECT NULL)
           ) AS rn
    FROM RetailDB
)
DELETE FROM CTE
WHERE rn > 1;
-- Step 7 – Verify duplicates removed
SELECT Transaction_ID, COUNT(*) AS RemainingCount
FROM RetailDB
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;
--step 8 -remove unwanted columns--

-- Step 9 – Trim Extra Spaces

UPDATE RetailDB
SET 
    
    Product_Category = LTRIM(RTRIM(Product_Category)),
    Product_Brand = LTRIM(RTRIM(Product_Brand)),
    Product_Type =LTRIM(RTRIM(Product_Type))
WHERE 
    Product_Category IS NOT NULL 
    OR Product_Brand IS NOT NULL
    OR Product_Type IS NOT NULL;

-- Step 10 – Standardize Gender Values

UPDATE RetailDB
SET Gender = 'Male'
WHERE LOWER(LTRIM(RTRIM(Gender))) IN ('m','male');

UPDATE RetailDB
SET Gender = 'Female'
WHERE LOWER(LTRIM(RTRIM(Gender))) IN ('f','female');

--Step 11 – Remove Invalid Data

DELETE FROM RetailDB
WHERE 
    (Age IS NOT NULL AND Age <= 0)
    OR (Total_Amount IS NOT NULL AND Total_Amount <= 0);


-- Step 12 – Remove Outliers

DELETE FROM RetailDB
WHERE Total_Amount > 100000;

-- DIMENSION: PRODUCT

SELECT 
    ROW_NUMBER() OVER (ORDER BY Product_Category, Product_Brand) AS Product_ID,
    Product_Category,
    Product_Brand
INTO dim_product
FROM (
    SELECT DISTINCT Product_Category, Product_Brand
    FROM RetailDB
) t;
-- FACT TABLE: SALES (MAP Product_ID)

SELECT
    r.Transaction_ID,
    r.Customer_ID,
    p.Product_ID,
    r.Date,
    r.Total_Purchases,
    r.Total_Amount
INTO fact_sales
FROM RetailDB r
JOIN dim_product p
    ON r.Product_Category = p.Product_Category
   AND r.Product_Brand = p.Product_Brand;
 





