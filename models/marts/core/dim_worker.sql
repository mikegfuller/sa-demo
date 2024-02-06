--change

with worker as (

    select * from {{ ref('stg_worker') }}

),

final as (
    select
        employee_id,
        hire_dt,
        worker_country,
        worker_name,
        worker_docs,
        date_of_birth,
        delete_flg,
        update_dt,
        worker_licenses,
        worker_passports,
        year(hire_dt) as hire_year,
        quarter(hire_dt) as hire_quarter,
        month(hire_dt) as hire_month,
        split_part(worker_name, ' ', 1) as worker_first_name,
        split_part(worker_name, ' ', 2) as worker_last_name,
        datediff(year, date_of_birth, current_date) as worker_age,
        new_field
    from
        worker
)

select *
from
    final
order by
    employee_id
