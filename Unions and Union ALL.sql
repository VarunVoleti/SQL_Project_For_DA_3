
SELECT all_jobs.job_title_short,
        all_jobs.job_location,
        all_jobs.job_via,
        all_jobs.job_posted_date::date,
        all_jobs.salary_year_avg
FROM 
(

    SELECT *
        FROM january_jobs

    UNION ALL

    SELECT *
    FROM february_jobs

    UNION ALL

    SELECT *
    FROM march_jobs
)   AS all_jobs
WHERE all_jobs.salary_year_avg >= 70000 AND all_jobs.job_title_short = 'Data Analyst';
