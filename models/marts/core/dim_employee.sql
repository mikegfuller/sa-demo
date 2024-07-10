select
    hr.employee_id,
    hr.hire_date,
    hr.work_address_country,
    hr.worker,
    hr.worker_documents,
    hr.date_of_birth,
    hr.system_id,
    hr.is_deleted,
    hr.updated_at,
    hr.licenses,
    hr.passports,
    payroll.position,
    payroll.annual_salary,
    payroll.pct_base_salary,
    payroll.pto_days_taken,
    payroll.pto_days_pending,
    lms.completed_security,
    lms.completed_harrassment,
    lms.completed_policy_signatures
from {{ ref('stg_hr__worker') }} as hr
inner join {{ ref('stg_lms__training') }} as lms
    on hr.employee_id = lms.employee_id
inner join {{ ref('stg_payroll__employee_payroll') }} as payroll
    on hr.employee_id = payroll.employee_id
