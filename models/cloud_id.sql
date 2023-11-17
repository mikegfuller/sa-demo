select {{ env_var("DBT_CLOUD_PROJECT_ID",0) }} as project_id,
{{ env_var("DBT_CLOUD_JOB_ID",0) }} as job_id,
{{ env_var("DBT_CLOUD_RUN_ID",0) }} as run_id
