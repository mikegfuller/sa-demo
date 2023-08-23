select * from
{{ ref('stg_pizza_sales') }}
where total_price > 50