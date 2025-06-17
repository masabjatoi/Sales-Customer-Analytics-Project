-- Creates comprehensive product performance view
CREATE VIEW gold.report_products AS 
WITH product_details AS (
    SELECT 
        p.product_name, 
        p.product_key,
        f.sales_quantity,
        p.category, 
        p.subcategory, 
        p.product_cost,
        f.sale_amount,
        f.order_number,
        f.customer_key,
        f.order_date
    FROM gold.dim_products p
    LEFT JOIN gold.fact_sales f
        ON p.product_key = f.product_key 
    WHERE f.sale_amount IS NOT NULL
),
product_aggregation AS (
    SELECT
        product_key,
        product_name,
        category,
        subcategory,
        COUNT(DISTINCT order_number) AS total_orders, 
        SUM(sale_amount) AS total_sale,
        SUM(sales_quantity) AS total_quantity,
        COUNT(DISTINCT customer_key) AS total_customer, 
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS life_span,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS last_order_date,
        ROUND(AVG(CAST(sale_amount AS float)/NULLIF(sales_quantity, 0)), 1) AS avg_selling_price
    FROM product_details 
    GROUP BY product_key, product_name, category, subcategory
)
SELECT 
    product_key,
    product_name, 
    category,
    subcategory,
    total_sale,
    CASE 
        WHEN total_sale > 50000 THEN 'High Performance'
        WHEN total_sale >= 10000 THEN 'Mid Range'
        ELSE 'Low Performance'
    END AS product_segment,
    life_span,
    DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency,
    total_orders, 
    total_quantity,
    total_customer, 
    avg_selling_price,
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE ROUND(CAST(total_sale AS float)/total_orders, 2)
    END AS avg_order_revenue,
    CASE 
        WHEN life_span = 0 THEN 0 
        ELSE total_sale / NULLIF(life_span, 0)
    END AS avg_monthly_revenue
FROM product_aggregation;