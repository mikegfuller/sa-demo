with 

source as (

    select * from {{ source('lms', 'training') }}

),

renamed as (

    select
        employee_id,
        completed_security,
        completed_harrassment,
        completed_policy_signatures

    from source

)

select * from renamed
