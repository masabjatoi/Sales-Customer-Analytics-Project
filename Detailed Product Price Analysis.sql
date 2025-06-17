-- Shows individual products within each price range
WITH product_cost_range AS (
    SELECT 
        product_key,
        product_name,
        product_cost,
        CASE 
            WHEN product_cost < 100 THEN 'Below 100'
            WHEN product_cost BETWEEN 100 AND 500 THEN '100-500'
            WHEN product_cost BETWEEN 500 AND 1000 THEN '500-1000'
            ELSE 'Above 1000'
        END AS cost_range
    FROM gold.dim_products
)
SELECT  
    cost_range, 
    product_name,
    COUNT(*) OVER (PARTITION BY cost_range) AS total_products_in_range
FROM product_cost_range
ORDER BY cost_range, product_name;