{{ config(materialized='view') }}

select
  o.OrderID     as order_id,
  o.ShipRegion  as ship_region,
  sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as revenue
from {{ source('northwind','orders') }} o
join {{ source('northwind','order_details') }} od on o.OrderID = od.OrderID
group by o.OrderID, o.ShipRegion;
