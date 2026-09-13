# Marketing and Funnel Analysis

## 📌 Project Overview

This project analyzes **marketing channel performance and customer purchase funnel behavior over a 24-month period (January 2024 – December 2025)** across traffic sources and browsers to evaluate acquisition performance and identify conversion patterns.

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

### 📣 Traffic Source Distribution

A total of **57,935 customers** were identified across **5 traffic sources** during the 2024–2025 analysis period.

The analysis shows an extremely high purchase conversion rate across all traffic sources, with **57,844 customers making a purchase**, resulting in an overall conversion rate of approximately **99.84%**.

The near-uniform conversion rates suggest that traffic source has limited differentiation in purchase behavior within the analyzed dataset.

---

### 📊 Consistent Conversion Across Traffic Sources

Conversion rates were remarkably consistent across all channels, ranging from **99.74% on YouTube** to **99.88% on Email**.

The narrow variation indicates that no single traffic source demonstrates a meaningful conversion advantage at the customer level.

This suggests that channel evaluation should focus not only on conversion rate, but also on **traffic volume, acquisition cost, customer value, and retention**.

---

### 📧 Email as the Dominant Traffic Source

**Email** was the largest traffic source, generating **23,761 customers (41.0% of the total)**, followed by **Adwords with 17,421 customers**.

Together, these two channels accounted for approximately **71.1% of the customer traffic**.

Their large contribution makes Email and Adwords important channels for monitoring **customer acquisition volume and overall marketing efficiency**, even though their conversion rates are similar to other channels.

---

### ▶️ YouTube and Facebook Show Similar Volume

**YouTube and Facebook** generated comparable customer volumes, with approximately **6,600–6,685 customers** each.

Their conversion rates were also highly similar:

* **YouTube — 99.74%**
* **Facebook — 99.79%**

The minimal difference suggests that neither channel has a clear conversion advantage based on the current analysis.

---

### 🔎 Organic Traffic Maintains High Conversion

**Organic** was the smallest traffic source, generating **3,451 customers**.

Despite its lower volume, Organic maintained a **99.77% conversion rate**, comparable with all other channels.

This suggests that Organic traffic is not significantly weaker in terms of purchase behavior and may represent an opportunity to grow acquisition volume through **SEO and organic content strategies**.

---

### 🌐 Browser Performance

**Chrome** dominated customer activity, generating **32,254 product views** and **32,196 purchases**, resulting in a **99.82% conversion rate**.

The high volume was primarily driven by **Email and Adwords traffic**, making Chrome an important browser segment for monitoring customer experience and conversion performance.

---

### 🏆 Highest-Converting Browser × Traffic Source Segments

The highest conversion rates were observed in several browser × traffic source combinations:

* **IE + Facebook — 100%**
* **Other + Organic — 100%**
* **IE + Adwords — 99.91%**

While these segments show slightly higher conversion rates, the differences are very small.

Therefore, they should be evaluated alongside **customer volume** before being prioritized for marketing optimization.

---

### 🛒 Product View → Add to Cart Funnel

The funnel analysis shows **zero drop-off between Product View and Add to Cart**.

All **72,667 sessions with a Product View also progressed to Add to Cart**.

This indicates an unusually strong transition between product browsing and cart activity and suggests that the main funnel friction does not occur at the product-to-cart stage.

---

### 💳 Final Purchase Conversion

The only measurable funnel drop-off occurs between **Add to Cart and Purchase**.

Of the **72,667 sessions reaching Add to Cart, 72,512 proceeded to Purchase**, leaving **155 sessions (0.21%)** without a completed purchase.

This indicates that the checkout stage represents the primary point of friction in the analyzed funnel, although the overall drop-off remains extremely small.

Further analysis could investigate **payment issues, checkout usability, product availability, or cart abandonment behavior**.

---

## 🧮 SQL Techniques Demonstrated

### 1. CTE (Common Table Expression)

Used multiple CTEs to structure traffic-source analysis, customer-level funnel analysis, and session-level funnel progression into logical stages.

```sql id="f6k2p9"
WITH base AS (...),
traffic_summary AS (...)
```

The funnel analysis also uses multiple CTEs to progressively transform event-level data into session-level funnel stages.

---

### 2. Date Filtering with `FORMAT_DATE()`

Restricted the analysis to events occurring during **2024–2025**.

```sql id="m8r3t5"
WHERE FORMAT_DATE('%Y', created_at) IN ('2024', '2025')
```

This ensures that the traffic-source, browser, and funnel analyses use the same analysis period.

---

### 3. Conditional Aggregation with `COUNT(DISTINCT CASE WHEN)`

Used conditional distinct counting to identify customers who completed purchases within each traffic source.

```sql id="v4n7c2"
COUNT(DISTINCT CASE
  WHEN event_type = 'purchase'
  THEN user_id
END) AS total_customer_purchase
```

This prevents the same customer from being counted multiple times within a traffic source.

---

### 4. `CASE WHEN` for Funnel Flags

Created binary indicators to identify whether a session contained each funnel stage.

```sql id="x9p5k1"
CASE
  WHEN event_type = 'product' THEN 1
  ELSE 0
END AS product_flag
```

The same approach was applied to Cart and Purchase events.

---

### 5. `MIN()` for Event Sequence Identification

Used `MIN()` to identify the earliest sequence number for each funnel stage within a session.

```sql id="q3w8m6"
MIN(
  CASE
    WHEN product_flag = 1
    THEN sequence_number
  END
) AS product_sequence
```

This allows the analysis to determine the chronological order in which Product View, Add to Cart, and Purchase occurred.

---

### 6. Sequence-Based Funnel Validation

Compared `sequence_number` values to ensure that funnel stages occurred in the correct order.

```sql id="j7d2r4"
cart_sequence > product_sequence
AND purchase_sequence > cart_sequence
```

This prevents events from being counted as a valid funnel progression when they occurred in the wrong sequence.

---

### 7. Session-Level Aggregation

Grouped event-level records by `session_id` and `user_id` to transform individual events into session-level funnel behavior.

```sql id="b5n9x3"
GROUP BY
  session_id,
  user_id
```

This enables each session to be classified according to the furthest valid stage reached.

---

### 8. Conditional Aggregation with `MAX()`

Used `MAX()` to create customer-level indicators showing whether a customer viewed a product or completed a purchase within a browser × traffic-source combination.

```sql id="c8v4h2"
MAX(CASE
  WHEN event_type = 'product' THEN 1
  ELSE 0
END) AS viewed
```

---

### 9. `COUNTIF()` for Funnel Stage Counting

Used `COUNTIF()` to count sessions reaching each funnel stage.

```sql id="n2m6k8"
COUNTIF(product_flag = 1) AS session_count
```

The same approach was applied to Add to Cart and Purchase stages.

---

### 10. `UNION ALL` for Funnel Output

Combined the three funnel stages into a single result set for visualization and comparison.

```sql id="r5t1v7"
SELECT 'Product View' AS stage, ...
UNION ALL
SELECT 'Add to Cart', ...
UNION ALL
SELECT 'Purchase', ...
```

---

### 11. Ratio & Percentage Calculation

Calculated conversion rates by dividing purchasing customers by customers who viewed products or were exposed to each traffic source.

```sql id="p4x8d2"
ROUND(
  total_customer_purchase / total_customer * 100,
  2
) AS conversion_rate
```

The same calculation approach was used for browser × traffic source conversion analysis.


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
│   └── dashboard.png
└── Output/
    └── Output Query 1.png
    └── Output Query 2.png
    └── Output Query 3.png
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
