
{% set ingredients_query %}
    select trim(l.value) as ingredient
    from
        {{ ref('stg_pizza_sales') }} pizza_sales,
        lateral split_to_table(pizza_sales.pizza_ingredients, ',') as l
    group by trim(l.value)
    order by ingredient
{% endset %}

{% set results = run_query(ingredients_query) %}

{% if execute %} {% set ingredients_list = results.columns[0].values() %}
{% else %} {% set ingredients_list = [] %}
{% endif %}


with
    pizza_sales as (select * from {{ ref('stg_pizza_sales') }}),

    ingredients_bool as (
    select 
        order_details_id,
        {%- for ingredient in ingredients_list %}
        contains(
            collate(pizza_ingredients, 'en-ci'), '{{ingredient}}'
        ) as has_{{ ingredient.replace(" ", "_").replace('-','_') | lower }}
        {%- if not loop.last %},{% endif -%}
        {% endfor %}

        from pizza_sales
    ),

    final as (

        select
            --pizza_sales.order_details_id,
            pizza_sales.order_id,
            pizza_sales.pizza_id,
            pizza_sales.order_quantity,
            pizza_sales.order_date,
            pizza_sales.order_time,
            pizza_sales.unit_price,
            pizza_sales.total_price,
            pizza_sales.pizza_size,
            pizza_sales.pizza_category,
            pizza_sales.pizza_ingredients,
            pizza_sales.pizza_name,
            ingredients_bool.*
        from pizza_sales
        join
            ingredients_bool
            on pizza_sales.order_details_id = ingredients_bool.order_details_id
    )

select *
from final
