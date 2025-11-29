-- {{ config(materialized='view') }}
-- select
--   CustomerID   as customer_id, 
--   CompanyName                as company_name,
--   Country                    as country,
--   Region                     as region
-- from {{ source('northwind','customers') }}

{{ config(materialized='view') }}

select
  {{ nw_col('CustomerID') }}  as customer_id, 
  {{ nw_col('CompanyName') }} as company_name,
  {{ nw_col('Country') }}     as country,
  {{ nw_col('Region') }}      as region
from {{ source('northwind','customers') }}
