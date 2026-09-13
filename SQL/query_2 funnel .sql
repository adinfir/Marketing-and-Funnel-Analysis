-- Funnel

WITH base AS (
  SELECT
    session_id,
    user_id,
    sequence_number,
    event_type
  FROM `bigquery-public-data.thelook_ecommerce.events`
  WHERE event_type IN ('product', 'cart', 'purchase')
    AND user_id IS NOT NULL
    AND FORMAT_DATE('%Y', created_at) IN ('2024', '2025')
),
journey AS (
  SELECT
    session_id,
    user_id,
    sequence_number,
    event_type,
    CASE
      WHEN event_type = 'product' THEN 1
      ELSE 0
    END AS product_flag,
    CASE
      WHEN event_type = 'cart' THEN 1
      ELSE 0
    END AS cart_flag,
    CASE
      WHEN event_type = 'purchase' THEN 1
      ELSE 0
    END AS purchase_flag
  FROM base
),
aggregation AS (
  SELECT
    session_id,
    user_id,
    MIN(
      CASE
        WHEN product_flag = 1
        THEN sequence_number
      END
    ) AS product_sequence,
    MIN(
      CASE
        WHEN cart_flag = 1
        THEN sequence_number
      END
    ) AS cart_sequence,
    MIN(
      CASE
        WHEN purchase_flag = 1
        THEN sequence_number
      END
    ) AS purchase_sequence
  FROM journey
  GROUP BY
    session_id,
    user_id
),
funnel AS (
    SELECT
    session_id,
    user_id,

    CASE
      WHEN product_sequence IS NOT NULL
      THEN 1
      ELSE 0
    END AS product_flag,

    CASE
      WHEN product_sequence IS NOT NULL
       AND cart_sequence IS NOT NULL
       AND cart_sequence > product_sequence
      THEN 1
      ELSE 0
    END AS cart_flag,

    CASE
      WHEN product_sequence IS NOT NULL
       AND cart_sequence IS NOT NULL
       AND purchase_sequence IS NOT NULL
       AND cart_sequence > product_sequence
       AND purchase_sequence > cart_sequence
      THEN 1
      ELSE 0
    END AS purchase_flag

  FROM aggregation
)
SELECT
  'Product View' AS stage, 
  COUNTIF(product_flag = 1) AS session_count
FROM funnel
UNION ALL
SELECT 
  'Add to Cart',
  COUNTIF(cart_flag = 1)    
FROM funnel
UNION ALL
SELECT 
  'Purchase',              
  COUNTIF(purchase_flag = 1) 
FROM funnel;