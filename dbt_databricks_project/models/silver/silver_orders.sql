{{ config(materialized='view') }}

-- Silver Orders: Cleaned and enriched order-level data
select
    order_id,
    customer_id,
    product_id,
    (abs(hash(order_id || product_id)) % 3) + 1 as quantity,
    case product_id
        when 'P001' then 55000  -- Laptop
        when 'P002' then 30000  -- Smartphone
        when 'P003' then 2500   -- Headphones
        when 'P004' then 20000  -- Refrigerator
        when 'P005' then 3500   -- Mixer Grinder
        when 'P006' then 45000  -- Air Conditioner
        when 'P007' then 5000   -- Smartwatch
        when 'P008' then 15000  -- Microwave Oven
        when 'P009' then 4000   -- Bluetooth Speaker
        when 'P010' then 18000  -- Tablet
    end as price,

    -- Total amount
    ((abs(hash(order_id || product_id)) % 3) + 1) *
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
    end as total_amount,

    cast(date_format(order_date, 'yyyyMMdd') as int) as order_date_key

from {{ ref('bronze_orders') }}
