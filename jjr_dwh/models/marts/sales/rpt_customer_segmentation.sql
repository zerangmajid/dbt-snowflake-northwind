{{ config(materialized='view') }}
with cs as (
  select
    c.customer_id,
    c.company_name,
    count(o.order_id) as num_orders,
    sum(od.unit_price * od.quantity * (1 - od.discount)) as total_spent
  from {{ ref('stg_customers') }} c
  left join {{ ref('stg_orders') }} o on c.customer_id = o.customer_id
  left join {{ ref('stg_order_details') }} od on o.order_id = od.order_id
  group by c.customer_id, c.company_name
)
select *,
  case
    when num_orders >= 10 and total_spent >= 1000 then 'High Value'
    when num_orders >= 5 then 'Mid Value'
    else 'Low Value'
  end as customer_segment
from cs
