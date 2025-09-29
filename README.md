# Kimia Farma Business Performance Analysis (2020–2023)
**Final Task – Rakamin X Kimia Farma Virtual Internship (Big Data Analytics)**
## Project Overview
This project evaluates Kimia Farma’s business performance from 2020 to 2023 using SQL queries in BigQuery. The goal was to transform raw datasets into a clean, aggregated analysis table for insights on sales, profit, and customer ratings.

## Data Used
Four datasets were imported:

- **Transactions** – Sale details
- **Inventory** – Stock information per branch
- **Branches** – Branch details including city and province
- **Products** – Product details including price

These datasets were merged into a single analysis table containing key metrics such as `nett_sales`, `nett_profit`, discounts, and ratings.

## Problem Statement
The challenge was to process scattered data and create an integrated table to enable analysis of revenue, branch performance, and transaction details.

## Project Details
The analysis table includes the following columns:

- `transaction_id` – Unique transaction ID  
- `date` – Transaction date  
- `branch_id` – Branch ID  
- `branch_name` – Branch name  
- `kota` – City of the branch  
- `provinsi` – Province of the branch  
- `rating_cabang` – Customer rating for the branch  
- `customer_name` – Customer name  
- `product_id` – Product ID  
- `product_name` – Product name  
- `actual_price` – Product price before discount  
- `discount_percentage` – Discount applied on the product  
- `persentase_gross_laba` – Gross profit percentage based on price tiers:  
  - Price ≤ 50,000 → 10%  
  - 50,001–100,000 → 15%  
  - 100,001–300,000 → 20%  
  - 300,001–500,000 → 25%  
  - >500,000 → 30%  
- `nett_sales` – Price after discount  
- `nett_profit` – Profit calculated as `nett_sales * persentase_gross_laba`  
- `rating_transaksi` – Customer rating for the transaction  

## SQL Query Example (Simplified)

```sql
WITH persentase_gross_laba AS (
  SELECT transaction_id,
    CASE 
      WHEN price <= 50000 THEN 0.10
      WHEN price > 50000 AND price <=100000 THEN 0.15
      WHEN price >100000 AND price <=300000 THEN 0.20
      WHEN price > 300000 AND price <=500000 THEN 0.25
      WHEN price > 500000 THEN 0.30
    END AS persentase_gross_laba
  FROM kimia_farma.kf_final_transaction
)

SELECT 
  t.transaction_id, 
  t.date, 
  kc.branch_name,
  p.product_name,
  (t.price - (t.price * t.discount_percentage)) AS nett_sales,
  ((t.price - (t.price * t.discount_percentage))* g.persentase_gross_laba) AS nett_profit
FROM kimia_farma.kf_final_transaction t
JOIN kimia_farma.kf_kantor_cabang kc
  ON t.branch_id = kc.branch_id
JOIN kimia_farma.kf_product p
  ON t.product_id = p.product_id
JOIN persentase_gross_laba g
  ON t.transaction_id = g.transaction_id;
```

## Key Highlights & Takeaways
- Built an integrated analysis table combining multiple datasets (**transactions, branches, products**) in BigQuery.  
- Calculated **nett_sales** and **nett_profit** based on discount and price tiers.  
- Generated all mandatory columns required for reporting and dashboard visualization.  
- Demonstrated practical **Big Data analytics skills**, SQL proficiency, and business insight.  
- The table can be directly used for dashboards, management reporting, or further analysis.

