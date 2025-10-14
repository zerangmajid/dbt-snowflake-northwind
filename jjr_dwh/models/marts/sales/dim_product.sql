{{ config(materialized='table') }}
select
  product_id   as product_key,
  product_name,
  unit_price
from {{ ref('stg_products') }};
