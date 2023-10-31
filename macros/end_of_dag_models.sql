{% macro get_all_models() %}  
 {% if execute %}  
  {% for node in graph.nodes.values()  
   | selectattr("resource_type", "equalto", "model") %}  
   
   {% do log(node.unique_id ~ ", materialized: " ~ node.config.materialized, info=true) %}  
   
  {% endfor %}  
 {% endif %}  
{% endmacro %}