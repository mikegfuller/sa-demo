select * 
from {{ ref('custom_generic_test_model') }}
where id <= 0