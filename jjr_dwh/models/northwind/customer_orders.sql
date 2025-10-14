{{ config(materialized='view') }}

select
  c.CustomerID  as customer_id,
  c.CompanyName as company_name,
  o.OrderID     as order_id,
  od.ProductID  as product_id,
  od.UnitPrice  as unit_price
from {{ source('northwind','customers') }} c
left join {{ source('northwind','orders') }} o on c.CustomerID = o.CustomerID
left join {{ source('northwind','order_details') }} od on o.OrderID   = od.OrderID;
