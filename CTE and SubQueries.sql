
SELECT *
FROM (--sub_query starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) =1
    ) AS january_jobs;
    -- SubQuery ends here

WITH january_jobs AS ( -- CTE starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) =1
    ) -- CTE ends here

    SELECT *
    FROM january_jobs;

SELECT company_id, name as company_name
FROM company_dim
WHERE company_id IN(

    SELECT company_id
    FROM job_postings_fact
    WHERE job_no_degree_mention = TRUE
                    );

WITH company_job_count AS (

    SELECT company_id, count(*) as total_jobs
    FROM job_postings_fact
    Group BY company_id
    )
SELECT company_dim.name AS company_name,
         company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC
;

SELECT *
FROM company_dim
LimIT 50;

SELECT *
FROM (
SELECT skd.skill_id,count(*), skd.skills
FROM skills_dim AS skd
LEFT JOIN skills_job_dim as skjd ON skjd.skill_id = skd.skill_id
Group  by   skd.skill_id, skd.skills
order by  count(*) desc
LimIT 5
) AS Top_Skills;

SELECT company_id, name, count(company_id) as total_jobs
FROM  company_dim
GROUP BY company_id
order by count(name) desc
;

WITH remote_job_skills AS (
    SELECT skill_id,count(*)as skill_count
    FROM skills_job_dim as sjd
    INNER JOIN job_postings_fact as sd on sd.job_id =  sjd.job_id
    where sd.job_work_from_home = TRUE
    GROUP BY  skill_id
    limit 
)
SELECT skd.skill_id, skd.skills, skill_count
FROM remote_job_skills as   rjs
INNER JOIN skills_dim as skd ON skd.skill_id =  rjs.skill_id;