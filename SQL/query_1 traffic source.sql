--Traffic_source distribution
SELECT
  traffic_source,
  COUNT(user_id) as total_cust,
  COUNTIF(event_type = 'purchase') as total_cust_purchase,
  ROUND(COUNTIF(event_type = 'purchase') / COUNT(user_id)*100,2) as pct
FROM bigquery-public-data.thelook_ecommerce.events 
WHERE event_type != 'cancel'
GROUP BY
  traffic_source
