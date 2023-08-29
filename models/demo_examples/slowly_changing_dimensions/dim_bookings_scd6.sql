{{
  config(
    materialized = 'table'
    )
}}

select id,
status,
state,
country,
{{ cents_to_dollars('booking_amt',2) }} as booking_usd,
event_dt,
{{ scd2_cols('id', 'event_dt') }},
{{ scd3_cols('status,state', 'id', 'event_dt') }} 
from {{ ref('bookings_snapshot') }}
order by id, event_dt