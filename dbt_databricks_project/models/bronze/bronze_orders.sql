{{ config(materialized="view") }}

select *
from {{ source('workspace', 'orders') }}
