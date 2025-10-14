{{ config(materialized='view') }}
select
  cast(OrderID as int)       as order_id,
  CustomerID    as customer_id,
  cast(OrderDate as datetime) as order_date,
  ShipRegion                 as ship_region
from {{ source('northwind','orders') }};
