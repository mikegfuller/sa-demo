{% set table_name='dim_customers' %}

select * from {{ref(table_name)}}