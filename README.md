# Jaffle Shop — Customer Lifetime Value Analysis

## Analytics Question
**Who are our highest value customers, and what are they buying?**

Supporting questions:
- Does product type (jaffle vs beverage) predict customer lifetime value?
- Are cross-category buyers worth more than single-category buyers?
- Which products drive the most order volume vs revenue?

---

## Key Findings

**1. Product type drives lifetime value**
Jaffle customers are worth 56% more than beverage customers ($82.74 vs $52.97) despite ordering less than half as often (3.1 vs 5.7 orders avg). High value comes from order size, not frequency.

**2. Cross-category buyers are the most valuable segment**
Customers who buy both jaffles and beverages are worth 81% more than beverage-only customers ($73.05 vs $40.38). No customer buys jaffles without also buying beverages — beverages are the entry point, jaffles are the upgrade.

**3. 95% of customers have never tried a jaffle**
Only 63 of 128 customers have purchased a jaffle. The 65 beverage-only customers represent a significant untapped revenue opportunity.

---

## Actionable Next Steps
1. Run a jaffle trial promotion targeting the 65 beverage-only customers
2. Track cross-category conversion rate over time as a core retention metric
3. Monitor whether the value gap holds across stores and seasons as data grows

---

## Project Structure
models/
├── staging/        # Cleaned 1:1 source models
├── intermediate/   # Pre-joined tables for mart consumption
└── marts/          # Business-ready models answering the analytics question
analyses/           # Exploratory SQL queries used to generate insights
seeds/              # Raw CSV data loaded into BigQuery

---

## Models

| Layer | Model | Description |
|-------|-------|-------------|
| Staging | stg_customers | Cleaned customer IDs and names |
| Staging | stg_orders | Orders with timestamps, store, and dollar amounts |
| Staging | stg_items | Line items linking orders to products |
| Staging | stg_products | Products with type, price, description |
| Staging | stg_stores | Stores with location and tax rate |
| Staging | stg_supplies | Supply costs and perishability |
| Intermediate | int_customer_orders_products | Orders joined with items and products |
| Marts | fct_customer_lifetime_value | Customer lifetime spend, order behaviour, and favourite product type |

---

## Tests
15 tests total, all passing:
- `unique` + `not_null` on all source PKs
- `unique` + `not_null` on `customer_id` in mart
- `not_null` on `total_orders`
- `accepted_values` on `favourite_product_type`

---

## Quickstart
```bash
dbt deps
dbt seed
dbt build
```

---

## Requirements Checklist
- [x] Primary + supporting analytics questions defined
- [x] `fct_*` model built and connected to the question
- [x] Schema tests for all PKs (unique, not_null)
- [x] Business logic test (accepted_values)
- [x] Model and column descriptions added
- [x] `dbt build` passing clean
- [x] Insights with data evidence and actionable next steps in README