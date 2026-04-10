
SELECT  count(job_id) as number_of_jobs,
    CASE
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York' THEN 'Local'
    ELSE 'Onsite'
    END as location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;

SELECT salary_year_avg,
    CASE 
    WHEN salary_year_avg <= 50000 THEN 'Low_Salary'
    WHEN salary_year_avg >50000 AND salary_year_avg <= 100000 THEN 'Medium_Salary'
    ELSE 'High_Salary'
    END as salary_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;
