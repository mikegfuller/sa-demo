select * from {{ ref('stg_worker') }} 
where hire_date > current_date