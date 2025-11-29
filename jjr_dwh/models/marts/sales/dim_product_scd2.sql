-- {{ config(materialized='table') }}

-- -- One row per product version (validity window)
-- select
--   -- Surrogate key = hash(business key + version start)
--   cast(CONVERT(varchar(64), HASHBYTES('SHA2_256',
--       concat(product_id, '|', convert(varchar(30), dbt_valid_from, 126))
--   ), 2) as varchar(64))  as product_sk,
--   product_id             as product_bk,
--   product_name,
--   unit_price,
--   dbt_valid_from         as valid_from,
--   dbt_valid_to           as valid_to,
--   case when dbt_valid_to is null then 1 else 0 end as is_current
-- from {{ ref('products_snapshot') }};
{{ config(materialized='table') }}

-- One row per product version (validity window)
select
  -- Surrogate key = hash(business key + version start)
  md5(
    product_id || '|' || to_char(dbt_valid_from, 'YYYY-MM-DD"T"HH24:MI:SS')
  )                                     as product_sk,
  product_id                             as product_bk,
  product_name,
  unit_price,
  dbt_valid_from                         as valid_from,
  dbt_valid_to,
  case when dbt_valid_to is null then 1 else 0 end as is_current
from {{ ref('products_snapshot') }}
