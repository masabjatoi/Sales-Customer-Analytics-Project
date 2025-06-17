# 🧠 Sales-Customer-Analytics-Project
This project demonstrates a complete **data warehousing and analytical reporting solution** using **T-SQL**. It includes structured queries for aggregations, segmentations, and performance insights across customers, products, time, and categories. All data resides in a star-schema-based data warehouse.

---

## 📂 Project Overview

This project consists of multiple SQL scripts and views built on top of a structured data warehouse (`DataWarehouse`), with a fact table and several dimension tables, including:

- `gold.fact_sales`
- `gold.dim_products`
- `gold.dim_customers`

Key concepts applied:

- Data aggregation & KPIs
- Customer segmentation
- Product performance classification
- Time series trend analysis
- Window functions for rolling metrics
- Creating reusable views for reporting

---

## 📊 Key Reports & Features

### ✅ 1. **Yearly & Monthly Sales Trends**
- Aggregates total yearly/monthly sales.
- Implements `DATETRUNC` and `SUM()` with window functions for running totals.

### ✅ 2. **Product Performance Dashboard**
- Classifies products into:
  - High Performance
  - Mid Range
  - Low Performance
- Metrics: total sales, avg selling price, product lifespan, recency, and avg monthly revenue.

View created: `gold.report_products`

### ✅ 3. **Customer Segmentation**
- Customers are segmented into:
  - **VIP** (high value, long lifespan)
  - **Regular**
  - **New**
- Calculates total order count, sales, quantity, avg order value, recency, and monthly spend.

View created: `gold.report_customer`

### ✅ 4. **Product Cost Analysis**
- Categorizes products based on cost ranges: `Below 100`, `100-500`, etc.
- Counts product distribution per range using both `GROUP BY` and `WINDOW FUNCTIONS`.

### ✅ 5. **Category Sales Breakdown**
- Analyzes contribution of each category to overall revenue.
- Calculates percentage of total sales using window functions.

---

## 📈 Skills & Concepts Demonstrated

- SQL Aggregations (`SUM`, `COUNT`, `AVG`, `MAX`, `MIN`)
- Time functions (`YEAR`, `MONTH`, `DATEDIFF`, `DATETRUNC`)
- Window Functions (`OVER()`, `PARTITION BY`, `LAG`, `AVG`)
- CTEs (`WITH` statements) for modular queries
- Case-based segmentation and flagging
- View creation for reporting layers
- Data storytelling through KPIs

---


## 🚀 How to Use

1. Ensure you have access to a SQL Server environment with the schema loaded.
2. Execute the `.sql` files in order or independently depending on your analysis needs.
3. Explore the created views `gold.report_customer` and `gold.report_products` for powerful reporting.

---

## 👨‍💻 Author

**Muhammad Masab**  
BS Computer Science | Aspiring Data Scientist  


---

## 📜 License

This project is open-source and available under the MIT License.


