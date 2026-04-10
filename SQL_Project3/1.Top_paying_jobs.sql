
/*
Questions that I am answering in the SQL project
 - What are top paying jobs for my role?
 - What are the skills required for the top paying jobs for my role?
 - What are most in demand skills for my role?
 - What are the top skills based on salary for my role?
 - What are most optimal skills to learn?
*/

/*
Q1. Top paying jobs
a. Identify top 10 high paying jobs as a data analyst that are available remotely
b. Focus on job posting with specified salaries
c. highlight top paying opportunities for data analysts, offering insights
*/


SELECT 
jpf.job_id, jpf.job_title, jpf.job_location, jpf.job_schedule_type, jpf.salary_year_avg, jpf.job_posted_date,
name as company_name
FROM  job_postings_fact as jpf
    LEFT JOIN company_dim as cd ON cd.company_id = jpf.company_id
WHERE job_title_short = 'Data Analyst' AND job_location = 'Anywhere' 
AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
limit 10;