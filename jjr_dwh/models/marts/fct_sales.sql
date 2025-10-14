{{ config(materialized='view', alias='fct_sales') }}

select
    od.OrderID   as order_id,
    o.CustomerID as customer_id,
    od.ProductID as product_id,
    cast(od.Quantity as int) as quantity,
    cast(od.UnitPrice as decimal(18,4)) as unit_price,
    od.Quantity * od.UnitPrice as total_amount
from {{ source('northwind','order_details') }} od   
join {{ source('northwind','orders') }} o
  on od.OrderID = o.OrderID
