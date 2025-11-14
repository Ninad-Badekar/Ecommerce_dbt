{{ config(materialized='table') }}

select
    {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_key,
    product_id,
    product_name,
    category,
    standard_price as price
from {{ ref('silver_products') }}
