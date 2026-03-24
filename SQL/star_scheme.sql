USE RetailDB
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

--DIM_CUSTOMER--
IF OBJECT_ID('dim_customer', 'U') IS NOT NULL
DROP TABLE IF EXISTS dim_customer;

SELECT 
    Customer_ID,
    MAX(TRY_CAST(Age AS INT)) AS Age
    INTO dim_customer
FROM starscheme
GROUP BY Customer_ID;   
SELECT COUNT(*) FROM dim_customer
--DIM_PRODUCT--
DROP TABLE IF EXISTS dim_product;

SELECT 
    ROW_NUMBER() OVER (ORDER BY Product_Category, Product_Brand) AS Product_ID,
    Product_Category,
    Product_Brand
INTO dim_product
FROM (
    SELECT DISTINCT Product_Category, Product_Brand
    FROM starscheme
) t;
SELECT COUNT(*) FROM dim_product;
SELECT COUNT(DISTINCT Product_Category + Product_Brand)
FROM starscheme;
--FACT_SALES--
DROP TABLE IF EXISTS fact_sales;

SELECT
    TRY_CAST(NULLIF(s.Transaction_ID, 'NULL') AS INT) AS Transaction_ID,
    TRY_CAST(NULLIF(s.Customer_ID, 'NULL') AS INT) AS Customer_ID,
    CAST(p.Product_ID AS INT) AS Product_ID,
    TRY_CONVERT(DATE, NULLIF(s.Order_Date, 'NULL')) AS Order_Date,
    TRY_CAST(NULLIF(s.Quantity, 'NULL') AS INT) AS Quantity,
    TRY_CAST(NULLIF(s.Total_Amount, 'NULL') AS DECIMAL(10,2)) AS Total_Amount
INTO fact_sales
FROM starscheme s
JOIN dim_product p
    ON s.Product_Category = p.Product_Category
   AND s.Product_Brand = p.Product_Brand
WHERE 
    NULLIF(s.Quantity, 'NULL') IS NOT NULL
    AND NULLIF(s.Total_Amount, 'NULL') IS NOT NULL;
--Total_Sales--
SELECT SUM(Total_Amount) AS Total_Sales
FROM fact_sales;
--Total Orders--
SELECT COUNT(*) AS Total_Orders
FROM fact_sales;
--Sales by Product--
SELECT 
    p.Product_Category,
    SUM(f.Total_Amount) AS Total_Sales
FROM fact_sales f
JOIN dim_product p 
    ON f.Product_ID = p.Product_ID
GROUP BY p.Product_Category
ORDER BY Total_Sales DESC;
--Top 5 Products--
SELECT TOP 5
    p.Product_Category,
    p.Product_Brand,
    SUM(f.Total_Amount) AS Sales
FROM fact_sales f
JOIN dim_product p 
    ON f.Product_ID = p.Product_ID
GROUP BY p.Product_Category, p.Product_Brand
ORDER BY Sales DESC;
--Sales by Customer--
SELECT 
    Customer_ID,
    SUM(Total_Amount) AS Total_Spent
FROM fact_sales
GROUP BY Customer_ID
ORDER BY Total_Spent DESC;
--monthly_sales_trend--
SELECT 
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Total_Amount) AS Monthly_Sales
FROM fact_sales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;
--Average Order Value--
SELECT 
    AVG(Total_Amount) AS Avg_Order_Value
FROM fact_sales;
--Top Customers (Top 10)--
SELECT TOP 10
    f.Customer_ID,
    SUM(f.Total_Amount) AS Total_Spent
FROM fact_sales f
GROUP BY f.Customer_ID
ORDER BY Total_Spent DESC;