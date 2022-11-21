select * from {{ ref('stg_worker') }} 
where hire_dt > current_date