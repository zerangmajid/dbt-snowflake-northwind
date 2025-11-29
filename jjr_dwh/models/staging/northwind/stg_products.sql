-- {{ config(materialized='view') }}
-- select
--   cast(ProductID as int)        as product_id,
--   ProductName                   as product_name,
--   cast(UnitPrice as decimal(18,2)) as unit_price
-- from {{ source('northwind','products') }}


{{ config(materialized='view') }}

select
  cast({{ nw_col('ProductID') }}     as int)           as product_id,
  {{ nw_col('ProductName') }}                       as product_name,
  cast({{ nw_col('SupplierID') }}   as int)           as supplier_id,
  cast({{ nw_col('CategoryID') }}   as int)           as category_id,
  {{ nw_col('QuantityPerUnit') }}                  as quantity_per_unit,
  cast({{ nw_col('UnitPrice') }}    as decimal(18,2)) as unit_price,
  cast({{ nw_col('UnitsInStock') }} as int)           as units_in_stock,
  cast({{ nw_col('UnitsOnOrder') }} as int)           as units_on_order,
  cast({{ nw_col('ReorderLevel') }} as int)           as reorder_level,
  {{ nw_col('Discontinued') }}                     as discontinued
from {{ source('northwind','products') }}
