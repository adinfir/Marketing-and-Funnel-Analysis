--Traffic_source distribution
WITH base AS (
  SELECT
    traffic_source,
    user_id,
    event_type
  FROM igquery-public-data.thelook_ecommerce.events 
  WHERE event_type != 'cancel'
  AND user_id IS NOT NULL 
  AND FORMAT_DATE('%Y', created_at) IN ('2024', '2025')
),
traffic_summary AS (
  SELECT
    traffic_source,
    COUNT(DISTINCT user_id) as total_customer,
    COUNT(DISTINCT CASE
    WHEN event_type = 'purchase'
    THEN user_id END) as total_customer_purchase
  FROM base
  GROUP BY
    traffic_source
)
SELECT
  traffic_source,
  total_customer,
  total_customer_purchase,
  ROUND(total_customer_purchase / total_customer * 100,2) as conversion_rate
FROM traffic_summary
ORDER BY
total_customer_purchase DESC

