-- Shows customer counts and sales by age groups
SELECT 
    age_segments,
    COUNT(customer_number) as total_customer, 
    SUM(total_sale) as total_sale 
FROM gold.report_customer
GROUP BY age_segments;