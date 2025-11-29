-- {{ config(materialized='view') }}
-- select
--   cast(OrderID as int)       as order_id,
--   CustomerID    as customer_id,
--   cast(OrderDate as datetime) as order_date,
--   ShipRegion                 as ship_region
-- from {{ source('northwind','orders') }}


{{ config(materialized='view') }}

select
  cast({{ nw_col('OrderID') }}    as int)      as order_id,
  {{ nw_col('CustomerID') }}                  as customer_id,
  cast({{ nw_col('OrderDate') }} as datetime) as order_date,
  {{ nw_col('ShipRegion') }}                  as ship_region
from {{ source('northwind','orders') }}
