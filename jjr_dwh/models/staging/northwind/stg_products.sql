{{ config(materialized='view') }}
select
  cast(ProductID as int)        as product_id,
  ProductName                   as product_name,
  cast(UnitPrice as decimal(18,2)) as unit_price
from {{ source('northwind','products') }};
