-- CTE to calculate weekly metrics
WITH weekly_metrics AS (
  SELECT
    DATE_TRUNC(DATE(oi.created_at), WEEK(MONDAY)) AS week_start,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNTIF(UPPER(oi.status) = 'RETURNED') AS returned_items,
    COUNTIF(UPPER(oi.status) = 'CANCELLED') AS cancelled_items,
    COUNT(DISTINCT oi.user_id) AS unique_customers,
    SUM(oi.sale_price) AS total_revenue,
    SUM(oi.sale_price - ii.cost) AS gross_profit,
    IFNULL(AVG(CASE
      WHEN oi.delivered_at IS NOT NULL THEN TIMESTAMP_DIFF(oi.delivered_at, oi.created_at, DAY)
    END), 0) AS avg_fulfillment_days
  FROM `coursework-ishwari.thelook.order_items` oi
  JOIN `coursework-ishwari.thelook.inventory_items` ii
    ON oi.product_id = ii.product_id
  WHERE oi.created_at IS NOT NULL
  GROUP BY week_start
),

-- CTE to get top brand per week
top_brands AS (
  SELECT
    week_start,
    brand,
    ROW_NUMBER() OVER (PARTITION BY week_start ORDER BY brand_count DESC) AS rn
  FROM (
    SELECT
      DATE_TRUNC(DATE(oi.created_at), WEEK(MONDAY)) AS week_start,
      p.brand,
      COUNT(*) AS brand_count
    FROM `coursework-ishwari.thelook.order_items` oi
    JOIN `coursework-ishwari.thelook.products` p
      ON oi.product_id = p.id
    WHERE oi.created_at IS NOT NULL
    GROUP BY week_start, p.brand
  )
)

-- Final output with join
SELECT
  wm.week_start,
  ROUND(wm.total_revenue, 2) AS revenue,
  wm.total_orders,
  wm.returned_items,
  wm.cancelled_items,
  wm.unique_customers,
  ROUND(SAFE_DIVIDE(wm.total_revenue, wm.total_orders), 2) AS avg_order_value,
  ROUND(wm.gross_profit, 2) AS gross_profit,
  ROUND(wm.avg_fulfillment_days, 2) AS avg_delivery_time_days,
  tb.brand AS top_brand
FROM weekly_metrics wm
LEFT JOIN top_brands tb
  ON wm.week_start = tb.week_start AND tb.rn = 1
ORDER BY wm.week_start;
