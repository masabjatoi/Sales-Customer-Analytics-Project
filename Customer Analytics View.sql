-- Creates comprehensive customer reporting view
CREATE VIEW gold.report_customer AS
WITH base_query AS (
    SELECT 
        f.order_number, 
        f.product_key,  
        f.order_date,
        f.sale_amount,
        c.customer_key, 
        c.customer_number,
        f.sales_quantity,
        CONCAT(c.first_name, ' ', c.last_name) as customer_name,
        DATEDIFF(year, c.birthdate, GETDATE()) as age
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
        ON f.customer_key = c.customer_key
    WHERE order_date IS NOT NULL
),
customer_aggregation AS (
    SELECT 
        customer_key, 
        customer_number,
        customer_name, 
        age,
        COUNT(DISTINCT order_number) as total_order, 
        SUM(sales_quantity) as total_quantity, 
        SUM(sale_amount) AS total_sale,
        COUNT(DISTINCT product_key) as total_products,
        MAX(order_date) as last_order, 
        DATEDIFF(year, MIN(order_date), MAX(order_date)) as life_span
    FROM base_query
    GROUP BY customer_key, customer_number, customer_name, age
)
SELECT 
    customer_key, 
    customer_number,
    customer_name, 
    age,
    CASE    
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS age_segments,
    CASE 
        WHEN life_span >= 12 AND total_sale > 5000 THEN 'VIP'
        WHEN life_span >= 12 AND total_sale < 5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,
    total_order, 
    total_quantity, 
    total_sale,
    total_products,
    last_order,
    DATEDIFF(month, last_order, GETDATE()) as recency,
    life_span,
    CASE
        WHEN life_span = 0 THEN total_sale
        ELSE total_sale / life_span
    END AS avg_monthly_spend,
    CASE
        WHEN total_order = 0 THEN 0
        ELSE CAST(ROUND(total_sale / total_order, 2) AS float) 
    END AS avg_order_value
FROM customer_aggregation;