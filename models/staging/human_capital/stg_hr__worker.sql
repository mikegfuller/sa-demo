with 

source as (

    select * from {{ source('hr', 'worker') }}

),

renamed as (

    select
        employee_id,
        hire_date,
        work_address_country,
        worker,
        worker_documents,
        date_of_birth,
        system_id,
        is_deleted,
        updated_at,
        licenses,
        passports

    from source

)

select * from renamed
