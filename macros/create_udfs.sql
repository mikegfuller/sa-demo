{% macro create_udfs() %}

{% do run_query(create_area_of_circle()) %}
{% do run_query(create_udf_addone()) %}

{% endmacro %}