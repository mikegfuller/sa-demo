select * from {{ source('sandbox_source', 'test_table') }}
