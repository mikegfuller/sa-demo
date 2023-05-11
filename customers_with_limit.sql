{{
    config(
        materialized='table_with_limit'
    )
}}

select * from {{ ref('stg_tpch_customers') }}