{{ config(materialized='view') }}

-- Silver Products: Deduplicated product reference data
select
    distinct
    product_id,
    product_name,
    case product_id
        when 'P001' then 'Electronics'
        when 'P002' then 'Electronics'
        when 'P003' then 'Accessories'
        when 'P004' then 'Appliances'
        when 'P005' then 'Home'
        when 'P006' then 'Appliances'
        when 'P007' then 'Wearable'
        when 'P008' then 'Appliances'
        when 'P009' then 'Electronics'
        when 'P010' then 'Electronics'
    end as category,
    case product_id
        when 'P001' then 55000
        when 'P002' then 30000
        when 'P003' then 2500
        when 'P004' then 20000
        when 'P005' then 3500
        when 'P006' then 45000
        when 'P007' then 5000
        when 'P008' then 15000
        when 'P009' then 4000
        when 'P010' then 18000
    end as standard_price
from {{ ref('bronze_orders') }}
