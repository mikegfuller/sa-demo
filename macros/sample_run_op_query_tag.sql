% macro sample_run_op_query_tag() %}
  {% set query_tag = "test_a_tag"() %}
  {% do run_query("alter session set query_tag = '{}'".format(query_tag)) %}
  {% do run_query("select current_date()") %}
{% endmacro %}