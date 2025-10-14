{{ config(
  materialized='incremental',
  unique_key=['order_id','product_id']
) }}
select
  od.order_id,
  od.product_id,
  od.quantity,
  od.unit_price,
  (od.quantity * od.unit_price * (1 - od.discount)) as line_amount
from {{ ref('stg_order_details') }} od
{% if is_incremental() %}
{% endif %}
