{% macro create_udf_addone() %}

use database {{target.database}};

CREATE OR REPLACE FUNCTION {{target.schema}}.addone(i int)
RETURNS INT
LANGUAGE PYTHON
RUNTIME_VERSION = '3.8'
HANDLER = 'addone_py'
as
$$
def addone_py(i):
  return i+1
$$;

{% endmacro %}