{% macro scd2_cols(key_field, date_field) %}

   {%- set scd2_logic -%}
        {{date_field}} as eff_from
        ,case when lead({{key_field}}) over(order by {{key_field}},{{date_field}}) = {{key_field}} then lead({{date_field}}) over(order by {{key_field}}) else null end as eff_to
        ,case when lead({{key_field}}) over(order by {{key_field}},{{date_field}}) = {{key_field}} then 'N' else 'Y' end as current_flg      
    {%- endset -%}

{{ return(scd2_logic) }}

{% endmacro %}
