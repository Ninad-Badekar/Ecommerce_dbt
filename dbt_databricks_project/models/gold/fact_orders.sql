{{ config(materialized='table') }}

select
    {{ dbt_utils.generate_surrogate_key(['o.order_id','o.product_id']) }} as fact_order_key,

    o.order_id,
    o.order_date_key,

    dc.customer_key,
    dp.product_key,

    o.quantity,
    o.price as unit_price,
    o.total_amount

from {{ ref('silver_orders') }} o
left join {{ ref('dim_customers') }} dc
    on o.customer_id = dc.customer_id
left join {{ ref('dim_products') }} dp
    on o.product_id = dp.product_id
