-- 1: Creating base CTE
WITH order_details AS (
  SELECT
    oi.order_id,
    oi.user_id,
    oi.product_id,
    oi.sale_price,
    oi.created_at,
    oi.delivered_at,
    ii.cost,
    ii.product_distribution_center_id,
    p.brand,
    u.state AS region
  FROM coursework-ishwari.thelook.order_items oi
  JOIN coursework-ishwari.thelook.inventory_items ii
    ON oi.product_id = ii.product_id
  JOIN coursework-ishwari.thelook.products p
    ON oi.product_id = p.id
  JOIN coursework-ishwari.thelook.users u
    ON oi.user_id = u.id
),

-- 2: Getting top brand per region using ROW_NUMBER
top_brand_per_region AS (
  SELECT
    region,
    brand,
    ROW_NUMBER() OVER (PARTITION BY region ORDER BY COUNT(*) DESC) AS rn
  FROM order_details
  GROUP BY region, brand
),

-- 3: Counting number of distribution centers per region
distribution_centers_per_region AS (
  SELECT
    u.state AS region,
    COUNT(DISTINCT ii.product_distribution_center_id) AS num_distribution_centers
  FROM coursework-ishwari.thelook.users u
  JOIN coursework-ishwari.thelook.order_items oi
    ON u.id = oi.user_id
  JOIN coursework-ishwari.thelook.inventory_items ii
    ON oi.product_id = ii.product_id
  GROUP BY u.state
)


-- 4: Final aggregation and join
SELECT
  od.region AS region_name,
  dcr.num_distribution_centers,
  COUNT(DISTINCT od.user_id) AS customer_count,
  COUNT(DISTINCT od.order_id) AS total_orders,
  ROUND(SUM(od.sale_price), 2) AS total_revenue,
  ROUND(SAFE_DIVIDE(SUM(od.sale_price), COUNT(DISTINCT od.order_id)), 2) AS avg_order_value,
  tbr.brand AS top_brand,
  ROUND(SUM(od.sale_price - od.cost), 2) AS gross_profit,
  ROUND(AVG(TIMESTAMP_DIFF(od.delivered_at, od.created_at, DAY)), 2) AS avg_processing_time_days
FROM order_details od
LEFT JOIN top_brand_per_region tbr
  ON od.region = tbr.region AND tbr.rn = 1
LEFT JOIN distribution_centers_per_region dcr
  ON od.region = dcr.region
WHERE od.created_at IS NOT NULL AND od.delivered_at IS NOT NULL
GROUP BY od.region, dcr.num_distribution_centers, tbr.brand
ORDER BY total_revenue DESC;