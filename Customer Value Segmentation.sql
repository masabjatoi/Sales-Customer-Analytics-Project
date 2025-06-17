-- Classifies customers by spending and tenure
WITH customer_data AS (
    SELECT 
        c.customer_key, 
        SUM(f.sale_amount) as total_sale, 
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) as total_month,
        CASE 
            WHEN DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) >= 12 AND SUM(f.sale_amount) > 5000 THEN 'VIP'
            WHEN DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) >= 12 AND SUM(f.sale_amount) < 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
        ON f.customer_key = c.customer_key
    GROUP BY c.customer_key
)
SELECT 
    customer_segment, 
    COUNT(*) AS total_customers
FROM customer_data
GROUP BY customer_segment
ORDER BY total_customers DESC;