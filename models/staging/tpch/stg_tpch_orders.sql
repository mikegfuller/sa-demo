
with source as (

    select * from {{ source('tpch', 'orders') }}

),

rename as (

    select
    
        o_orderkey as order_key,
        o_custkey as customer_key,
        o_orderstatus as status_code,
        o_totalprice as total_price,
        o_orderdate as order_date,
        o_orderpriority as priority_code,
        o_clerk as clerk_name,
        o_shippriority as ship_priority,
        o_comment as comment

    from source

)

select * from rename

union all

select 
0 as order_key,
0 as customer_key,
'U' as status_code,
0 as total_price,
'1900-01-01' as order_date,
'UNK' as priority_code,
'UNK' as clerk_name,
-1 as ship_priority,
'Unknown' as comment