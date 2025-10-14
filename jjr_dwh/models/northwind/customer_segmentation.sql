{{ config(materialized='view') }}

with cs as (
  select
    c.CustomerID   as customer_id,
    c.CompanyName  as company_name,
    count(o.OrderID) as num_orders,
    sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as total_spent
  from {{ source('northwind','customers') }} c
  left join {{ source('northwind','orders') }} o on c.CustomerID = o.CustomerID
  left join {{ source('northwind','order_details') }} od on o.OrderID = od.OrderID
  group by c.CustomerID, c.CompanyName
)
select *,
  case
    when num_orders >= 10 and total_spent >= 1000 then 'High Value'
    when num_orders >= 5 then 'Mid Value'
    else 'Low Value'
  end as customer_segment
from cs;
