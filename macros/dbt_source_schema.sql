{% macro dbt_new_source_schema() %}

{{ env_var('DBT_NEW_SOURCE_SCHEMA') }}
    
{% endmacro %}