# Marketing and Funnel Analysis

## 📌 Project Overview

This project analyzes **marketing channel performance and customer purchase funnel behavior** across traffic sources and browsers to evaluate acquisition performance and identify conversion patterns.

The analysis focuses on identifying **traffic source distribution, purchase conversion by traffic source and browser, high-performing channel combinations, and customer movement through the Product View → Add to Cart → Purchase funnel** to support marketing channel evaluation and customer acquisition strategies.

The analysis was conducted using **Google BigQuery (GoogleSQL)** with CTEs, conditional aggregation, `COUNTIF()`, `GROUP BY`, session-level aggregation, and ratio calculations.

---

## 🗂️ Dataset

The analysis uses the **TheLook Ecommerce** public dataset in Google BigQuery.

The analysis uses the following table:

* `events` — event-level customer interaction data containing traffic source, browser, session, and funnel event information

### Key Columns

#### `events`

| Column            | Description                                                              |
| ----------------- | ------------------------------------------------------------------------ |
| `id`              | Unique event identifier                                                  |
| `user_id`         | Unique customer identifier associated with the event                     |
| `sequence_number` | Sequence number indicating the order of events within a customer journey |
| `session_id`      | Unique session identifier                                                |
| `created_at`      | Timestamp when the event occurred                                        |
| `ip_address`      | IP address associated with the event                                     |
| `city`            | City associated with the event                                           |
| `state`           | State associated with the event                                          |
| `postal_code`     | Postal code associated with the event                                    |
| `browser`         | Browser used by the customer                                             |
| `traffic_source`  | Marketing source through which the customer reached the platform         |
| `uri`             | Page or URL associated with the event                                    |
| `event_type`      | Type of customer interaction, such as product view, cart, or purchase    |

### Columns Primarily Used in the Analysis

The analysis primarily uses the following columns from the `events` table:

* `id` — identifies individual customer events
* `user_id` — identifies customers and filters out anonymous events
* `sequence_number` — identifies the order of events within a customer journey
* `session_id` — defines the customer session/journey
* `browser` — analyzes purchase performance by browser
* `traffic_source` — evaluates marketing channel performance
* `event_type` — identifies Product View, Add to Cart, Purchase, and Cancel events

---

## 🔗 Data Relationship

This analysis uses the `events` table as the primary source of customer interaction data.

```text
events
   │
   ├── user_id
   │
   ├── session_id
   │
   ├── traffic_source
   │
   ├── browser
   │
   └── event_type
```

The event-level records are aggregated into **customer sessions and funnel stages** to evaluate marketing channel performance and purchase behavior.

---

## 🛠️ Tools & Technologies

* **Google BigQuery**
* **GoogleSQL**
* CTEs (`WITH`)
* `COUNT()`
* `COUNTIF()`
* `GROUP BY`
* `ROUND()`
* `CASE WHEN`
* Conditional Aggregation
* Session-Level Aggregation
* Funnel Analysis
* Ratio & Percentage Calculations
* Multi-Dimensional Aggregation

---

## 📊 Key Metrics

### Traffic Source Distribution

Measures the number of customer events/sessions associated with each marketing traffic source.

### Purchase Volume

Total number of customer interactions associated with a purchase event.

### Purchase Conversion Rate

Measures the percentage of product-view activity that resulted in a purchase.

```text
Purchase Conversion Rate =
Purchase / Product View × 100
```

### Browser Conversion Rate

Measures purchase performance across different browser and traffic-source combinations.

### Funnel Stage Volume

Measures the number of sessions reaching each stage of the customer journey:

```text
Product View
      ↓
Add to Cart
      ↓
Purchase
```

### Traffic Source Contribution

Measures the relative contribution of each marketing source to overall customer traffic and purchase activity.

---

## 📈 Insight

### 🌐 Overall Traffic & Purchase Performance

A total of **1,301,736 customer sessions** were recorded across **5 traffic sources**, generating **181,322 purchases** at an overall conversion rate of approximately **13.93%**.

This provides a broad view of acquisition volume and purchase activity across the marketing channel mix.

---

### 📊 Highly Consistent Conversion Across Traffic Sources

Conversion rates were remarkably consistent across all major traffic sources, ranging from approximately:

* **Organic — 13.90%**
* **Facebook — 13.91%**
* **Adwords — ~13.9%**
* **Email — ~13.9%**
* **YouTube — 13.99%**

The narrow conversion range suggests that **traffic source does not significantly differentiate purchase intent at this level of analysis**.

Therefore, channel evaluation should consider not only conversion rate but also **traffic volume, acquisition cost, customer quality, and long-term customer value**.

---

### 📧 Email as the Dominant Traffic Source

**Email** was the largest traffic source with approximately **588,341 sessions**, representing around **45.2% of total traffic**.

**Adwords** followed with approximately **389,939 sessions**.

Together, Email and Adwords generated **more than 75% of total traffic**.

This indicates that these two channels are particularly important contributors to overall customer acquisition volume.

---

### ▶️ YouTube & Facebook

**YouTube** and **Facebook** contributed relatively similar traffic volumes, with approximately **129K sessions each**.

However, YouTube achieved a slightly higher conversion rate of **13.99%**, compared with approximately **13.91% for Facebook**.

Although the difference is small, YouTube demonstrates slightly stronger purchase efficiency within the analyzed dataset.

---

### 🔎 Organic Traffic

**Organic** was the smallest traffic source with approximately **65,085 sessions**.

Despite its lower volume, Organic traffic maintained a conversion rate close to the other channels.

This suggests that Organic visitors may still represent a **consistent source of purchase intent**, despite contributing a smaller share of overall traffic.

---

### 🌐 Browser Performance

**Chrome** dominated browser activity with approximately **172,354 product views and 90,756 purchases** in the analyzed browser × traffic-source data.

Its high activity volume was driven primarily by **Email and Adwords traffic**.

This indicates that Chrome represents the largest browser environment in the dataset and should be considered when monitoring website experience and conversion performance.

---

### 🏆 Highest-Converting Browser × Traffic Source Combinations

Several browser and traffic-source combinations showed notably higher conversion rates:

| Rank | Browser × Traffic Source | Conversion Rate |
| ---: | ------------------------ | --------------: |
|    1 | Safari + Facebook        |          53.56% |
|    2 | IE + YouTube             |          53.42% |
|    3 | IE + Facebook            |          53.40% |

These segments show substantially higher conversion rates than the overall traffic-source average.

However, because these are **niche browser × source combinations**, their relatively high rates may be influenced by smaller sample sizes.

Further volume validation should therefore be performed before making significant marketing decisions.

---

### 🛒 Purchase Funnel Behavior

The funnel analysis evaluates customer sessions across:

```text
Product View
      ↓
Add to Cart
      ↓
Purchase
```

The analyzed data shows that **all 181,322 sessions reaching Product View also reached Add to Cart and Purchase**, resulting in effectively **zero funnel drop-off**.

This means the dataset does not provide a realistic representation of gradual customer conversion behavior.

Therefore, **traditional funnel drop-off analysis is not applicable to this synthetic event structure**.

For real-world conversion analysis, the same methodology should be applied to production event data where customers can enter and exit the funnel at different stages.

---

### ⚠️ Synthetic Funnel Data Limitation

The absence of funnel drop-off is an important data-quality limitation.

A realistic ecommerce funnel would typically show:

```text
Product View
      ↓
   Drop-off
      ↓
Add to Cart
      ↓
   Drop-off
      ↓
Purchase
```

Because the current dataset records identical session counts across the funnel stages, metrics such as:

* Product View → Add to Cart conversion
* Add to Cart → Purchase conversion
* Overall funnel conversion
* Funnel abandonment rate

cannot be reliably interpreted from this analysis.

This limitation should be clearly communicated when presenting the analysis.

---

## 🧮 SQL Techniques Demonstrated

This project demonstrates practical SQL techniques commonly used in Data Analyst workflows.

### CTE

CTEs were used to separate the preparation and aggregation stages of the funnel analysis.

```sql
WITH base AS (
    SELECT
        id,
        user_id,
        sequence_number,
        event_type,
        session_id,
        CASE
            WHEN sequence_number = 1 THEN 1
            ELSE 0
        END AS journey_start,
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
    FROM `bigquery-public-data.thelook_ecommerce.events`
    WHERE event_type != 'cancel'
)
```

This approach makes the funnel logic easier to organize and maintain.

### CASE WHEN

`CASE WHEN` was used to create binary flags for each funnel stage.

```sql
CASE
    WHEN event_type = 'product' THEN 1
    ELSE 0
END AS product_flag
```

Similar flags were created for Add to Cart and Purchase events.

These flags allow event-level data to be transformed into session-level funnel indicators.

### COUNTIF

`COUNTIF()` was used to count customers or events satisfying a specific condition.

For example:

```sql
COUNTIF(event_type = 'purchase')
```

This allows purchase activity to be counted directly without requiring a separate filter.

### Conditional Aggregation

Conditional aggregation was used to calculate product views and purchases within the same grouped dataset.

```sql
COUNTIF(event_type = 'product') AS total_cust_view,
COUNTIF(event_type = 'purchase') AS total_cust_purchase
```

This makes it possible to calculate conversion rates by browser and traffic source.

### Session-Level Aggregation

The event-level records were aggregated by:

```sql
user_id,
journey_id
```

and `MAX()` was used to determine whether each session reached a particular funnel stage.

```sql
MAX(product_flag) AS product_flag,
MAX(cart_flag) AS cart_flag,
MAX(purchase_flag) AS purchase_flag
```

This prevents multiple events within the same session from being counted as separate funnel journeys.

### UNION ALL

`UNION ALL` was used to transform funnel stages into a single vertical result.

```sql
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
FROM aggregation
```

This produces a simple funnel structure that can be visualized in a dashboard.

### Ratio Calculation

Purchase conversion rate was calculated by comparing purchases against product views.

```sql
ROUND(
    total_cust_purchase / total_cust_view * 100,
    2
) AS pct_cust_purchase_per_view
```

This metric enables comparison between browser and traffic-source combinations.

---

## 📁 Project Structure

```text
Marketing-and-Funnel-Analysis/
│
├── README.md
│
├── sql/
│   └── query_1 traffic source.sql
│   └── query_2 funnel.sql
│   └── query_3 rate purchase view by device and traffic.sql
│
├── images/
│   ├── Preview Table events the_look ecommerce.jpeg
│
└── dashboard/
│   └── dashboard.jpeg
└── Output/
    └── Output Query 1.jpeg
    └── Output Query 2.jpeg
    └── Output Query 3.jpeg
```

> The project uses the public TheLook Ecommerce dataset available through Google BigQuery. No private customer transaction data is included in this repository.

---

## 🚀 Future Analysis

This analysis can be extended with additional marketing and customer journey analytics such as:

* Traffic Source ROI Analysis
* Customer Acquisition Cost (CAC)
* Customer Lifetime Value by Traffic Source
* Conversion Rate by Traffic Source
* Conversion Rate by Device
* Conversion Rate by Browser
* Landing Page Performance
* Product View → Add to Cart Conversion
* Add to Cart → Purchase Conversion
* Funnel Drop-Off Analysis
* Session-Level Customer Journey Analysis
* First-Touch Attribution
* Last-Touch Attribution
* Multi-Touch Attribution
* Marketing Channel Performance by Country
* Marketing Channel Performance by Customer Segment
* New vs. Returning Customer Conversion
* Customer Acquisition by Traffic Source
* Repeat Purchase Rate by Traffic Source
* Customer Retention by Acquisition Channel
* Campaign Performance Analysis
* Organic vs. Paid Traffic Performance
* Cross-Channel Customer Journey Analysis
* Personalized Marketing Targeting
* Marketing Budget Optimization

These additional analyses would provide a deeper understanding of **marketing channel effectiveness, customer acquisition quality, conversion behavior, and customer journey performance**, helping businesses optimize marketing spend, improve conversion rates, and develop more effective customer acquisition and retention strategies.

---

## 👤 Author

[Curriculum Vitae](https://drive.google.com/file/d/1Sf1mfTCJu-IcL2qFh0gElmXqYrTEsl3b/view?usp=sharing) | [Portfolio](https://public.tableau.com/app/profile/adin4572/vizzes)

**Adient Fir**

Data Analyst Portfolio Project

**Focus:** SQL | Marketing Analytics | Funnel Analysis | BigQuery
