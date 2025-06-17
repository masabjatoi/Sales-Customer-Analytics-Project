-- Shows sales percentage by product category
WITH category_sales AS (
    SELECT 
        p.category,
        SUM(f.sale_amount) as total_sale
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p 
        ON f.product_key = p.product_key
    GROUP BY category
)
SELECT 
    category, 
    total_sale,
    SUM(total_sale) OVER() AS overall_sale,
    CONCAT(ROUND((CAST(total_sale AS float)/SUM(total_sale) OVER()) * 100, 2), '%') as percentage_total
FROM category_sales
ORDER BY percentage_total DESC;