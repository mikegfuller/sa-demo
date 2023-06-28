--change

with source as (

    select * from {{ source('pizza_shop', 'pizza_sales') }}

),

renamed as (

    select
        order_details_id as order_details_id,
        order_id as order_id,
        pizza_id as pizza_id,
        quantity as order_quantity,
        order_date as order_date,
        order_time as order_time,
        unit_price as unit_price,
        total_price as total_price,
        pizza_size as pizza_size,
        pizza_category as pizza_category,
        pizza_ingredients as pizza_ingredients,
        pizza_name as pizza_name

    from source

)

select * from renamed