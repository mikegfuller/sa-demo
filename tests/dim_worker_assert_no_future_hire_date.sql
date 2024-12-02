select * from {{ ref('dim_worker') }} 
where hire_dt > current_date