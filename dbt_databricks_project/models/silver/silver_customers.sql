{{ config(materialized='view') }}

-- Silver Customers: Deduplicated customer records
select
    distinct
    customer_id,
    customer_name as full_name,
    email
from {{ ref('bronze_orders') }}
