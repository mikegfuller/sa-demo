with 

source as (

    select * from {{ source('payroll', 'employee_payroll') }}

),

renamed as (

    select
        employee_id,
        position,
        annual_salary,
        pct_base_salary,
        pto_days_taken,
        pto_days_pending

    from source

)

select * from renamed
