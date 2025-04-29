--test
select distinct
    pizza_id,
    pizza_category
from {{ ref('stg_pizza_sales') }}
order by pizza_id
