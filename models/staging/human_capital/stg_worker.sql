with source as (

    select * from {{ source('human_capital', 'worker') }}

),

renamed as (

    select
        employee_id as employee_id,
        hire_date as hire_dt,
        work_address_country as worker_country,
        worker as worker_name,
        worker_documents as worker_docs,
        date_of_birth as date_of_birth,
        workday_id as workday_id,
        _fivetran_deleted as delete_flg,
        _fivetran_synced as update_dt,
        licenses as worker_licenses,
        passports as worker_passports

    from source

)

select * from renamed