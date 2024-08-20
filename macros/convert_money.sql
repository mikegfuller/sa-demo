{% macro money(col) -%}
{{ col }}::decimal(16,3)
{%- endmacro %}


