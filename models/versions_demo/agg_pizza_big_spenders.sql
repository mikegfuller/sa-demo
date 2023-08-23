select
    count(*) as pizzas_bought,
    sum(total_price) as revenue
from {{ ref('pizza_big_spenders', v=2) }}
