-- Rate Purchase by device & browser
WITH base AS (
  SELECT 
    browser,
    traffic_source,
    COUNTIF(event_type = 'product') as total_cust_view,
    COUNTIF(event_type = 'purchase') as total_cust_purchase
  FROM bigquery-public-data.thelook_ecommerce.events
  WHERE user_id IS NOT NULL
  GROUP BY
    browser,
    traffic_source
)

SELECT 
 browser, 
 traffic_source,
 total_cust_view,
 total_cust_purchase,
 ROUND(total_cust_purchase / total_cust_view * 100,2) pct_cust_purchase_per_view
FROM base
ORDER BY total_cust_purchase DESC, total_cust_view ASC