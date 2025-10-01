{{ config(materialized='view') }}

select
  ProductID   as product_id,
  ProductName as product_name,
  CategoryID  as category_id,
  UnitPrice   as unit_price
from {{ source('northwind', 'products') }}
