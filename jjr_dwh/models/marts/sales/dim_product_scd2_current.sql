{{ config(materialized='view') }}

-- Current (active) versions only.
select *
from {{ ref('dim_product_scd2') }}
where is_current = 1
