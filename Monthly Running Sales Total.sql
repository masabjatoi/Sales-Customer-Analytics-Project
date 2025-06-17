-- Shows monthly sales with cumulative running totals
SELECT 
    order_date, 
    total_amount, 
    SUM(total_amount) OVER (ORDER BY order_date) AS running_sales_total
FROM (
    SELECT 
        DATETRUNC(month, order_date) AS order_date,
        CAST(SUM(sale_amount) AS INT) AS total_amount
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(month, order_date)
) t
ORDER BY order_date;