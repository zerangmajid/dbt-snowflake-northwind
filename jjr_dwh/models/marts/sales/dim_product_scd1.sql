{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='product_key',
    on_schema_change='append_new_columns'
) }}

-- SCD-1: Always keep the latest state per product_id (no history).
select
  p.product_id   as product_key,
  p.product_name,
  p.unit_price
from {{ ref('stg_products') }} p;
