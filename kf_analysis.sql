CREATE TABLE kimia_farma.kf_analysis AS

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
  kc.branch_id, 
  kc.branch_name, 
  kc.kota, 
  kc.provinsi, 
  kc.rating AS rating_cabang,
  t.customer_name,
  p.product_id,
  p.product_name,
  p.price AS actual_price,
  t.discount_percentage,
  g.persentase_gross_laba,
  (t.price - (t.price * t.discount_percentage)) AS nett_sales,
  ((t.price - (t.price * t.discount_percentage))* g.persentase_gross_laba) AS nett_profit,
  t.rating AS rating_transaksi
FROM kimia_farma.kf_final_transaction t
JOIN kimia_farma.kf_kantor_cabang kc
ON t.branch_id = kc.branch_id
JOIN kimia_farma.kf_product p
ON t.product_id = p.product_id
JOIN persentase_gross_laba g
ON t.transaction_id = g.transaction_id;
