{% snapshot bookings_snapshot %}

{{
    config(
      target_database='WATERS_WORKSPACE_DEV',
      target_schema='sa_demo_snapshots',
      unique_key='id',
      strategy='timestamp',
      updated_at='event_dt',
    )
}}

select * from {{ source('scd_demo', 'bookings') }}

{% endsnapshot %}