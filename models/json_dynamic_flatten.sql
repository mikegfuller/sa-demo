{{
 config(
  materialized = 'view'
 )
}}

select 
{{ generate_flatten_json(model_name = 'json_unpack_test',json_column = 'v') }}
from {{ ref('json_unpack_test') }}