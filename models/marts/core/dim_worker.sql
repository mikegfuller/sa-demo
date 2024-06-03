--change
--change

with worker as (

    select * from {{ ref('stg_worker') }}

),
final as (
    select 
        employee_id,
        hire_dt,
        year(hire_dt) as hire_year,
        quarter(hire_dt) as hire_quarter,
        month(hire_dt) as hire_month,
        worker_country,
        worker_name,
        split_part(worker_name,' ', 1) as worker_first_name,
        split_part(worker_name,' ', 2) as worker_last_name,
        worker_docs,
        date_of_birth,
        datediff(year, date_of_birth, current_date) as worker_age,
        delete_flg,
        update_dt,
        worker_licenses,
        worker_passports
    from
        worker
)
select 
    *
from
    final
order by
    employee_id