-- {{ config(materialized='view') }}
-- select
--   cast(OrderID as int)       as order_id,
--   cast(ProductID as int)     as product_id,
--   cast(UnitPrice as decimal(18,2)) as unit_price,
--   cast(Quantity as int)      as quantity,
--   cast(Discount as decimal(5,2)) as discount
-- from {{ source('northwind','order_details') }}

{{ config(materialized='view') }}

select
  cast({{ nw_col('OrderID') }}   as int)           as order_id,
  cast({{ nw_col('ProductID') }} as int)           as product_id,
  cast({{ nw_col('UnitPrice') }} as decimal(18,2)) as unit_price,
  cast({{ nw_col('Quantity') }}  as int)           as quantity,
  cast({{ nw_col('Discount') }}  as decimal(5,2))  as discount
from {{ source('northwind','order_details') }}
