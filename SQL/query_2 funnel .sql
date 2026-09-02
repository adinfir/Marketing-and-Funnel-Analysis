-- Funnel

WITH base AS (
  SELECT
    id,
    user_id,
    sequence_number,
    event_type,
    session_id,
    CASE WHEN sequence_number = 1 THEN 1 ELSE 0 
    END as journey_start,
    CASE WHEN event_type = 'product' THEN 1 ELSE 0 
    END as product_flag,
    CASE WHEN event_type = 'cart' THEN 1 ELSE 0 
    END as cart_flag,
    CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 
    END as purchase_flag 
  FROM bigquery-public-data.thelook_ecommerce.events 
  WHERE event_type != 'cancel'
),
journey AS (
  SELECT
    id,
    user_id,
    sequence_number,
    event_type,
    journey_start,
    product_flag,
    cart_flag,
    purchase_flag,
    session_id as journey_id
  FROM base
  WHERE user_id IS NOT NULL
),
aggregation AS (
  SELECT
    user_id,
    journey_id,
    MAX(product_flag) as product_flag,
    MAX(cart_flag) as cart_flag,
    MAX(purchase_flag) as purchase_flag
  FROM journey
  GROUP BY
    user_id,
    journey_id
)
SELECT
  'Product View' AS stage, 
  COUNTIF(product_flag = 1) AS session_count
FROM aggregation
UNION ALL
SELECT 
  'Add to Cart',
  COUNTIF(cart_flag = 1)    
FROM aggregation
UNION ALL
SELECT 
  'Purchase',              
  COUNTIF(purchase_flag = 1) 
FROM aggregation;