{{ config(materialized='view') }}
select
  CustomerID   as customer_id, 
  CompanyName                as company_name,
  Country                    as country,
  Region                     as region
from {{ source('northwind','customers') }};
