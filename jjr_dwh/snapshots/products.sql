{% snapshot products_snapshot %}
{{ config(target_schema='snap', unique_key='product_id', strategy='check', check_cols=['product_name','unit_price']) }}
select
  product_id,
  product_name,
  unit_price
from {{ ref('stg_products') }}
{% endsnapshot %}
