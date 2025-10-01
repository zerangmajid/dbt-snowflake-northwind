{{ config(materialized='view', alias='vw_products') }}

select top (5) ProductID, ProductName
from dbo.Products
order by ProductID;
