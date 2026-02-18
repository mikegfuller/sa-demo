{{ config(
    tags=['test_post_build']
) }}

select * from {{ ref('dim_customers') }}
where customer_key <= 0