-- depends_on: {{ref('dim_customers')}}

{% set model_name_query %}
    select model_name from mike_fuller_sandbox.control_tables.table_name_test
{% endset %}

{% set results = run_query(model_name_query) %}

{% if execute %} {% set model_name_list = results.columns[0].values() %}
{% else %} {% set model_name_list = [] %}
{% endif %}



{%- for model_name in model_name_list %}
select * from table_name
        {%- if not loop.last %} union all{% endif -%}
        {% endfor %}