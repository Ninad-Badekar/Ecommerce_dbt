# Ecommerce Analytics — DBT + Databricks Project

This project implements a complete Bronze → Silver → Gold data pipeline on Databricks using dbt (Data Build Tool).
It transforms raw ecommerce order data into a clean star-schema (dimensions & fact) ready for BI dashboards and analytics.

# Project Overview

This dbt project loads raw orders data from a Databricks Volume (Unity Catalog), cleans and enriches it, and builds:

- **Bronze Layer (Raw)**
- **Silver Layer (Cleaned & Modeled)**
- **Gold Layer (Dimensional Warehouse)**

The final output is:
- dim_customers
- dim_products
- fact_orders (granular fact table with surrogate keys)
- Optional future: dim_date, metrics layer, Superset dashboards

# Architecture
```bash
Databricks Volume → Bronze → Silver → Gold → BI Layer
```

## Bronze Layer

- Raw ingested data

- Contains one table: bronze_orders

## Silver Layer

- Cleansed, standardized version of orders, customers, products

- Adds:

    - quantity

    - unit price

    - total amount

    - date_key

Tables:

- silver_orders

- silver_customers

- silver_products

# Gold Layer

Star-schema for analytics:

- dim_customers (with surrogate keys)

- dim_products (with surrogate keys)

- fact_orders (single row per product per order)

Surrogate Key Strategy

Surrogate keys are generated using dbt_utils.generate_surrogate_key.

```sql
Examples:

{{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key
{{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_key
{{ dbt_utils.generate_surrogate_key(['o.order_id','o.product_id']) }} as fact_order_key
```

These keys ensure:

- Stable dimension keys

- Proper fact-to-dimension joining

- Support for slowly changing dimensions (SCDs)

# Testing Strategy (DBT 1.8)

The project uses data_tests following dbt 1.8 standards.

Tests include:

- unique

- not_null

- relationships (FK integrity)

- expression_is_true (numeric validations)

- dbt_utils.unique_combination_of_columns

This ensures high data quality throughout the pipeline.

# Documentation

All models have detailed descriptions in YAML files covering:

- Purpose

- Column definitions

- Business meaning

- Data lineage (bronze → silver → gold)

Run documentation locally:
```bash
dbt docs generate
dbt docs serve
```
# Setup Instructions

## 1. Configure profiles.yml

Your Databricks profile should look like:
```yaml
dbt_project:
  outputs:
    dev:
      type: databricks
      catalog: dbt_project
      schema: bakehouse
      host: <your-host>
      http_path: <warehouse-path>
      token: <your-token>
      threads: 3
  target: dev
```
## 2. Install dependencies
```bash
dbt deps
```
## 3. Run the full pipeline
```bash
dbt run
```
## 4. Run tests
```bash
dbt test
```

# Project Structure
```sql
.
├── models/
│   ├── bronze/
│   │   └── bronze_orders.sql
│   ├── silver/
│   │   ├── silver_orders.sql
│   │   ├── silver_customers.sql
│   │   └── silver_products.sql
│   ├── gold/
│   │   ├── dim_customers.sql
│   │   ├── dim_products.sql
│   │   └── fact_orders.sql
│   └── schema.yml (tests + docs)
├── seeds/
├── dbt_project.yml
└── README.md
```

# Data Model Diagram
```scss
     dim_customers        dim_products
        (PK)                 (PK)
       customer_key        product_key
            │                 │
            └──────┬──────────┘
                   │
               fact_orders
               (order grain)
```

# Analytics Use Cases

With this star schema, you can build dashboards for:

- Daily/Monthly Revenue

- Product Sales Trends

- Customer Segmentation

- Customer Lifetime Value (CLV)

- Sales by Category

- Profitability Analysis

Integrates smoothly with:

- Apache Superset

- Power BI

- Tableau

# Future Enhancements

- Add dim_date

- Add SCD Type 2 support

- Add metrics using dbt metrics or MetricFlow

- Add CI pipeline (GitHub Actions)

- Add performance optimizations for Databricks