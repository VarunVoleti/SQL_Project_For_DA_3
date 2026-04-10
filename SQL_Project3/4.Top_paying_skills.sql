
/*
what are the top skills based on salary?
- Look at average salary associated with each skill for Data Analyst positions
- Focus on roles with specified salaries, regardless of location
- Why different skills impact salary levels for Data Analysts and help identify
    the most financially rewarding skills to acquire or improve
*/

SELECT sd.skills,  
ROUND(AVG(salary_year_avg),2) as avg_salary
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd ON sjd.job_id = jpf.job_id
INNER JOIN skills_dim as sd ON sd.skill_id = sjd.skill_id
WHERE salary_year_avg IS NOT NULL AND job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
GROUP BY sd.skills
ORDER BY avg_salary DESC
LIMIT 10;
