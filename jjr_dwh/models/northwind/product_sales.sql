{{ config(materialized='view') }}

select
  p.ProductID   as product_id,
  p.ProductName as product_name,
  o.OrderID     as order_id,
  od.UnitPrice  as unit_price
from {{ source('northwind','orders') }} o
join {{ source('northwind','order_details') }} od on o.OrderID = od.OrderID
join {{ source('northwind','products') }} p on od.ProductID = p.ProductID;
