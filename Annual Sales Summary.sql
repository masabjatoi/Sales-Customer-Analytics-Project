USE DataWarehouse;

-- Calculates total sales by year, ordered by sales amount
SELECT 
    DATETRUNC(YEAR, order_date) as yearly, 
    CAST(SUM(sale_amount) AS INT) AS Total_amount
FROM gold.fact_sales
WHERE DATETRUNC(YEAR, order_date) IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date) 
ORDER BY SUM(sale_amount);