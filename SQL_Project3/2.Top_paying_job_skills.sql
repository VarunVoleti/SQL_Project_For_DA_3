-- Using WITH keyword convert the below query into a Common Table Expression (CTE) and then select from the CTE to get the same results.

WITH top_paying_jobs AS(

    SELECT 
    jpf.job_id, 
    jpf.job_title, jpf.job_location, 
    jpf.job_schedule_type, 
    jpf.salary_year_avg, jpf.job_posted_date,
    name as company_name
    FROM  job_postings_fact as jpf
        LEFT JOIN company_dim as cd ON cd.company_id = jpf.company_id
    WHERE job_title_short = 'Data Analyst' AND job_location = 'Anywhere' 
    AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    limit 10
)
SELECT tpj.*, sd.skills
FROM top_paying_jobs as tpj
INNER JOIN skills_job_dim as sjd ON tpj.job_id = sjd.job_id
INNER JOIN skills_dim as sd ON sd.skill_id = sjd.skill_id
ORDER BY tpj.salary_year_avg DESC
LIMIT 10
;