{{
    config(
        materialized='table'
    )
}}
select 1 as id, 'grizzly' as bear
union all
select 2 as id, 'polar' as bear
union all
select 3 as id, 'pooh' as bear